import 'package:drift/drift.dart' hide Column;
import 'dart:math';
import 'database.dart';
import 'main.dart';

double _log10(double x) => (x <= 0) ? 0 : (x.isNaN ? 0 : (log(x) / log(10)));

// ---------------- MENÜLER ----------------

Future<List<Menu>> hazirMenuleriListele() {
  return (database.select(database.menuler)..where((m) => m.tur.equals('hazir'))).get();
}

Future<List<Menu>> kullaniciMenulerini() {
  return (database.select(database.menuler)..where((m) => m.tur.equals('kullanici'))).get();
}

Future<List<(MenuOgesi, Besin)>> menuOgeleriGetir(int menuId) async {
  final sorgu = database.select(database.menuOgeleri).join([
    innerJoin(database.besinler, database.besinler.id.equalsExp(database.menuOgeleri.besinId)),
  ])
    ..where(database.menuOgeleri.menuId.equals(menuId));

  final sonuc = await sorgu.get();
  return sonuc.map((satir) {
    final oge = satir.readTable(database.menuOgeleri);
    final besin = satir.readTable(database.besinler);
    return (oge, besin);
  }).toList();
}

Future<Menu> menuOlustur(String isim, {String tur = 'kullanici'}) async {
  final id = await database.into(database.menuler).insert(
        MenulerCompanion.insert(menuAdi: isim, tur: Value(tur)),
      );
  return (database.select(database.menuler)..where((m) => m.id.equals(id))).getSingle();
}

Future<void> menuyeBesinEkle(int menuId, int besinId, double miktar) async {
  await database.into(database.menuOgeleri).insert(
        MenuOgeleriCompanion.insert(menuId: menuId, besinId: besinId, miktar: miktar),
      );
}

Future<void> menudenBesinCikar(int ogeId) async {
  await (database.delete(database.menuOgeleri)..where((o) => o.id.equals(ogeId))).go();
}

Future<void> menuSil(int menuId) async {
  await (database.delete(database.menuOgeleri)..where((o) => o.menuId.equals(menuId))).go();
  await (database.delete(database.menuler)..where((m) => m.id.equals(menuId))).go();
}

Future<Menu> menuKopyala(int menuId, String yeniIsim) async {
  final ogeler = await menuOgeleriGetir(menuId);
  final yeniMenu = await menuOlustur(yeniIsim, tur: 'kullanici');
  for (final (oge, _) in ogeler) {
    await menuyeBesinEkle(yeniMenu.id, oge.besinId, oge.miktar);
  }
  return yeniMenu;
}

Map<String, double> menuToplamHesapla(List<(MenuOgesi, Besin)> ogeler) {
  final toplam = {'kalori': 0.0, 'karb': 0.0, 'pro': 0.0, 'yag': 0.0};
  for (final (oge, besin) in ogeler) {
    toplam['kalori'] = toplam['kalori']! + ((besin.kalori ?? 0) * oge.miktar) / 100;
    toplam['karb'] = toplam['karb']! + ((besin.karb ?? 0) * oge.miktar) / 100;
    toplam['pro'] = toplam['pro']! + ((besin.pro ?? 0) * oge.miktar) / 100;
    toplam['yag'] = toplam['yag']! + ((besin.yag ?? 0) * oge.miktar) / 100;
  }
  return toplam;
}

const Map<String, List<String>> _esAnlamlilar = {
  'tavuk': ['tavuk', 'piliç', 'chicken'],
  'dana': ['dana', 'beef', 'veal'],
  'kıyma': ['kıyma', 'ground', 'minced'],
  'kuzu': ['kuzu', 'lamb', 'mutton'],
  'hindi': ['hindi', 'turkey'],
  'balık': ['balık', 'fish', 'salmon', 'tuna', 'cod', 'tilapia', 'trout'],
  'karides': ['karides', 'shrimp', 'prawn'],
  'somon': ['somon', 'salmon'],
  'süt': ['süt', 'milk'],
  'yoğurt': ['yoğurt', 'yogurt', 'yoghurt'],
  'peynir': ['peynir', 'cheese'],
  'tereyağı': ['tereyağı', 'butter'],
  'krema': ['krema', 'cream'],
  'ekmek': ['ekmek', 'bread'],
  'pirinç': ['pirinç', 'rice'],
  'makarna': ['makarna', 'pasta', 'noodle', 'spaghetti', 'macaroni'],
  'yulaf': ['yulaf', 'oat', 'oatmeal'],
  'un': ['un', 'flour'],
  'bulgur': ['bulgur'],
  'domates': ['domates', 'tomato'],
  'salatalık': ['salatalık', 'cucumber'],
  'biber': ['biber', 'pepper'],
  'patates': ['patates', 'potato'],
  'soğan': ['soğan', 'onion'],
  'sarımsak': ['sarımsak', 'garlic'],
  'havuç': ['havuç', 'carrot'],
  'brokoli': ['brokoli', 'broccoli'],
  'ıspanak': ['ıspanak', 'spinach'],
  'marul': ['marul', 'lettuce'],
  'kabak': ['kabak', 'zucchini', 'squash'],
  'patlıcan': ['patlıcan', 'eggplant', 'aubergine'],
  'mantar': ['mantar', 'mushroom'],
  'fasulye': ['fasulye', 'bean'],
  'bezelye': ['bezelye', 'pea'],
  'mısır': ['mısır', 'corn', 'maize'],
  'elma': ['elma', 'apple'],
  'muz': ['muz', 'banana'],
  'portakal': ['portakal', 'orange'],
  'çilek': ['çilek', 'strawberry'],
  'üzüm': ['üzüm', 'grape'],
  'karpuz': ['karpuz', 'watermelon'],
  'kavun': ['kavun', 'melon'],
  'kiraz': ['kiraz', 'cherry'],
  'şeftali': ['şeftali', 'peach'],
  'armut': ['armut', 'pear'],
  'ananas': ['ananas', 'pineapple'],
  'mango': ['mango'],
  'kivi': ['kivi', 'kiwi'],
  'limon': ['limon', 'lemon'],
  'mercimek': ['mercimek', 'lentil'],
  'nohut': ['nohut', 'chickpea', 'garbanzo'],
  'badem': ['badem', 'almond'],
  'ceviz': ['ceviz', 'walnut'],
  'fındık': ['fındık', 'hazelnut'],
  'fıstık': ['fıstık', 'peanut', 'pistachio'],
  'kaju': ['kaju', 'cashew'],
  'zeytinyağı': ['zeytinyağı', 'olive oil', 'olive'],
  'ayçiçek': ['ayçiçek', 'sunflower'],
  'yağ': ['yağ', 'oil', 'fat'],
  'su': ['su', 'water'],
  'kahve': ['kahve', 'coffee'],
  'çay': ['çay', 'tea'],
  'yumurta': ['yumurta', 'egg'],
  'bal': ['bal', 'honey'],
  'şeker': ['şeker', 'sugar'],
  'kakao': ['kakao', 'cocoa'],
  'çikolata': ['çikolata', 'chocolate'],
  'et': ['meat', 'beef', 'pork', 'lamb', 'chicken', 'turkey'],
};

Future<List<Besin>> besinleriAra(String anahtar, {int limit = 10}) {
  final anahtarKucuk = anahtar.toLowerCase().trim();

  List<String> aramaTerimleri = [anahtarKucuk];
  for (final entry in _esAnlamlilar.entries) {
    if (anahtarKucuk.contains(entry.key) || entry.key.contains(anahtarKucuk)) {
      aramaTerimleri = entry.value.map((e) => e.toLowerCase()).toList();
      break;
    }
  }

  final ilkTerim = aramaTerimleri[0];

  final sorgu = database.select(database.besinler)
    ..where((b) {
      Expression<bool> filtre = b.isim.like('%$ilkTerim%');
      for (int i = 1; i < aramaTerimleri.length; i++) {
        filtre = filtre | b.isim.like('%${aramaTerimleri[i]}%');
      }
      return filtre;
    })
    ..orderBy([
      (b) => OrderingTerm(expression: b.isim.length),
    ])
    ..limit(limit);

  return sorgu.get();
}

Future<void> gunlukOgeGuncelleGram(int ogeId, double yeniMiktar) async {
  await (database.update(database.gunlukKayitOgeleri)..where((o) => o.id.equals(ogeId))).write(
    GunlukKayitOgeleriCompanion(miktar: Value(yeniMiktar)),
  );
}

// ---------------- GÜNLÜK TAKİP ----------------

String _tarihStr(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

Future<GunlukKayit> gunlukKaydiGetirYaDaOlustur(String tarih) async {
  final mevcut = await (database.select(database.gunlukKayitlar)..where((k) => k.tarih.equals(tarih))).getSingleOrNull();
  if (mevcut != null) return mevcut;

  final id = await database.into(database.gunlukKayitlar).insert(
        GunlukKayitlarCompanion.insert(tarih: tarih),
      );
  return (database.select(database.gunlukKayitlar)..where((k) => k.id.equals(id))).getSingle();
}

Future<void> gunlugeBesinEkle(String tarih, int besinId, double miktar) async {
  final kayit = await gunlukKaydiGetirYaDaOlustur(tarih);
  await database.into(database.gunlukKayitOgeleri).insert(
        GunlukKayitOgeleriCompanion.insert(kayitId: kayit.id, besinId: besinId, miktar: miktar),
      );
}

Future<void> gunlukOgeyiCikar(int ogeId) async {
  await (database.delete(database.gunlukKayitOgeleri)..where((o) => o.id.equals(ogeId))).go();
}

Future<List<(GunlukKayitOgesi, Besin)>> gunlukOgeleriGetir(String tarih) async {
  final kayit = await (database.select(database.gunlukKayitlar)..where((k) => k.tarih.equals(tarih))).getSingleOrNull();
  if (kayit == null) return [];

  final sorgu = database.select(database.gunlukKayitOgeleri).join([
    innerJoin(database.besinler, database.besinler.id.equalsExp(database.gunlukKayitOgeleri.besinId)),
  ])
    ..where(database.gunlukKayitOgeleri.kayitId.equals(kayit.id));

  final sonuc = await sorgu.get();
  return sonuc.map((satir) {
    final oge = satir.readTable(database.gunlukKayitOgeleri);
    final besin = satir.readTable(database.besinler);
    return (oge, besin);
  }).toList();
}

Future<Map<String, double>> gunlukToplamHesapla(String tarih) async {
  final ogeler = await gunlukOgeleriGetir(tarih);
  final toplam = {'kalori': 0.0, 'karb': 0.0, 'pro': 0.0, 'yag': 0.0};
  for (final (oge, besin) in ogeler) {
    toplam['kalori'] = toplam['kalori']! + ((besin.kalori ?? 0) * oge.miktar) / 100;
    toplam['karb'] = toplam['karb']! + ((besin.karb ?? 0) * oge.miktar) / 100;
    toplam['pro'] = toplam['pro']! + ((besin.pro ?? 0) * oge.miktar) / 100;
    toplam['yag'] = toplam['yag']! + ((besin.yag ?? 0) * oge.miktar) / 100;
  }
  return toplam;
}

// ---------------- HEDEF ----------------

Future<KullaniciHedef?> hedefGetir() {
  return database.select(database.kullaniciHedefleri).getSingleOrNull();
}

Future<void> hedefKaydet(double kalori, double karb, double pro, double yag) async {
  final mevcut = await hedefGetir();
  if (mevcut == null) {
    await database.into(database.kullaniciHedefleri).insert(
          KullaniciHedefleriCompanion.insert(kalori: kalori, karb: karb, pro: pro, yag: yag),
        );
  } else {
    await (database.update(database.kullaniciHedefleri)..where((h) => h.id.equals(mevcut.id))).write(
      KullaniciHedefleriCompanion(
        kalori: Value(kalori),
        karb: Value(karb),
        pro: Value(pro),
        yag: Value(yag),
      ),
    );
  }
}

// ---------------- SERİ / PERFORMANS ----------------

Future<int> gunlukSeriHesapla({double tolerans = 0.2}) async {
  final hedef = await hedefGetir();
  if (hedef == null || hedef.kalori <= 0) return 0;

  int seri = 0;
  DateTime gun = DateTime.now();

  while (true) {
    final toplam = await gunlukToplamHesapla(_tarihStr(gun));
    if (toplam['kalori'] == 0) break;

    final oran = toplam['kalori']! / hedef.kalori;
    if ((oran - 1).abs() > tolerans) break;

    seri += 1;
    gun = gun.subtract(const Duration(days: 1));
  }

  return seri;
}

Future<List<(String, double?)>> performansVerisiGetir({int gunSayisi = 84}) async {
  final hedef = await hedefGetir();
  final bugun = DateTime.now();
  final List<(String, double?)> sonuclar = [];

  for (int i = gunSayisi - 1; i >= 0; i--) {
    final gun = bugun.subtract(Duration(days: i));
    final tarihStr = _tarihStr(gun);
    final toplam = await gunlukToplamHesapla(tarihStr);

    double? skor;
    if (toplam['kalori'] == 0 || hedef == null || hedef.kalori <= 0) {
      skor = null;
    } else {
      final oran = toplam['kalori']! / hedef.kalori;
      final sapma = (oran - 1).abs();
      skor = (1 - (sapma / 0.5)).clamp(0.0, 1.0);
    }
    sonuclar.add((tarihStr, skor));
  }

  return sonuclar;
}

// ---------------- ÖLÇÜM GEÇMİŞİ ----------------

Future<void> olcumKaydet({
  String? tarih,
  required String cinsiyet,
  required double kilo,
  double? bel,
  double? boyun,
  double? kalca,
}) async {
  final gercekTarih = tarih ?? _tarihStr(DateTime.now());
  final mevcut = await (database.select(database.olcumler)..where((o) => o.tarih.equals(gercekTarih))).getSingleOrNull();

  if (mevcut == null) {
    await database.into(database.olcumler).insert(
          OlcumlerCompanion.insert(
            tarih: gercekTarih,
            cinsiyet: cinsiyet,
            kilo: kilo,
            bel: Value(bel),
            boyun: Value(boyun),
            kalca: Value(kalca),
          ),
        );
  } else {
    await (database.update(database.olcumler)..where((o) => o.id.equals(mevcut.id))).write(
      OlcumlerCompanion(
        cinsiyet: Value(cinsiyet),
        kilo: Value(kilo),
        bel: Value(bel),
        boyun: Value(boyun),
        kalca: Value(kalca),
      ),
    );
  }
}

Future<Olcum?> enSonOlcumGetir() async {
  final sonuc = await (database.select(database.olcumler)..orderBy([(o) => OrderingTerm(expression: o.tarih, mode: OrderingMode.desc)])..limit(1)).getSingleOrNull();
  return sonuc;
}

Future<List<Olcum>> olcumGecmisiGetir() {
  return (database.select(database.olcumler)..orderBy([(o) => OrderingTerm(expression: o.tarih, mode: OrderingMode.desc)])).get();
}

// ---------------- VÜCUT YAĞ ORANI (sadece Navy Method) ----------------

class YagOraniSonucu {
  final double? deger;
  final String? eksikSebep;
  YagOraniSonucu({this.deger, this.eksikSebep});
}

YagOraniSonucu vucutYagOraniHesapla(Olcum olcum, double? boy) {
  if (boy == null || boy <= 0) {
    return YagOraniSonucu(eksikSebep: 'Yağ oranını görmek için önce boyunu girmelisin.');
  }
  if (olcum.boyun == null || olcum.bel == null) {
    return YagOraniSonucu(eksikSebep: 'Yağ oranını görmek için bel ve boyun ölçünü de girmelisin.');
  }
  if (olcum.cinsiyet == 'kadin' && olcum.kalca == null) {
    return YagOraniSonucu(eksikSebep: 'Kadınlar için yağ oranı hesabında kalça ölçüsü de gerekiyor.');
  }

  double yagOrani;
  if (olcum.cinsiyet == 'erkek') {
    final fark = olcum.bel! - olcum.boyun!;
    if (fark <= 0) return YagOraniSonucu(eksikSebep: 'Ölçüler tutarsız görünüyor, kontrol et.');
    final payda = 1.0324 - 0.19077 * _log10(fark) + 0.15456 * _log10(boy);
    yagOrani = 495 / payda - 450;
  } else {
    final fark = olcum.bel! + olcum.kalca! - olcum.boyun!;
    if (fark <= 0) return YagOraniSonucu(eksikSebep: 'Ölçüler tutarsız görünüyor, kontrol et.');
    final payda = 1.29579 - 0.35004 * _log10(fark) + 0.22100 * _log10(boy);
    yagOrani = 495 / payda - 450;
  }

  final minSinir = olcum.cinsiyet == 'erkek' ? 2.0 : 10.0;
  if (yagOrani < minSinir || yagOrani > 60) {
    return YagOraniSonucu(eksikSebep: 'Hesaplanan sonuç güvenilir aralığın dışında, ölçüleri kontrol et.');
  }

  return YagOraniSonucu(deger: double.parse(yagOrani.toStringAsFixed(1)));
}

String siniflandirmaGetir(String cinsiyet, double yagOrani) {
  List<(double, double, String)> araliklar;
  double obeziteSiniri;

  if (cinsiyet == 'erkek') {
    araliklar = [(0, 5, 'Temel Yağ'), (6, 13, 'Sporcu'), (14, 17, 'Fitness'), (18, 24, 'Kabul Edilebilir Aralık')];
    obeziteSiniri = 25;
  } else {
    araliklar = [(0, 13, 'Temel Yağ'), (14, 20, 'Sporcu'), (21, 24, 'Fitness'), (25, 31, 'Kabul Edilebilir Aralık')];
    obeziteSiniri = 32;
  }

  if (yagOrani >= obeziteSiniri) return 'Obezite';
  for (final (alt, ust, etiket) in araliklar) {
    if (yagOrani >= alt && yagOrani <= ust) return etiket;
  }
  return 'Temel Yağ';
}

double? bkiHesapla(double boyCm, double kiloKg) {
  if (boyCm <= 0 || kiloKg <= 0) return null;
  final boyM = boyCm / 100;
  return double.parse((kiloKg / (boyM * boyM)).toStringAsFixed(1));
}

(double, double)? kiloAraligiHesapla(double boyCm) {
  if (boyCm <= 0) return null;
  final boyM = boyCm / 100;
  final alt = double.parse((18.5 * boyM * boyM).toStringAsFixed(1));
  final ust = double.parse((24.9 * boyM * boyM).toStringAsFixed(1));
  return (alt, ust);
}

// ---------------- KALORİ / MAKRO HESAPLAYICI ----------------

const List<(String, double)> aktiviteDuzeyleri = [
  ('Sedanter, hareketsiz iş ve hayat', 1.2),
  ('Hareketsiz iş ve haftada 1-2 seans spor', 1.375),
  ('Orta aktivite, haftada 3-5 gün vücut geliştirme', 1.55),
  ('Haftada 4-5 yüksek kondisyon gerektiren spor', 1.725),
  ('Aşırı hareketli beden işi veya 5-7 seans çok yoğun kondisyon', 1.9),
];

const List<(String, double)> hedefAyarlari = [
  ('Yağ Kaybetme', -0.20),
  ('Kilo Koruma', 0.0),
  ('Kas Kazanımı', 0.12),
];

Map<String, double> kaloriVeMakroHesapla({
  required double kiloKg,
  required double yagOraniYuzde,
  required double aktiviteCarpani,
  required double hedefAyari,
}) {
  final yagsizKutle = kiloKg * (1 - yagOraniYuzde / 100);
  final bmr = 370 + (21.6 * yagsizKutle);
  final tdee = bmr * aktiviteCarpani;
  final hedefKalori = tdee * (1 + hedefAyari);

  final proteinGram = kiloKg * 2.2;
  final proteinKcal = proteinGram * 4;

  final yagKcal = hedefKalori * 0.25;
  final yagGram = yagKcal / 9;

  final karbKcal = hedefKalori - proteinKcal - yagKcal;
  final karbGram = (karbKcal / 4).clamp(0, double.infinity);

  return {
    'kalori': hedefKalori,
    'pro': proteinGram,
    'yag': yagGram,
    'karb': karbGram.toDouble(),
  };
}

Future<double?> boyGetir() async {
  final sonuc = await database.select(database.kullaniciAyarlari).getSingleOrNull();
  return sonuc?.boy;
}

Future<void> boyKaydet(double boy) async {
  final mevcut = await database.select(database.kullaniciAyarlari).getSingleOrNull();
  if (mevcut == null) {
    await database.into(database.kullaniciAyarlari).insert(
          KullaniciAyarlariCompanion.insert(boy: boy),
        );
  } else {
    await (database.update(database.kullaniciAyarlari)..where((k) => k.id.equals(mevcut.id))).write(
      KullaniciAyarlariCompanion(boy: Value(boy)),
    );
  }
}

