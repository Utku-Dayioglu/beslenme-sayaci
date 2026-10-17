import 'package:flutter/material.dart';
import '../database.dart';
import '../veri_islemleri.dart';

class HazirMenulerEkrani extends StatefulWidget {
  const HazirMenulerEkrani({super.key});

  @override
  State<HazirMenulerEkrani> createState() => _HazirMenulerEkraniState();
}

class _HazirMenulerEkraniState extends State<HazirMenulerEkrani> {
  late Future<List<Menu>> menulerFuture;

  @override
  void initState() {
    super.initState();
    menulerFuture = hazirMenuleriListele();
  }

  void yenile() {
    setState(() {
      menulerFuture = hazirMenuleriListele();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hazır Menüler', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
                    return const Center(child: Text('Henüz hazır menü eklenmemiş.'));
                  }
                  return ListView.builder(
                    itemCount: menuler.length,
                    itemBuilder: (context, index) {
                      final menu = menuler[index];
                      return Card(
                        child: ListTile(
                          title: Text(menu.menuAdi),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HazirMenuDetayEkrani(menu: menu),
                              ),
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
          ],
        ),
      ),
    );
  }
}

class HazirMenuDetayEkrani extends StatefulWidget {
  final Menu menu;
  const HazirMenuDetayEkrani({super.key, required this.menu});

  @override
  State<HazirMenuDetayEkrani> createState() => _HazirMenuDetayEkraniState();
}

class _HazirMenuDetayEkraniState extends State<HazirMenuDetayEkrani> {
  List<(MenuOgesi, Besin)> ogeler = [];
  Map<int, TextEditingController> gramControllers = {};
  Map<String, double>? hesaplananToplam;
  bool yukleniyor = true;

  @override
  void initState() {
    super.initState();
    veriyiYukle();
  }

  Future<void> veriyiYukle() async {
    final sonuc = await menuOgeleriGetir(widget.menu.id);
    setState(() {
      ogeler = sonuc;
      gramControllers = {
        for (final (oge, _) in sonuc) oge.id: TextEditingController(text: oge.miktar.toStringAsFixed(0))
      };
      yukleniyor = false;
    });
  }

  void yenidenHesapla() {
    final toplam = {'kalori': 0.0, 'karb': 0.0, 'pro': 0.0, 'yag': 0.0};
    for (final (oge, besin) in ogeler) {
      final gram = double.tryParse(gramControllers[oge.id]!.text) ?? 0;
      if (gram < 0) continue;
      toplam['kalori'] = toplam['kalori']! + ((besin.kalori ?? 0) * gram) / 100;
      toplam['karb'] = toplam['karb']! + ((besin.karb ?? 0) * gram) / 100;
      toplam['pro'] = toplam['pro']! + ((besin.pro ?? 0) * gram) / 100;
      toplam['yag'] = toplam['yag']! + ((besin.yag ?? 0) * gram) / 100;
    }
    setState(() => hesaplananToplam = toplam);
  }

  Future<void> kopyalamaDiyaloguGoster() async {
    final controller = TextEditingController();
    final sonuc = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Menüye İsim Ver'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Örn: Benim Protein Shake'im"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Vazgeç')),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );

    if (sonuc != null && sonuc.isNotEmpty) {
      await menuKopyala(widget.menu.id, sonuc);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kendi menüne kopyalandı!')),
        );
      }
    }
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
                  ...ogeler.map((kayit) {
                    final (oge, besin) = kayit;
                    return Card(
                      child: ListTile(
                        title: Text(besin.isim),
                        trailing: SizedBox(
                          width: 70,
                          child: TextField(
                            controller: gramControllers[oge.id],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(suffixText: 'g'),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: yenidenHesapla,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Yeniden Hesapla'),
                  ),
                  const SizedBox(height: 16),
                  if (hesaplananToplam != null) _statGrid(hesaplananToplam!),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: kopyalamaDiyaloguGoster,
                    icon: const Icon(Icons.bookmark_add),
                    label: const Text('Kendi Menüme Kopyala'),
                  ),
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