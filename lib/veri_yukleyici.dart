import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'database.dart';
import 'package:drift/drift.dart';

class VeriYukleyici {
  final AppDatabase db;

  VeriYukleyici(this.db);

  Future<void> ilkYuklemeyiYapIfGerekliyse() async {
    final mevcutSayi = await db.select(db.besinler).get();
    if (mevcutSayi.isNotEmpty) return;

    // Besinleri yükle
    final besinJson = await rootBundle.loadString('assets/besinler.json');
    final List<dynamic> besinVeri = json.decode(besinJson);

    await db.batch((batch) {
      for (final urun in besinVeri) {
        batch.insert(
          db.besinler,
          BesinlerCompanion.insert(
            isim: urun['isim'] as String,
            kalori: Value(urun['kalori'] as double?),
            karb: Value(urun['karb'] as double?),
            pro: Value(urun['pro'] as double?),
            yag: Value(urun['yag'] as double?),
          ),
        );
      }
    });

    // Hazır menüleri yükle
    final menuJson = await rootBundle.loadString('assets/menuler.json');
    final List<dynamic> menuVeri = json.decode(menuJson);

    for (final menu in menuVeri) {
      final menuId = await db.into(db.menuler).insert(
            MenulerCompanion.insert(
              menuAdi: menu['menu_adi'] as String,
              tur: const Value('hazir'),
            ),
          );

      for (final oge in menu['ogeler']) {
        final besinIsim = oge['besin_isim'] as String;
        final miktar = (oge['miktar'] as num).toDouble();

        final besin = await (db.select(db.besinler)
              ..where((b) => b.isim.equals(besinIsim)))
            .getSingleOrNull();

        if (besin != null) {
          await db.into(db.menuOgeleri).insert(
                MenuOgeleriCompanion.insert(
                  menuId: menuId,
                  besinId: besin.id,
                  miktar: miktar,
                ),
              );
        }
      }
    }
  }
}