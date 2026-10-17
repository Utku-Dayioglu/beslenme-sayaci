import 'package:flutter/material.dart';
import '../database.dart';
import '../veri_islemleri.dart';

class HazirMenuYonetimEkrani extends StatefulWidget {
  const HazirMenuYonetimEkrani({super.key});

  @override
  State<HazirMenuYonetimEkrani> createState() => _HazirMenuYonetimEkraniState();
}

class _HazirMenuYonetimEkraniState extends State<HazirMenuYonetimEkrani> {
  late Future<List<Menu>> menulerFuture;

  @override
  void initState() {
    super.initState();
    menulerFuture = hazirMenuleriListele();
  }

  void yenile() {
    setState(() => menulerFuture = hazirMenuleriListele());
  }

  Future<void> yeniMenuOlustur() async {
    final controller = TextEditingController();
    final isim = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hazır Menü Adı'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Örn: Protein Kahvaltısı'),
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
      final yeniMenu = await menuOlustur(isim, tur: 'hazir');
      if (mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HazirMenuDuzenleEkrani(menu: yeniMenu),
          ),
        );
        yenile();
      }
    }
  }

  Future<void> silmeOnayi(Menu menu) async {
    final onay = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emin misin?'),
        content: Text('"${menu.menuAdi}" silinecek.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hazır Menü Yönetimi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: yeniMenuOlustur,
              icon: const Icon(Icons.add),
              label: const Text('Yeni Hazır Menü Oluştur'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(44)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Menu>>(
                future: menulerFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final menuler = snapshot.data!;
                  if (menuler.isEmpty) return const Center(child: Text('Henüz hazır menü yok.'));
                  return ListView.builder(
                    itemCount: menuler.length,
                    itemBuilder: (context, index) {
                      final menu = menuler[index];
                      return Card(
                        child: ListTile(
                          title: Text(menu.menuAdi),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HazirMenuDuzenleEkrani(menu: menu),
                                    ),
                                  );
                                  yenile();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                onPressed: () => silmeOnayi(menu),
                              ),
                            ],
                          ),
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

class HazirMenuDuzenleEkrani extends StatefulWidget {
  final Menu menu;
  const HazirMenuDuzenleEkrani({super.key, required this.menu});

  @override
  State<HazirMenuDuzenleEkrani> createState() => _HazirMenuDuzenleEkraniState();
}

class _HazirMenuDuzenleEkraniState extends State<HazirMenuDuzenleEkrani> {
  List<(MenuOgesi, Besin)> ogeler = [];
  bool yukleniyor = true;

  final TextEditingController aramaController = TextEditingController();
  final TextEditingController gramController = TextEditingController();
  List<Besin> aramaSonuclari = [];
  Besin? seciliBesin;
  String? hataMesaji;

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
    if (gram == null || gram <= 0) {
      setState(() => hataMesaji = 'Geçerli bir gram değeri gir.');
      return;
    }
    await menuyeBesinEkle(widget.menu.id, seciliBesin!.id, gram);
    setState(() {
      hataMesaji = null;
      seciliBesin = null;
      aramaController.clear();
      gramController.clear();
      aramaSonuclari = [];
    });
    veriyiYukle();
  }

  Future<void> cikar(int ogeId) async {
    await menudenBesinCikar(ogeId);
    veriyiYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.menu.menuAdi)),
      body: yukleniyor
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  const Text('İçindekiler', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  if (ogeler.isEmpty)
                    const Text('Henüz besin eklenmedi.')
                  else
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
                  if (aramaSonuclari.isNotEmpty)
                    Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: aramaSonuclari.length,
                        itemBuilder: (context, i) => ListTile(
                          dense: true,
                          title: Text(aramaSonuclari[i].isim,
                              style: const TextStyle(fontSize: 14)),
                          onTap: () => besinSec(aramaSonuclari[i]),
                        ),
                      ),
                    ),
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
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(hataMesaji!, style: const TextStyle(color: Colors.redAccent)),
                    ),
                ],
              ),
            ),
    );
  }
}