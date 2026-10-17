import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../database.dart';
import '../veri_islemleri.dart';

class GunlukEkrani extends StatefulWidget {
  const GunlukEkrani({super.key});

  @override
  State<GunlukEkrani> createState() => _GunlukEkraniState();
}

class _GunlukEkraniState extends State<GunlukEkrani> {
  DateTime seciliTarih = DateTime.now();

  List<(GunlukKayitOgesi, Besin)> ogeler = [];
  Map<String, double> toplam = {'kalori': 0, 'karb': 0, 'pro': 0, 'yag': 0};
  KullaniciHedef? hedef;
  int seri = 0;
  List<(String, double?)> performansVerisi = [];
  bool yukleniyor = true;

  final TextEditingController aramaController = TextEditingController();
  final TextEditingController gramController = TextEditingController();
  List<Besin> aramaSonuclari = [];
  Besin? seciliBesin;
  String? hataMesaji;
  final Map<int, TextEditingController> gramControllers = {};

  String get tarihStr =>
      '${seciliTarih.year.toString().padLeft(4, '0')}-'
      '${seciliTarih.month.toString().padLeft(2, '0')}-'
      '${seciliTarih.day.toString().padLeft(2, '0')}';

  // Güne göre emoji
  String get gunEmoji {
    final bugun = DateTime.now();
    if (seciliTarih.year == bugun.year &&
        seciliTarih.month == bugun.month &&
        seciliTarih.day == bugun.day) return '☀️';
    if (seciliTarih.isBefore(bugun)) return '⏮️';
    return '🔮';
  }

  @override
  void initState() {
    super.initState();
    veriyiYukle();
  }

  @override
  void dispose() {
    for (final c in gramControllers.values) c.dispose();
    aramaController.dispose();
    gramController.dispose();
    super.dispose();
  }

  Future<void> veriyiYukle() async {
    setState(() => yukleniyor = true);
    final o = await gunlukOgeleriGetir(tarihStr);
    final t = await gunlukToplamHesapla(tarihStr);
    final h = await hedefGetir();
    final s = await gunlukSeriHesapla();
    final p = await performansVerisiGetir();

    for (final c in gramControllers.values) c.dispose();
    gramControllers.clear();
    for (final (oge, _) in o) {
      gramControllers[oge.id] = TextEditingController(
        text: oge.miktar.toStringAsFixed(0),
      );
    }

    setState(() {
      ogeler = o;
      toplam = t;
      hedef = h;
      seri = s;
      performansVerisi = p;
      yukleniyor = false;
    });
  }

  void gunDegistir(int fark) {
    setState(() => seciliTarih = seciliTarih.add(Duration(days: fark)));
    veriyiYukle();
  }

  void bugundeDon() {
    setState(() => seciliTarih = DateTime.now());
    veriyiYukle();
  }

  Future<void> takvimdenSec() async {
    final secilen = await showDatePicker(
      context: context,
      initialDate: seciliTarih,
      firstDate: DateTime(2026, 7, 1),
      lastDate: DateTime(2030, 12, 31),
      locale: const Locale('tr', 'TR'),
      helpText: 'Gün Seç',
      cancelText: 'Vazgeç',
      confirmText: 'Seç',
    );
    if (secilen != null) {
      setState(() => seciliTarih = secilen);
      veriyiYukle();
    }
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
    await gunlugeBesinEkle(tarihStr, seciliBesin!.id, gram);
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
    await gunlukOgeyiCikar(ogeId);
    veriyiYukle();
  }

  Future<void> gramGuncelle(int ogeId) async {
    final controller = gramControllers[ogeId];
    if (controller == null) return;
    final yeniGram = double.tryParse(controller.text.trim());
    if (yeniGram == null || yeniGram <= 0) return;
    await gunlukOgeGuncelleGram(ogeId, yeniGram);
    veriyiYukle();
  }

  Future<void> menudenEkleDiyalog() async {
    final menuler = await kullaniciMenulerini();
    if (!mounted) return;

    if (menuler.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Henüz kayıtlı bir menün yok.')),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Menüden Ekle'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: menuler.length,
            itemBuilder: (context, index) {
              final menu = menuler[index];
              return ListTile(
                title: Text(menu.menuAdi),
                onTap: () async {
                  Navigator.pop(context);
                  await _menuOgeleriniGunlugeEkle(menu.id);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Vazgeç'),
          ),
        ],
      ),
    );
  }

  Future<void> _menuOgeleriniGunlugeEkle(int menuId) async {
    final ogeler = await menuOgeleriGetir(menuId);
    for (final (oge, _) in ogeler) {
      await gunlugeBesinEkle(tarihStr, oge.besinId, oge.miktar);
    }
    veriyiYukle();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Menü günlüğe eklendi!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bugun = DateTime.now();
    final bugunMu = seciliTarih.year == bugun.year &&
        seciliTarih.month == bugun.month &&
        seciliTarih.day == bugun.day;

    final aylar = ['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
        'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    final baslikTarih =
        '${seciliTarih.day} ${aylar[seciliTarih.month - 1]} ${seciliTarih.year}';

    return SafeArea(
      child: yukleniyor
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Başlık + takvim butonu
                Row(
                  children: [
                    Text('$gunEmoji $baslikTarih',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      tooltip: 'Takvimden Seç',
                      onPressed: takvimdenSec,
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Tarih gezinme
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => gunDegistir(-1),
                        child: const Text('‹ Önceki'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (!bugunMu)
                      OutlinedButton(
                          onPressed: bugundeDon,
                          child: const Text('Bugün')),
                    if (!bugunMu) const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => gunDegistir(1),
                        child: const Text('Sonraki ›'),
                      ),
                    ),
                  ],
                ),

                if (seri > 0) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '🔥 $seri günlük seri!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // Hedefe ne kadar kaldı
                if (hedef != null && hedef!.kalori > 0) ...[
                  _hedefKalanKarti(toplam, hedef!),
                  const SizedBox(height: 16),
                ],

                // Besin ekleme kartı
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Ne Yedin?',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextButton.icon(
                              onPressed: menudenEkleDiyalog,
                              icon: const Icon(Icons.playlist_add, size: 18),
                              label: const Text('Menüden Ekle'),
                            ),
                          ],
                        ),
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
                            ElevatedButton(
                                onPressed: ekle,
                                child: const Text('Ekle')),
                          ],
                        ),
                        if (hataMesaji != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(hataMesaji!,
                                style: const TextStyle(
                                    color: Colors.redAccent)),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Yedikler listesi
                const Text('Bugün Yedikleri',
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                if (ogeler.isEmpty)
                  const Text('Bugün henüz bir şey eklenmedi.')
                else
                  ...ogeler.map((kayit) {
                    final (oge, besin) = kayit;
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(besin.isim,
                                      style:
                                          const TextStyle(fontSize: 14)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        child: TextField(
                                          controller:
                                              gramControllers[oge.id],
                                          keyboardType:
                                              TextInputType.number,
                                          decoration:
                                              const InputDecoration(
                                            suffixText: 'g',
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 6),
                                            border: OutlineInputBorder(),
                                          ),
                                          onSubmitted: (_) =>
                                              gramGuncelle(oge.id),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        onPressed: () =>
                                            gramGuncelle(oge.id),
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize:
                                                const Size(40, 28)),
                                        child: const Text('Güncelle',
                                            style:
                                                TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.redAccent, size: 20),
                              onPressed: () => cikar(oge.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                const SizedBox(height: 16),
                _statGrid(toplam),

                if (toplam['kalori']! > 0) ...[
                  const SizedBox(height: 16),
                  const Text('Makro Dağılımı',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  SizedBox(height: 180, child: _pastaGrafik(toplam)),
                ],

                const SizedBox(height: 24),
                const Text('Performans Haritası',
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                _heatmap(performansVerisi),
                const SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _hedefKalanKarti(
      Map<String, double> toplam, KullaniciHedef hedef) {
    final kalanKalori = hedef.kalori - toplam['kalori']!;
    final kalanKarb = hedef.karb - toplam['karb']!;
    final kalanPro = hedef.pro - toplam['pro']!;
    final kalanYag = hedef.yag - toplam['yag']!;

    final tamamlandi = kalanKalori <= 0;

    return Card(
      color: tamamlandi
          ? Colors.green.withOpacity(0.15)
          : Colors.blue.withOpacity(0.08),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  tamamlandi ? Icons.check_circle : Icons.flag_outlined,
                  color: tamamlandi ? Colors.green : const Color(0xFF6C5CE7),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  tamamlandi
                      ? 'Günlük hedefe ulaştın! 🎉'
                      : 'Hedefe ulaşmak için kalan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tamamlandi
                        ? Colors.green
                        : const Color(0xFF6C5CE7),
                  ),
                ),
              ],
            ),
            if (!tamamlandi) ...[
              const SizedBox(height: 12),
              // Kalori progress bar
              _progressSatiri(
                'Kalori',
                toplam['kalori']!,
                hedef.kalori,
                '${kalanKalori.toStringAsFixed(0)} kcal kaldı',
                const Color(0xFF6C5CE7),
              ),
              const SizedBox(height: 8),
              _progressSatiri(
                'Protein',
                toplam['pro']!,
                hedef.pro,
                '${kalanPro.clamp(0, double.infinity).toStringAsFixed(1)} g kaldı',
                const Color(0xFF00B894),
              ),
              const SizedBox(height: 8),
              _progressSatiri(
                'Karbonhidrat',
                toplam['karb']!,
                hedef.karb,
                '${kalanKarb.clamp(0, double.infinity).toStringAsFixed(1)} g kaldı',
                const Color(0xFFF39C12),
              ),
              const SizedBox(height: 8),
              _progressSatiri(
                'Yağ',
                toplam['yag']!,
                hedef.yag,
                '${kalanYag.clamp(0, double.infinity).toStringAsFixed(1)} g kaldı',
                const Color(0xFFE17055),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _progressSatiri(String etiket, double mevcut, double hedefDeger,
      String kalanMetin, Color renk) {
    final oran = (mevcut / hedefDeger).clamp(0.0, 1.0);
    final asimdi = mevcut > hedefDeger;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(etiket,
                style:
                    const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(
              asimdi ? 'Hedef aşıldı!' : kalanMetin,
              style: TextStyle(
                  fontSize: 12,
                  color: asimdi ? Colors.redAccent : Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: oran,
            minHeight: 8,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
                asimdi ? Colors.redAccent : renk),
          ),
        ),
      ],
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
                Text(v.$1,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Text('${v.$2} ${v.$3}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _pastaGrafik(Map<String, double> deger) {
    final karb = deger['karb']! * 4;
    final pro = deger['pro']! * 4;
    final yag = deger['yag']! * 9;
    final toplamKcal = karb + pro + yag;
    if (toplamKcal == 0) return const SizedBox.shrink();

    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
              value: karb,
              color: const Color(0xFF6C5CE7),
              title:
                  'Karb\n${(karb / toplamKcal * 100).toStringAsFixed(0)}%',
              radius: 60,
              titleStyle: const TextStyle(
                  fontSize: 11, color: Colors.white)),
          PieChartSectionData(
              value: pro,
              color: const Color(0xFF00B894),
              title:
                  'Pro\n${(pro / toplamKcal * 100).toStringAsFixed(0)}%',
              radius: 60,
              titleStyle: const TextStyle(
                  fontSize: 11, color: Colors.white)),
          PieChartSectionData(
              value: yag,
              color: const Color(0xFFE17055),
              title:
                  'Yağ\n${(yag / toplamKcal * 100).toStringAsFixed(0)}%',
              radius: 60,
              titleStyle: const TextStyle(
                  fontSize: 11, color: Colors.white)),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 30,
      ),
    );
  }

  Widget _heatmap(List<(String, double?)> veri) {
    const haftalar = 12;
    const gunSayisi = 7;
    final matris = List.generate(
        gunSayisi, (_) => List<double?>.filled(haftalar, null));

    for (int i = 0; i < veri.length; i++) {
      final haftaIdx = i ~/ 7;
      final gunIdx = i % 7;
      if (haftaIdx < haftalar) {
        matris[gunIdx][haftaIdx] = veri[i].$2;
      }
    }

    return SizedBox(
      height: 110,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gunSayisi,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          childAspectRatio: 1,
        ),
        itemCount: haftalar * gunSayisi,
        itemBuilder: (context, index) {
          final haftaIdx = index ~/ gunSayisi;
          final gunIdx = index % gunSayisi;
          final skor = matris[gunIdx][haftaIdx];
          Color renk;
          if (skor == null) {
            renk = const Color(0xFF2C2E37);
          } else {
            final yesil = 0.55 + (skor * 0.45);
            renk = Color.fromRGBO(
              (60 + (1 - skor) * 30).toInt(),
              (yesil * 180).toInt(),
              60,
              1,
            );
          }
          return Container(
            decoration: BoxDecoration(
                color: renk,
                borderRadius: BorderRadius.circular(3)),
          );
        },
      ),
    );
  }
}