import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

// ---------------- TABLOLAR ----------------

@DataClassName('Besin')
class Besinler extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get isim => text()();
  RealColumn get kalori => real().nullable()();
  RealColumn get karb => real().nullable()();
  RealColumn get pro => real().nullable()();
  RealColumn get yag => real().nullable()();
}

@DataClassName('Menu')
class Menuler extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get menuAdi => text()();
  TextColumn get tur => text().withDefault(const Constant('kullanici'))();
}

@DataClassName('MenuOgesi')
class MenuOgeleri extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get menuId => integer().references(Menuler, #id)();
  IntColumn get besinId => integer().references(Besinler, #id)();
  RealColumn get miktar => real()();
}

@DataClassName('GunlukKayit')
class GunlukKayitlar extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tarih => text().unique()();
}

@DataClassName('GunlukKayitOgesi')
class GunlukKayitOgeleri extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get kayitId => integer().references(GunlukKayitlar, #id)();
  IntColumn get besinId => integer().references(Besinler, #id)();
  RealColumn get miktar => real()();
}

@DataClassName('KullaniciHedef')
class KullaniciHedefleri extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get kalori => real()();
  RealColumn get karb => real()();
  RealColumn get pro => real()();
  RealColumn get yag => real()();
}

@DataClassName('Olcum')
class Olcumler extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tarih => text().unique()();
  TextColumn get cinsiyet => text()();
  RealColumn get kilo => real()();
  RealColumn get bel => real().nullable()();
  RealColumn get boyun => real().nullable()();
  RealColumn get kalca => real().nullable()();
}

@DataClassName('KullaniciAyar')
class KullaniciAyarlari extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get boy => real()();
}

// ---------------- VERİTABANI ----------------

@DriftDatabase(tables: [
  Besinler,
  Menuler,
  MenuOgeleri,
  GunlukKayitlar,
  GunlukKayitOgeleri,
  KullaniciHedefleri,
  Olcumler,
  KullaniciAyarlari,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'besinler.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}