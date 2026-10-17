import 'package:flutter/material.dart';
import '../database.dart';
import '../veri_islemleri.dart';

class KendiMenumEkrani extends StatefulWidget {
  const KendiMenumEkrani({super.key});

  @override
  State<KendiMenumEkrani> createState() => _KendiMenumEkraniState();
}

class _KendiMenumEkraniState extends State<KendiMenumEkrani> {
  late Future<List<Menu>> menulerFuture;

  @override
  void initState() {
    super.initState();
    menulerFuture = kullaniciMenulerini();
  }

  void yenile() {
    setState(() {
      menulerFuture = kullaniciMenulerini();
    });
  }

  Future<void> silmeOnayiGoster(Menu menu) async {
    final onay = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emin misin?'),
        content: Text('"${menu.menuAdi}" menüsünü silmek istediğine emin misin?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Vazgeç')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sil', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
    if (onay == true) {
      await menuSil(menu.id);
      yenile();
    }
  }

  Future<void> yeniMenuOlusturDiyalog() async {
    final controller = TextEditingController();
    final isim = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Menüne bir isim ver'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Örn: Kahvaltım'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Vazgeç')),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Oluştur'),
          ),
        ],
      ),
    );

    if (isim != null && isim.isNotEmpty) {
      final yeniMenu = await menuOlustur(isim);
      if (mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KendiMenuDuzenleEkrani(menu: yeniMenu)),
        );
        yenile();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Kendi Menüm', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Menu>>(
                future: menulerFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final menuler = snapshot.data!;
                  if (menuler.isEmpty) {
                    return const Center(child: Text('Henüz bir menün yok, aşağıdan oluşturabilirsin.'));
                  }
                  return ListView.builder(
                    itemCount: menuler.length,
                    itemBuilder: (context, index) {
                      final menu = menuler[index];
                      return Card(
                        child: ListTile(
                          title: Text(menu.menuAdi),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () => silmeOnayiGoster(menu),
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => KendiMenuDuzenleEkrani(menu: menu)),
                            );
                            yenile();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: yeniMenuOlusturDiyalog,
              icon: const Icon(Icons.add),
              label: const Text('Yeni Menü Oluştur'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
          ],
        ),
      ),
    );
  }
}

class KendiMenuDuzenleEkrani extends StatefulWidget {
  final Menu menu;
  const KendiMenuDuzenleEkrani({super.key, required this.menu});

  @override
  State<KendiMenuDuzenleEkrani> createState() => _KendiMenuDuzenleEkraniState();
}

class _KendiMenuDuzenleEkraniState extends State<KendiMenuDuzenleEkrani> {
  List<(MenuOgesi, Besin)> ogeler = [];
  bool yukleniyor = true;

  final TextEditingController aramaController = TextEditingController();
  final TextEditingController gramController = TextEditingController();
  List<Besin> aramaSonuclari = [];
  Besin? seciliBesin;
  String? hataMesaji;
  Map<String, double>? toplam;

  @override
  void initState() {
    super.initState();
    veriyiYukle();
  }

  Future<void> veriyiYukle() async {
    final sonuc = await menuOgeleriGetir(widget.menu.id);
    setState(() {
      ogeler = sonuc;
      yukleniyor = false;
    });
  }

  Future<void> ara(String anahtar) async {
    if (anahtar.trim().length < 2) {
      setState(() => aramaSonuclari = []);
      return;
    }
    final sonuc = await besinleriAra(anahtar);
    setState(() => aramaSonuclari = sonuc);
  }

  void besinSec(Besin besin) {
    setState(() {
      seciliBesin = besin;
      aramaController.text = besin.isim;
      aramaSonuclari = [];
      hataMesaji = null;
    });
  }

  Future<void> ekle() async {
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

    await menuyeBesinEkle(widget.menu.id, seciliBesin!.id, gram);
    setState(() {
      hataMesaji = null;
      seciliBesin = null;
      aramaController.clear();
      gramController.clear();
    });
    veriyiYukle();
  }

  Future<void> cikar(int ogeId) async {
    await menudenBesinCikar(ogeId);
    veriyiYukle();
  }

  void hesapla() {
    setState(() => toplam = menuToplamHesapla(ogeler));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.menu.menuAdi)),
      body: yukleniyor
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const Text('İçindekiler', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  if (ogeler.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Henüz besin eklenmedi.'),
                    ),
                  ...ogeler.map((kayit) {
                    final (oge, besin) = kayit;
                    return Card(
                      child: ListTile(
                        title: Text(besin.isim),
                        subtitle: Text('${oge.miktar.toStringAsFixed(0)} g'),
                        trailing: IconButton(
                          icon: const Icon(Icons.close, color: Colors.redAccent),
                          onPressed: () => cikar(oge.id),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Besin Ekle', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          TextField(
                            controller: aramaController,
                            decoration: const InputDecoration(
                              hintText: 'Besin ara...',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: ara,
                          ),
                          ...aramaSonuclari.map((besin) => ListTile(
                                title: Text(besin.isim),
                                onTap: () => besinSec(besin),
                              )),
                          const SizedBox(height: 8),
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
                              ElevatedButton(onPressed: ekle, child: const Text('Ekle')),
                            ],
                          ),
                          if (hataMesaji != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(hataMesaji!, style: const TextStyle(color: Colors.redAccent)),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: hesapla,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Toplamı Hesapla'),
                  ),
                  const SizedBox(height: 16),
                  if (toplam != null) _statGrid(toplam!),
                ],
              ),
            ),
    );
  }

  Widget _statGrid(Map<String, double> deger) {
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