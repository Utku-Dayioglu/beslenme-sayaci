import 'package:flutter/material.dart';
import 'database.dart';
import 'veri_yukleyici.dart';
import 'ekranlar/gunluk_ekrani.dart';
import 'ekranlar/hazir_menuler_ekrani.dart';
import 'ekranlar/kendi_menum_ekrani.dart';
import 'ekranlar/urunler_ekrani.dart';
import 'ekranlar/ayarlar_ekrani.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = AppDatabase();
  await VeriYukleyici(database).ilkYuklemeyiYapIfGerekliyse();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', 'TR'),
],
      title: 'Beslenme Sayacı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF15161A),
      ),
      home: const AnaEkran(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  int seciliIndex = 0;

  final List<Widget> ekranlar = const [
    GunlukEkrani(),
    HazirMenulerEkrani(),
    KendiMenumEkrani(),
    UrunlerEkrani(),
    AyarlarEkrani(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: seciliIndex,
        children: ekranlar,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: seciliIndex,
        onDestinationSelected: (index) {
          setState(() {
            seciliIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.calendar_today), label: 'Günlük'),
          NavigationDestination(icon: Icon(Icons.restaurant), label: 'Hazır'),
          NavigationDestination(icon: Icon(Icons.edit_note), label: 'Menüm'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Ürünler'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Ayarlar'),
        ],
      ),
    );
  }
}