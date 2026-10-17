import 'package:flutter/material.dart';
import '../database.dart';
import '../veri_islemleri.dart';

class AyarlarEkrani extends StatefulWidget {
  const AyarlarEkrani({super.key});

  @override
  State<AyarlarEkrani> createState() => _AyarlarEkraniState();
}

class _AyarlarEkraniState extends State<AyarlarEkrani> {
  // Hedef
  final hedefKaloriC = TextEditingController();
  final hedefKarbC = TextEditingController();
  final hedefProC = TextEditingController();
  final hedefYagC = TextEditingController();
  String? hedefHata;

  // Profil (boy ayrı, diğerleri ölçüm)
  final boyC = TextEditingController();
  String cinsiyet = 'erkek';
  final kiloC = TextEditingController();
  final belC = TextEditingController();
  final boyunC = TextEditingController();
  final kalcaC = TextEditingController();
  String? profilHata;

  // Sonuçlar
  YagOraniSonucu? yagOraniSonucu;
  double? bki;
  (double, double)? kiloAraligi;

  // Geçmiş
  List<Olcum> gecmis = [];

  @override
  void initState() {
    super.initState();
    verileriYukle();
  }

  Future<void> verileriYukle() async {
    final hedef = await hedefGetir();
    if (hedef != null) {
      hedefKaloriC.text = hedef.kalori.toStringAsFixed(0);
      hedefKarbC.text = hedef.karb.toStringAsFixed(0);
      hedefProC.text = hedef.pro.toStringAsFixed(0);
      hedefYagC.text = hedef.yag.toStringAsFixed(0);
    }

    final boy = await boyGetir();
    if (boy != null) boyC.text = boy.toStringAsFixed(0);

    final sonOlcum = await enSonOlcumGetir();
    if (sonOlcum != null) {
      setState(() {
        cinsiyet = sonOlcum.cinsiyet;
        kiloC.text = sonOlcum.kilo.toStringAsFixed(1);
        belC.text = sonOlcum.bel?.toStringAsFixed(0) ?? '';
        boyunC.text = sonOlcum.boyun?.toStringAsFixed(0) ?? '';
        kalcaC.text = sonOlcum.kalca?.toStringAsFixed(0) ?? '';
      });
      sonuclariHesapla(sonOlcum, boy);
    }

    final g = await olcumGecmisiGetir();
    setState(() => gecmis = g);
  }

  Future<void> hedefleriKaydet() async {
    final kalori = double.tryParse(hedefKaloriC.text.trim());
    final karb = double.tryParse(hedefKarbC.text.trim());
    final pro = double.tryParse(hedefProC.text.trim());
    final yag = double.tryParse(hedefYagC.text.trim());

    if (kalori == null || karb == null || pro == null || yag == null) {
      setState(() => hedefHata = 'Tüm alanlara geçerli sayılar gir.');
      return;
    }
    if (kalori <= 0) {
      setState(() => hedefHata = 'Kalori hedefi sıfırdan büyük olmalı.');
      return;
    }
    if (karb < 0 || pro < 0 || yag < 0) {
      setState(() => hedefHata = 'Negatif değer girilemez.');
      return;
    }

    setState(() => hedefHata = null);
    await hedefKaydet(kalori, karb, pro, yag);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hedefler kaydedildi.')),
      );
    }
  }

  void sonuclariHesapla(Olcum olcum, double? boy) {
    setState(() {
      yagOraniSonucu = vucutYagOraniHesapla(olcum, boy);
      bki = (boy != null && boy > 0) ? bkiHesapla(boy, olcum.kilo) : null;
      kiloAraligi = (boy != null && boy > 0) ? kiloAraligiHesapla(boy) : null;
    });
  }

  Future<void> olcumKaydetVeHesapla() async {
    final kilo = double.tryParse(kiloC.text.trim());
    final boy = double.tryParse(boyC.text.trim());
    final bel = double.tryParse(belC.text.trim());
    final boyun = double.tryParse(boyunC.text.trim());
    final kalcaMetin = kalcaC.text.trim();
    final kalca = kalcaMetin.isEmpty ? null : double.tryParse(kalcaMetin);

    if (kilo == null || kilo <= 0) {
      setState(() => profilHata = 'Kilo alanı zorunlu ve sıfırdan büyük olmalı.');
      return;
    }

    setState(() => profilHata = null);

    if (boy != null && boy > 0) await boyKaydet(boy);

    await olcumKaydet(
      cinsiyet: cinsiyet,
      kilo: kilo,
      bel: (bel != null && bel > 0) ? bel : null,
      boyun: (boyun != null && boyun > 0) ? boyun : null,
      kalca: kalca,
    );

    final sonOlcum = await enSonOlcumGetir();
    final guncellBoy = await boyGetir();
    if (sonOlcum != null) sonuclariHesapla(sonOlcum, guncellBoy);

    final g = await olcumGecmisiGetir();
    setState(() => gecmis = g);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ölçüm kaydedildi.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Ayarlar', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // ---- Günlük Hedefler ----
            const Text('Günlük Hedeflerin', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(controller: hedefKaloriC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Kalori (kcal)')),
                    TextField(controller: hedefKarbC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Karbonhidrat (g)')),
                    TextField(controller: hedefProC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Protein (g)')),
                    TextField(controller: hedefYagC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Yağ (g)')),
                    if (hedefHata != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(hedefHata!, style: const TextStyle(color: Colors.redAccent)),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: hedefleriKaydet,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(44)),
              child: const Text('Hedefleri Kaydet'),
              
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KaloriHesaplaEkrani()),
              ).then((_) => verileriYukle()),
              icon: const Icon(Icons.calculate),
              label: const Text('Kalori Hesaplayıcı'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(44)),
            ),

            const SizedBox(height: 24),

            // ---- Günlük Ölçüm ----
            const Text('Günlük Ölçüm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Her gün kaydettiğin ölçümler geçmişe eklenir.', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: 'erkek', label: Text('Erkek')),
                        ButtonSegment(value: 'kadin', label: Text('Kadın')),
                      ],
                      selected: {cinsiyet},
                      onSelectionChanged: (s) => setState(() => cinsiyet = s.first),
                    ),
                    const SizedBox(height: 8),
                    TextField(controller: boyC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Boy (cm) — değişmiyorsa tekrar girme')),
                    TextField(controller: kiloC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Kilo (kg) — zorunlu')),
                    TextField(controller: belC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Bel Çevresi (cm) — opsiyonel')),
                    TextField(controller: boyunC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Boyun Çevresi (cm) — opsiyonel')),
                    TextField(controller: kalcaC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Kalça Çevresi (cm) — sadece kadın')),
                    if (profilHata != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(profilHata!, style: const TextStyle(color: Colors.redAccent)),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: olcumKaydetVeHesapla,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(44)),
              child: const Text('Ölçümü Kaydet'),
            ),

            const SizedBox(height: 16),

            // ---- Hesaplanan Sonuçlar ----
            if (yagOraniSonucu != null) ...[
              if (yagOraniSonucu!.deger != null)
                Card(
                  child: ListTile(
                    title: const Text('Vücut Yağ Oranı', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    subtitle: Text(
                      '%${yagOraniSonucu!.deger}  ·  ${siniflandirmaGetir(cinsiyet, yagOraniSonucu!.deger!)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              else
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.orangeAccent, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            yagOraniSonucu!.eksikSebep ?? '',
                            style: const TextStyle(color: Colors.orangeAccent, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],

            if (bki != null)
              Card(
                child: ListTile(
                  title: const Text('BKİ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text('$bki', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),

            if (kiloAraligi != null)
              Card(
                child: ListTile(
                  title: const Text('İdeal Kilo Aralığın', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(
                    '${kiloAraligi!.$1} kg – ${kiloAraligi!.$2} kg',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // ---- Ölçüm Geçmişi ----
            if (gecmis.isNotEmpty) ...[
              const Text('Ölçüm Geçmişi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...gecmis.map((o) => Card(
                    child: ListTile(
                      title: Text(o.tarih, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        '${o.kilo} kg'
                        '${o.bel != null ? '  ·  Bel: ${o.bel} cm' : ''}'
                        '${o.boyun != null ? '  ·  Boyun: ${o.boyun} cm' : ''}'
                        '${o.kalca != null ? '  ·  Kalça: ${o.kalca} cm' : ''}',
                      ),
                    ),
                  )),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ---------------- KALORİ HESAPLAYICI EKRANI ----------------

class KaloriHesaplaEkrani extends StatefulWidget {
  const KaloriHesaplaEkrani({super.key});

  @override
  State<KaloriHesaplaEkrani> createState() => _KaloriHesaplaEkraniState();
}

class _KaloriHesaplaEkraniState extends State<KaloriHesaplaEkrani> {
  int seciliAktivite = 2;
  int seciliHedef = 0;
  Map<String, double>? sonuc;
  String? hata;

  double? mevcutKilo;
  double? mevcutYagOrani;

  @override
  void initState() {
    super.initState();
    _verileriYukle();
  }

  Future<void> _verileriYukle() async {
    final sonOlcum = await enSonOlcumGetir();
    final boy = await boyGetir();
    if (sonOlcum != null) {
      final yagSonucu = vucutYagOraniHesapla(sonOlcum, boy);
      setState(() {
        mevcutKilo = sonOlcum.kilo;
        mevcutYagOrani = yagSonucu.deger;
      });
    }
  }

  void hesapla() {
    if (mevcutKilo == null) {
      setState(() => hata = 'Önce Ayarlar\'dan kilo girmelisin.');
      return;
    }
    if (mevcutYagOrani == null) {
      setState(() => hata = 'Yağ oranı hesaplanamadı. Bel, boyun (kadınlarda kalça) ve boy ölçülerini Ayarlar\'dan gir.');
      return;
    }

    setState(() {
      hata = null;
      sonuc = kaloriVeMakroHesapla(
        kiloKg: mevcutKilo!,
        yagOraniYuzde: mevcutYagOrani!,
        aktiviteCarpani: aktiviteDuzeyleri[seciliAktivite].$2,
        hedefAyari: hedefAyarlari[seciliHedef].$2,
      );
    });
  }

  Future<void> hedefeYaz() async {
    if (sonuc == null) return;
    await hedefKaydet(sonuc!['kalori']!, sonuc!['karb']!, sonuc!['pro']!, sonuc!['yag']!);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Günlük hedef güncellendi!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalori Hesaplayıcı')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (mevcutKilo != null)
              Card(
                child: ListTile(
                  title: const Text('Mevcut bilgilerin', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(
                    '${mevcutKilo} kg  ·  ${mevcutYagOrani != null ? '%$mevcutYagOrani yağ oranı' : 'Yağ oranı eksik'}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            const SizedBox(height: 16),
            const Text('Aktivite Düzeyi', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...aktiviteDuzeyleri.asMap().entries.map((e) => RadioListTile<int>(
                  title: Text(e.value.$1, style: const TextStyle(fontSize: 14)),
                  value: e.key,
                  groupValue: seciliAktivite,
                  onChanged: (v) => setState(() => seciliAktivite = v!),
                )),

            const SizedBox(height: 16),
            const Text('Amacın', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...hedefAyarlari.asMap().entries.map((e) => RadioListTile<int>(
                  title: Text(e.value.$1, style: const TextStyle(fontSize: 14)),
                  value: e.key,
                  groupValue: seciliHedef,
                  onChanged: (v) => setState(() => seciliHedef = v!),
                )),

            if (hata != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(hata!, style: const TextStyle(color: Colors.redAccent)),
              ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: hesapla,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(44)),
              child: const Text('Hesapla'),
            ),

            if (sonuc != null) ...[
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  ('Kalori', '${sonuc!['kalori']!.toStringAsFixed(0)} kcal'),
                  ('Protein', '${sonuc!['pro']!.toStringAsFixed(0)} g'),
                  ('Karbonhidrat', '${sonuc!['karb']!.toStringAsFixed(0)} g'),
                  ('Yağ', '${sonuc!['yag']!.toStringAsFixed(0)} g'),
                ].map((v) => Card(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(v.$1, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 4),
                            Text(v.$2, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )).toList(),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: hedefeYaz,
                icon: const Icon(Icons.check),
                label: const Text('Günlük Hedef Olarak Kaydet'),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(44)),
              ),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

