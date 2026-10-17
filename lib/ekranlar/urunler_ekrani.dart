import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import '../database.dart';
import '../main.dart';

class UrunlerEkrani extends StatefulWidget {
  const UrunlerEkrani({super.key});

  @override
  State<UrunlerEkrani> createState() => _UrunlerEkraniState();
}

class _UrunlerEkraniState extends State<UrunlerEkrani> {
  final TextEditingController aramaController = TextEditingController();
  final TextEditingController gramController = TextEditingController();

  List<Besin> sonuclar = [];
  Besin? seciliBesin;
  Map<String, double>? hesaplananDeger;
  String? hataMesaji;

  Future<void> ara(String anahtar) async {
    if (anahtar.trim().length < 2) {
      setState(() => sonuclar = []);
      return;
    }

    final sorgu = database.select(database.besinler)
      ..where((b) => b.isim.like('%$anahtar%'))
      ..orderBy([(b) => OrderingTerm(expression: b.isim.length)])
      ..limit(8);

    final bulunanlar = await sorgu.get();
    setState(() => sonuclar = bulunanlar);
  }

  void besinSec(Besin besin) {
    setState(() {
      seciliBesin = besin;
      aramaController.text = besin.isim;
      sonuclar = [];
      hataMesaji = null;
    });
  }

  void hesapla() {
    if (seciliBesin == null) {
      setState(() => hataMesaji = 'Önce listeden bir besin seç.');
      return;
    }

    final gram = double.tryParse(gramController.text.trim());
    if (gram == null) {
      setState(() => hataMesaji = 'Gram alanına geçerli bir sayı gir.');
      return;
    }
    if (gram <= 0) {
      setState(() => hataMesaji = 'Gram sıfırdan büyük olmalı.');
      return;
    }

    final besin = seciliBesin!;
    setState(() {
      hataMesaji = null;
      hesaplananDeger = {
        'kalori': ((besin.kalori ?? 0) * gram) / 100,
        'karb': ((besin.karb ?? 0) * gram) / 100,
        'pro': ((besin.pro ?? 0) * gram) / 100,
        'yag': ((besin.yag ?? 0) * gram) / 100,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Ürünler', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Tek bir ürünün besin değerini merak mı ediyorsun?'),
            const SizedBox(height: 12),
            TextField(
              controller: aramaController,
              decoration: const InputDecoration(
                hintText: 'Besin ara... (örn. yoğurt)',
                border: OutlineInputBorder(),
              ),
              onChanged: ara,
            ),
            const SizedBox(height: 8),
            ...sonuclar.map((besin) => Card(
                  child: ListTile(
                    title: Text(besin.isim),
                    onTap: () => besinSec(besin),
                  ),
                )),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: gramController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Gram',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: hesapla,
                  child: const Text('Hesapla'),
                ),
              ],
            ),
            if (hataMesaji != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(hataMesaji!, style: const TextStyle(color: Colors.redAccent)),
              ),
            const SizedBox(height: 20),
            if (hesaplananDeger != null) _sonucGridiOlustur(hesaplananDeger!),
          ],
        ),
      ),
    );
  }

  Widget _sonucGridiOlustur(Map<String, double> deger) {
    final veriler = [
      ('Kalori', deger['kalori']!.toStringAsFixed(0), 'kcal'),
      ('Protein', deger['pro']!.toStringAsFixed(1), 'g'),
      ('Karbonhidrat', deger['karb']!.toStringAsFixed(1), 'g'),
      ('Yağ', deger['yag']!.toStringAsFixed(1), 'g'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: veriler.map((v) {
        return Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(v.$1, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Text('${v.$2} ${v.$3}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}