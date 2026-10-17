import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'database.dart';
import 'package:drift/drift.dart';

class VeriYukleyici {
  final AppDatabase db;

  VeriYukleyici(this.db);

  Future<void> ilkYuklemeyiYapIfGerekliyse() async {
    // Eğer veritabanında zaten besin varsa, tekrar yükleme
    final mevcutSayi = await db.select(db.besinler).get();
    if (mevcutSayi.isNotEmpty) {
      return;
    }

    final jsonMetin = await rootBundle.loadString('assets/besinler.json');
    final List<dynamic> veri = json.decode(jsonMetin);

    await db.batch((batch) {
      for (final urun in veri) {
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
  }
}