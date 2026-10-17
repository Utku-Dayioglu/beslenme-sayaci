// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BesinlerTable extends Besinler with TableInfo<$BesinlerTable, Besin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BesinlerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _isimMeta = const VerificationMeta('isim');
  @override
  late final GeneratedColumn<String> isim = GeneratedColumn<String>(
    'isim',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kaloriMeta = const VerificationMeta('kalori');
  @override
  late final GeneratedColumn<double> kalori = GeneratedColumn<double>(
    'kalori',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _karbMeta = const VerificationMeta('karb');
  @override
  late final GeneratedColumn<double> karb = GeneratedColumn<double>(
    'karb',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proMeta = const VerificationMeta('pro');
  @override
  late final GeneratedColumn<double> pro = GeneratedColumn<double>(
    'pro',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yagMeta = const VerificationMeta('yag');
  @override
  late final GeneratedColumn<double> yag = GeneratedColumn<double>(
    'yag',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, isim, kalori, karb, pro, yag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'besinler';
  @override
  VerificationContext validateIntegrity(
    Insertable<Besin> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('isim')) {
      context.handle(
        _isimMeta,
        isim.isAcceptableOrUnknown(data['isim']!, _isimMeta),
      );
    } else if (isInserting) {
      context.missing(_isimMeta);
    }
    if (data.containsKey('kalori')) {
      context.handle(
        _kaloriMeta,
        kalori.isAcceptableOrUnknown(data['kalori']!, _kaloriMeta),
      );
    }
    if (data.containsKey('karb')) {
      context.handle(
        _karbMeta,
        karb.isAcceptableOrUnknown(data['karb']!, _karbMeta),
      );
    }
    if (data.containsKey('pro')) {
      context.handle(
        _proMeta,
        pro.isAcceptableOrUnknown(data['pro']!, _proMeta),
      );
    }
    if (data.containsKey('yag')) {
      context.handle(
        _yagMeta,
        yag.isAcceptableOrUnknown(data['yag']!, _yagMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Besin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Besin(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isim: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isim'],
      )!,
      kalori: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kalori'],
      ),
      karb: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}karb'],
      ),
      pro: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pro'],
      ),
      yag: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}yag'],
      ),
    );
  }

  @override
  $BesinlerTable createAlias(String alias) {
    return $BesinlerTable(attachedDatabase, alias);
  }
}

class Besin extends DataClass implements Insertable<Besin> {
  final int id;
  final String isim;
  final double? kalori;
  final double? karb;
  final double? pro;
  final double? yag;
  const Besin({
    required this.id,
    required this.isim,
    this.kalori,
    this.karb,
    this.pro,
    this.yag,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['isim'] = Variable<String>(isim);
    if (!nullToAbsent || kalori != null) {
      map['kalori'] = Variable<double>(kalori);
    }
    if (!nullToAbsent || karb != null) {
      map['karb'] = Variable<double>(karb);
    }
    if (!nullToAbsent || pro != null) {
      map['pro'] = Variable<double>(pro);
    }
    if (!nullToAbsent || yag != null) {
      map['yag'] = Variable<double>(yag);
    }
    return map;
  }

  BesinlerCompanion toCompanion(bool nullToAbsent) {
    return BesinlerCompanion(
      id: Value(id),
      isim: Value(isim),
      kalori: kalori == null && nullToAbsent
          ? const Value.absent()
          : Value(kalori),
      karb: karb == null && nullToAbsent ? const Value.absent() : Value(karb),
      pro: pro == null && nullToAbsent ? const Value.absent() : Value(pro),
      yag: yag == null && nullToAbsent ? const Value.absent() : Value(yag),
    );
  }

  factory Besin.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Besin(
      id: serializer.fromJson<int>(json['id']),
      isim: serializer.fromJson<String>(json['isim']),
      kalori: serializer.fromJson<double?>(json['kalori']),
      karb: serializer.fromJson<double?>(json['karb']),
      pro: serializer.fromJson<double?>(json['pro']),
      yag: serializer.fromJson<double?>(json['yag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isim': serializer.toJson<String>(isim),
      'kalori': serializer.toJson<double?>(kalori),
      'karb': serializer.toJson<double?>(karb),
      'pro': serializer.toJson<double?>(pro),
      'yag': serializer.toJson<double?>(yag),
    };
  }

  Besin copyWith({
    int? id,
    String? isim,
    Value<double?> kalori = const Value.absent(),
    Value<double?> karb = const Value.absent(),
    Value<double?> pro = const Value.absent(),
    Value<double?> yag = const Value.absent(),
  }) => Besin(
    id: id ?? this.id,
    isim: isim ?? this.isim,
    kalori: kalori.present ? kalori.value : this.kalori,
    karb: karb.present ? karb.value : this.karb,
    pro: pro.present ? pro.value : this.pro,
    yag: yag.present ? yag.value : this.yag,
  );
  Besin copyWithCompanion(BesinlerCompanion data) {
    return Besin(
      id: data.id.present ? data.id.value : this.id,
      isim: data.isim.present ? data.isim.value : this.isim,
      kalori: data.kalori.present ? data.kalori.value : this.kalori,
      karb: data.karb.present ? data.karb.value : this.karb,
      pro: data.pro.present ? data.pro.value : this.pro,
      yag: data.yag.present ? data.yag.value : this.yag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Besin(')
          ..write('id: $id, ')
          ..write('isim: $isim, ')
          ..write('kalori: $kalori, ')
          ..write('karb: $karb, ')
          ..write('pro: $pro, ')
          ..write('yag: $yag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, isim, kalori, karb, pro, yag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Besin &&
          other.id == this.id &&
          other.isim == this.isim &&
          other.kalori == this.kalori &&
          other.karb == this.karb &&
          other.pro == this.pro &&
          other.yag == this.yag);
}

class BesinlerCompanion extends UpdateCompanion<Besin> {
  final Value<int> id;
  final Value<String> isim;
  final Value<double?> kalori;
  final Value<double?> karb;
  final Value<double?> pro;
  final Value<double?> yag;
  const BesinlerCompanion({
    this.id = const Value.absent(),
    this.isim = const Value.absent(),
    this.kalori = const Value.absent(),
    this.karb = const Value.absent(),
    this.pro = const Value.absent(),
    this.yag = const Value.absent(),
  });
  BesinlerCompanion.insert({
    this.id = const Value.absent(),
    required String isim,
    this.kalori = const Value.absent(),
    this.karb = const Value.absent(),
    this.pro = const Value.absent(),
    this.yag = const Value.absent(),
  }) : isim = Value(isim);
  static Insertable<Besin> custom({
    Expression<int>? id,
    Expression<String>? isim,
    Expression<double>? kalori,
    Expression<double>? karb,
    Expression<double>? pro,
    Expression<double>? yag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isim != null) 'isim': isim,
      if (kalori != null) 'kalori': kalori,
      if (karb != null) 'karb': karb,
      if (pro != null) 'pro': pro,
      if (yag != null) 'yag': yag,
    });
  }

  BesinlerCompanion copyWith({
    Value<int>? id,
    Value<String>? isim,
    Value<double?>? kalori,
    Value<double?>? karb,
    Value<double?>? pro,
    Value<double?>? yag,
  }) {
    return BesinlerCompanion(
      id: id ?? this.id,
      isim: isim ?? this.isim,
      kalori: kalori ?? this.kalori,
      karb: karb ?? this.karb,
      pro: pro ?? this.pro,
      yag: yag ?? this.yag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isim.present) {
      map['isim'] = Variable<String>(isim.value);
    }
    if (kalori.present) {
      map['kalori'] = Variable<double>(kalori.value);
    }
    if (karb.present) {
      map['karb'] = Variable<double>(karb.value);
    }
    if (pro.present) {
      map['pro'] = Variable<double>(pro.value);
    }
    if (yag.present) {
      map['yag'] = Variable<double>(yag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BesinlerCompanion(')
          ..write('id: $id, ')
          ..write('isim: $isim, ')
          ..write('kalori: $kalori, ')
          ..write('karb: $karb, ')
          ..write('pro: $pro, ')
          ..write('yag: $yag')
          ..write(')'))
        .toString();
  }
}

class $MenulerTable extends Menuler with TableInfo<$MenulerTable, Menu> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenulerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _menuAdiMeta = const VerificationMeta(
    'menuAdi',
  );
  @override
  late final GeneratedColumn<String> menuAdi = GeneratedColumn<String>(
    'menu_adi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _turMeta = const VerificationMeta('tur');
  @override
  late final GeneratedColumn<String> tur = GeneratedColumn<String>(
    'tur',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('kullanici'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, menuAdi, tur];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menuler';
  @override
  VerificationContext validateIntegrity(
    Insertable<Menu> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('menu_adi')) {
      context.handle(
        _menuAdiMeta,
        menuAdi.isAcceptableOrUnknown(data['menu_adi']!, _menuAdiMeta),
      );
    } else if (isInserting) {
      context.missing(_menuAdiMeta);
    }
    if (data.containsKey('tur')) {
      context.handle(
        _turMeta,
        tur.isAcceptableOrUnknown(data['tur']!, _turMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Menu map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Menu(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      menuAdi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}menu_adi'],
      )!,
      tur: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tur'],
      )!,
    );
  }

  @override
  $MenulerTable createAlias(String alias) {
    return $MenulerTable(attachedDatabase, alias);
  }
}

class Menu extends DataClass implements Insertable<Menu> {
  final int id;
  final String menuAdi;
  final String tur;
  const Menu({required this.id, required this.menuAdi, required this.tur});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['menu_adi'] = Variable<String>(menuAdi);
    map['tur'] = Variable<String>(tur);
    return map;
  }

  MenulerCompanion toCompanion(bool nullToAbsent) {
    return MenulerCompanion(
      id: Value(id),
      menuAdi: Value(menuAdi),
      tur: Value(tur),
    );
  }

  factory Menu.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Menu(
      id: serializer.fromJson<int>(json['id']),
      menuAdi: serializer.fromJson<String>(json['menuAdi']),
      tur: serializer.fromJson<String>(json['tur']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'menuAdi': serializer.toJson<String>(menuAdi),
      'tur': serializer.toJson<String>(tur),
    };
  }

  Menu copyWith({int? id, String? menuAdi, String? tur}) => Menu(
    id: id ?? this.id,
    menuAdi: menuAdi ?? this.menuAdi,
    tur: tur ?? this.tur,
  );
  Menu copyWithCompanion(MenulerCompanion data) {
    return Menu(
      id: data.id.present ? data.id.value : this.id,
      menuAdi: data.menuAdi.present ? data.menuAdi.value : this.menuAdi,
      tur: data.tur.present ? data.tur.value : this.tur,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Menu(')
          ..write('id: $id, ')
          ..write('menuAdi: $menuAdi, ')
          ..write('tur: $tur')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, menuAdi, tur);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Menu &&
          other.id == this.id &&
          other.menuAdi == this.menuAdi &&
          other.tur == this.tur);
}

class MenulerCompanion extends UpdateCompanion<Menu> {
  final Value<int> id;
  final Value<String> menuAdi;
  final Value<String> tur;
  const MenulerCompanion({
    this.id = const Value.absent(),
    this.menuAdi = const Value.absent(),
    this.tur = const Value.absent(),
  });
  MenulerCompanion.insert({
    this.id = const Value.absent(),
    required String menuAdi,
    this.tur = const Value.absent(),
  }) : menuAdi = Value(menuAdi);
  static Insertable<Menu> custom({
    Expression<int>? id,
    Expression<String>? menuAdi,
    Expression<String>? tur,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (menuAdi != null) 'menu_adi': menuAdi,
      if (tur != null) 'tur': tur,
    });
  }

  MenulerCompanion copyWith({
    Value<int>? id,
    Value<String>? menuAdi,
    Value<String>? tur,
  }) {
    return MenulerCompanion(
      id: id ?? this.id,
      menuAdi: menuAdi ?? this.menuAdi,
      tur: tur ?? this.tur,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (menuAdi.present) {
      map['menu_adi'] = Variable<String>(menuAdi.value);
    }
    if (tur.present) {
      map['tur'] = Variable<String>(tur.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenulerCompanion(')
          ..write('id: $id, ')
          ..write('menuAdi: $menuAdi, ')
          ..write('tur: $tur')
          ..write(')'))
        .toString();
  }
}

class $MenuOgeleriTable extends MenuOgeleri
    with TableInfo<$MenuOgeleriTable, MenuOgesi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuOgeleriTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _menuIdMeta = const VerificationMeta('menuId');
  @override
  late final GeneratedColumn<int> menuId = GeneratedColumn<int>(
    'menu_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES menuler (id)',
    ),
  );
  static const VerificationMeta _besinIdMeta = const VerificationMeta(
    'besinId',
  );
  @override
  late final GeneratedColumn<int> besinId = GeneratedColumn<int>(
    'besin_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES besinler (id)',
    ),
  );
  static const VerificationMeta _miktarMeta = const VerificationMeta('miktar');
  @override
  late final GeneratedColumn<double> miktar = GeneratedColumn<double>(
    'miktar',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, menuId, besinId, miktar];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_ogeleri';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenuOgesi> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('menu_id')) {
      context.handle(
        _menuIdMeta,
        menuId.isAcceptableOrUnknown(data['menu_id']!, _menuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_menuIdMeta);
    }
    if (data.containsKey('besin_id')) {
      context.handle(
        _besinIdMeta,
        besinId.isAcceptableOrUnknown(data['besin_id']!, _besinIdMeta),
      );
    } else if (isInserting) {
      context.missing(_besinIdMeta);
    }
    if (data.containsKey('miktar')) {
      context.handle(
        _miktarMeta,
        miktar.isAcceptableOrUnknown(data['miktar']!, _miktarMeta),
      );
    } else if (isInserting) {
      context.missing(_miktarMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuOgesi map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuOgesi(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      menuId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}menu_id'],
      )!,
      besinId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}besin_id'],
      )!,
      miktar: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}miktar'],
      )!,
    );
  }

  @override
  $MenuOgeleriTable createAlias(String alias) {
    return $MenuOgeleriTable(attachedDatabase, alias);
  }
}

class MenuOgesi extends DataClass implements Insertable<MenuOgesi> {
  final int id;
  final int menuId;
  final int besinId;
  final double miktar;
  const MenuOgesi({
    required this.id,
    required this.menuId,
    required this.besinId,
    required this.miktar,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['menu_id'] = Variable<int>(menuId);
    map['besin_id'] = Variable<int>(besinId);
    map['miktar'] = Variable<double>(miktar);
    return map;
  }

  MenuOgeleriCompanion toCompanion(bool nullToAbsent) {
    return MenuOgeleriCompanion(
      id: Value(id),
      menuId: Value(menuId),
      besinId: Value(besinId),
      miktar: Value(miktar),
    );
  }

  factory MenuOgesi.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuOgesi(
      id: serializer.fromJson<int>(json['id']),
      menuId: serializer.fromJson<int>(json['menuId']),
      besinId: serializer.fromJson<int>(json['besinId']),
      miktar: serializer.fromJson<double>(json['miktar']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'menuId': serializer.toJson<int>(menuId),
      'besinId': serializer.toJson<int>(besinId),
      'miktar': serializer.toJson<double>(miktar),
    };
  }

  MenuOgesi copyWith({int? id, int? menuId, int? besinId, double? miktar}) =>
      MenuOgesi(
        id: id ?? this.id,
        menuId: menuId ?? this.menuId,
        besinId: besinId ?? this.besinId,
        miktar: miktar ?? this.miktar,
      );
  MenuOgesi copyWithCompanion(MenuOgeleriCompanion data) {
    return MenuOgesi(
      id: data.id.present ? data.id.value : this.id,
      menuId: data.menuId.present ? data.menuId.value : this.menuId,
      besinId: data.besinId.present ? data.besinId.value : this.besinId,
      miktar: data.miktar.present ? data.miktar.value : this.miktar,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuOgesi(')
          ..write('id: $id, ')
          ..write('menuId: $menuId, ')
          ..write('besinId: $besinId, ')
          ..write('miktar: $miktar')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, menuId, besinId, miktar);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuOgesi &&
          other.id == this.id &&
          other.menuId == this.menuId &&
          other.besinId == this.besinId &&
          other.miktar == this.miktar);
}

class MenuOgeleriCompanion extends UpdateCompanion<MenuOgesi> {
  final Value<int> id;
  final Value<int> menuId;
  final Value<int> besinId;
  final Value<double> miktar;
  const MenuOgeleriCompanion({
    this.id = const Value.absent(),
    this.menuId = const Value.absent(),
    this.besinId = const Value.absent(),
    this.miktar = const Value.absent(),
  });
  MenuOgeleriCompanion.insert({
    this.id = const Value.absent(),
    required int menuId,
    required int besinId,
    required double miktar,
  }) : menuId = Value(menuId),
       besinId = Value(besinId),
       miktar = Value(miktar);
  static Insertable<MenuOgesi> custom({
    Expression<int>? id,
    Expression<int>? menuId,
    Expression<int>? besinId,
    Expression<double>? miktar,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (menuId != null) 'menu_id': menuId,
      if (besinId != null) 'besin_id': besinId,
      if (miktar != null) 'miktar': miktar,
    });
  }

  MenuOgeleriCompanion copyWith({
    Value<int>? id,
    Value<int>? menuId,
    Value<int>? besinId,
    Value<double>? miktar,
  }) {
    return MenuOgeleriCompanion(
      id: id ?? this.id,
      menuId: menuId ?? this.menuId,
      besinId: besinId ?? this.besinId,
      miktar: miktar ?? this.miktar,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (menuId.present) {
      map['menu_id'] = Variable<int>(menuId.value);
    }
    if (besinId.present) {
      map['besin_id'] = Variable<int>(besinId.value);
    }
    if (miktar.present) {
      map['miktar'] = Variable<double>(miktar.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuOgeleriCompanion(')
          ..write('id: $id, ')
          ..write('menuId: $menuId, ')
          ..write('besinId: $besinId, ')
          ..write('miktar: $miktar')
          ..write(')'))
        .toString();
  }
}

class $GunlukKayitlarTable extends GunlukKayitlar
    with TableInfo<$GunlukKayitlarTable, GunlukKayit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GunlukKayitlarTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tarihMeta = const VerificationMeta('tarih');
  @override
  late final GeneratedColumn<String> tarih = GeneratedColumn<String>(
    'tarih',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, tarih];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gunluk_kayitlar';
  @override
  VerificationContext validateIntegrity(
    Insertable<GunlukKayit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tarih')) {
      context.handle(
        _tarihMeta,
        tarih.isAcceptableOrUnknown(data['tarih']!, _tarihMeta),
      );
    } else if (isInserting) {
      context.missing(_tarihMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GunlukKayit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GunlukKayit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tarih: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tarih'],
      )!,
    );
  }

  @override
  $GunlukKayitlarTable createAlias(String alias) {
    return $GunlukKayitlarTable(attachedDatabase, alias);
  }
}

class GunlukKayit extends DataClass implements Insertable<GunlukKayit> {
  final int id;
  final String tarih;
  const GunlukKayit({required this.id, required this.tarih});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tarih'] = Variable<String>(tarih);
    return map;
  }

  GunlukKayitlarCompanion toCompanion(bool nullToAbsent) {
    return GunlukKayitlarCompanion(id: Value(id), tarih: Value(tarih));
  }

  factory GunlukKayit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GunlukKayit(
      id: serializer.fromJson<int>(json['id']),
      tarih: serializer.fromJson<String>(json['tarih']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tarih': serializer.toJson<String>(tarih),
    };
  }

  GunlukKayit copyWith({int? id, String? tarih}) =>
      GunlukKayit(id: id ?? this.id, tarih: tarih ?? this.tarih);
  GunlukKayit copyWithCompanion(GunlukKayitlarCompanion data) {
    return GunlukKayit(
      id: data.id.present ? data.id.value : this.id,
      tarih: data.tarih.present ? data.tarih.value : this.tarih,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GunlukKayit(')
          ..write('id: $id, ')
          ..write('tarih: $tarih')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tarih);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GunlukKayit &&
          other.id == this.id &&
          other.tarih == this.tarih);
}

class GunlukKayitlarCompanion extends UpdateCompanion<GunlukKayit> {
  final Value<int> id;
  final Value<String> tarih;
  const GunlukKayitlarCompanion({
    this.id = const Value.absent(),
    this.tarih = const Value.absent(),
  });
  GunlukKayitlarCompanion.insert({
    this.id = const Value.absent(),
    required String tarih,
  }) : tarih = Value(tarih);
  static Insertable<GunlukKayit> custom({
    Expression<int>? id,
    Expression<String>? tarih,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tarih != null) 'tarih': tarih,
    });
  }

  GunlukKayitlarCompanion copyWith({Value<int>? id, Value<String>? tarih}) {
    return GunlukKayitlarCompanion(
      id: id ?? this.id,
      tarih: tarih ?? this.tarih,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tarih.present) {
      map['tarih'] = Variable<String>(tarih.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GunlukKayitlarCompanion(')
          ..write('id: $id, ')
          ..write('tarih: $tarih')
          ..write(')'))
        .toString();
  }
}

class $GunlukKayitOgeleriTable extends GunlukKayitOgeleri
    with TableInfo<$GunlukKayitOgeleriTable, GunlukKayitOgesi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GunlukKayitOgeleriTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kayitIdMeta = const VerificationMeta(
    'kayitId',
  );
  @override
  late final GeneratedColumn<int> kayitId = GeneratedColumn<int>(
    'kayit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gunluk_kayitlar (id)',
    ),
  );
  static const VerificationMeta _besinIdMeta = const VerificationMeta(
    'besinId',
  );
  @override
  late final GeneratedColumn<int> besinId = GeneratedColumn<int>(
    'besin_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES besinler (id)',
    ),
  );
  static const VerificationMeta _miktarMeta = const VerificationMeta('miktar');
  @override
  late final GeneratedColumn<double> miktar = GeneratedColumn<double>(
    'miktar',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, kayitId, besinId, miktar];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gunluk_kayit_ogeleri';
  @override
  VerificationContext validateIntegrity(
    Insertable<GunlukKayitOgesi> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kayit_id')) {
      context.handle(
        _kayitIdMeta,
        kayitId.isAcceptableOrUnknown(data['kayit_id']!, _kayitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kayitIdMeta);
    }
    if (data.containsKey('besin_id')) {
      context.handle(
        _besinIdMeta,
        besinId.isAcceptableOrUnknown(data['besin_id']!, _besinIdMeta),
      );
    } else if (isInserting) {
      context.missing(_besinIdMeta);
    }
    if (data.containsKey('miktar')) {
      context.handle(
        _miktarMeta,
        miktar.isAcceptableOrUnknown(data['miktar']!, _miktarMeta),
      );
    } else if (isInserting) {
      context.missing(_miktarMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GunlukKayitOgesi map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GunlukKayitOgesi(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kayitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kayit_id'],
      )!,
      besinId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}besin_id'],
      )!,
      miktar: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}miktar'],
      )!,
    );
  }

  @override
  $GunlukKayitOgeleriTable createAlias(String alias) {
    return $GunlukKayitOgeleriTable(attachedDatabase, alias);
  }
}

class GunlukKayitOgesi extends DataClass
    implements Insertable<GunlukKayitOgesi> {
  final int id;
  final int kayitId;
  final int besinId;
  final double miktar;
  const GunlukKayitOgesi({
    required this.id,
    required this.kayitId,
    required this.besinId,
    required this.miktar,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kayit_id'] = Variable<int>(kayitId);
    map['besin_id'] = Variable<int>(besinId);
    map['miktar'] = Variable<double>(miktar);
    return map;
  }

  GunlukKayitOgeleriCompanion toCompanion(bool nullToAbsent) {
    return GunlukKayitOgeleriCompanion(
      id: Value(id),
      kayitId: Value(kayitId),
      besinId: Value(besinId),
      miktar: Value(miktar),
    );
  }

  factory GunlukKayitOgesi.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GunlukKayitOgesi(
      id: serializer.fromJson<int>(json['id']),
      kayitId: serializer.fromJson<int>(json['kayitId']),
      besinId: serializer.fromJson<int>(json['besinId']),
      miktar: serializer.fromJson<double>(json['miktar']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kayitId': serializer.toJson<int>(kayitId),
      'besinId': serializer.toJson<int>(besinId),
      'miktar': serializer.toJson<double>(miktar),
    };
  }

  GunlukKayitOgesi copyWith({
    int? id,
    int? kayitId,
    int? besinId,
    double? miktar,
  }) => GunlukKayitOgesi(
    id: id ?? this.id,
    kayitId: kayitId ?? this.kayitId,
    besinId: besinId ?? this.besinId,
    miktar: miktar ?? this.miktar,
  );
  GunlukKayitOgesi copyWithCompanion(GunlukKayitOgeleriCompanion data) {
    return GunlukKayitOgesi(
      id: data.id.present ? data.id.value : this.id,
      kayitId: data.kayitId.present ? data.kayitId.value : this.kayitId,
      besinId: data.besinId.present ? data.besinId.value : this.besinId,
      miktar: data.miktar.present ? data.miktar.value : this.miktar,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GunlukKayitOgesi(')
          ..write('id: $id, ')
          ..write('kayitId: $kayitId, ')
          ..write('besinId: $besinId, ')
          ..write('miktar: $miktar')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kayitId, besinId, miktar);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GunlukKayitOgesi &&
          other.id == this.id &&
          other.kayitId == this.kayitId &&
          other.besinId == this.besinId &&
          other.miktar == this.miktar);
}

class GunlukKayitOgeleriCompanion extends UpdateCompanion<GunlukKayitOgesi> {
  final Value<int> id;
  final Value<int> kayitId;
  final Value<int> besinId;
  final Value<double> miktar;
  const GunlukKayitOgeleriCompanion({
    this.id = const Value.absent(),
    this.kayitId = const Value.absent(),
    this.besinId = const Value.absent(),
    this.miktar = const Value.absent(),
  });
  GunlukKayitOgeleriCompanion.insert({
    this.id = const Value.absent(),
    required int kayitId,
    required int besinId,
    required double miktar,
  }) : kayitId = Value(kayitId),
       besinId = Value(besinId),
       miktar = Value(miktar);
  static Insertable<GunlukKayitOgesi> custom({
    Expression<int>? id,
    Expression<int>? kayitId,
    Expression<int>? besinId,
    Expression<double>? miktar,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kayitId != null) 'kayit_id': kayitId,
      if (besinId != null) 'besin_id': besinId,
      if (miktar != null) 'miktar': miktar,
    });
  }

  GunlukKayitOgeleriCompanion copyWith({
    Value<int>? id,
    Value<int>? kayitId,
    Value<int>? besinId,
    Value<double>? miktar,
  }) {
    return GunlukKayitOgeleriCompanion(
      id: id ?? this.id,
      kayitId: kayitId ?? this.kayitId,
      besinId: besinId ?? this.besinId,
      miktar: miktar ?? this.miktar,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kayitId.present) {
      map['kayit_id'] = Variable<int>(kayitId.value);
    }
    if (besinId.present) {
      map['besin_id'] = Variable<int>(besinId.value);
    }
    if (miktar.present) {
      map['miktar'] = Variable<double>(miktar.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GunlukKayitOgeleriCompanion(')
          ..write('id: $id, ')
          ..write('kayitId: $kayitId, ')
          ..write('besinId: $besinId, ')
          ..write('miktar: $miktar')
          ..write(')'))
        .toString();
  }
}

class $KullaniciHedefleriTable extends KullaniciHedefleri
    with TableInfo<$KullaniciHedefleriTable, KullaniciHedef> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KullaniciHedefleriTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kaloriMeta = const VerificationMeta('kalori');
  @override
  late final GeneratedColumn<double> kalori = GeneratedColumn<double>(
    'kalori',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _karbMeta = const VerificationMeta('karb');
  @override
  late final GeneratedColumn<double> karb = GeneratedColumn<double>(
    'karb',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proMeta = const VerificationMeta('pro');
  @override
  late final GeneratedColumn<double> pro = GeneratedColumn<double>(
    'pro',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yagMeta = const VerificationMeta('yag');
  @override
  late final GeneratedColumn<double> yag = GeneratedColumn<double>(
    'yag',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, kalori, karb, pro, yag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kullanici_hedefleri';
  @override
  VerificationContext validateIntegrity(
    Insertable<KullaniciHedef> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kalori')) {
      context.handle(
        _kaloriMeta,
        kalori.isAcceptableOrUnknown(data['kalori']!, _kaloriMeta),
      );
    } else if (isInserting) {
      context.missing(_kaloriMeta);
    }
    if (data.containsKey('karb')) {
      context.handle(
        _karbMeta,
        karb.isAcceptableOrUnknown(data['karb']!, _karbMeta),
      );
    } else if (isInserting) {
      context.missing(_karbMeta);
    }
    if (data.containsKey('pro')) {
      context.handle(
        _proMeta,
        pro.isAcceptableOrUnknown(data['pro']!, _proMeta),
      );
    } else if (isInserting) {
      context.missing(_proMeta);
    }
    if (data.containsKey('yag')) {
      context.handle(
        _yagMeta,
        yag.isAcceptableOrUnknown(data['yag']!, _yagMeta),
      );
    } else if (isInserting) {
      context.missing(_yagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KullaniciHedef map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KullaniciHedef(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kalori: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kalori'],
      )!,
      karb: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}karb'],
      )!,
      pro: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pro'],
      )!,
      yag: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}yag'],
      )!,
    );
  }

  @override
  $KullaniciHedefleriTable createAlias(String alias) {
    return $KullaniciHedefleriTable(attachedDatabase, alias);
  }
}

class KullaniciHedef extends DataClass implements Insertable<KullaniciHedef> {
  final int id;
  final double kalori;
  final double karb;
  final double pro;
  final double yag;
  const KullaniciHedef({
    required this.id,
    required this.kalori,
    required this.karb,
    required this.pro,
    required this.yag,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kalori'] = Variable<double>(kalori);
    map['karb'] = Variable<double>(karb);
    map['pro'] = Variable<double>(pro);
    map['yag'] = Variable<double>(yag);
    return map;
  }

  KullaniciHedefleriCompanion toCompanion(bool nullToAbsent) {
    return KullaniciHedefleriCompanion(
      id: Value(id),
      kalori: Value(kalori),
      karb: Value(karb),
      pro: Value(pro),
      yag: Value(yag),
    );
  }

  factory KullaniciHedef.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KullaniciHedef(
      id: serializer.fromJson<int>(json['id']),
      kalori: serializer.fromJson<double>(json['kalori']),
      karb: serializer.fromJson<double>(json['karb']),
      pro: serializer.fromJson<double>(json['pro']),
      yag: serializer.fromJson<double>(json['yag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kalori': serializer.toJson<double>(kalori),
      'karb': serializer.toJson<double>(karb),
      'pro': serializer.toJson<double>(pro),
      'yag': serializer.toJson<double>(yag),
    };
  }

  KullaniciHedef copyWith({
    int? id,
    double? kalori,
    double? karb,
    double? pro,
    double? yag,
  }) => KullaniciHedef(
    id: id ?? this.id,
    kalori: kalori ?? this.kalori,
    karb: karb ?? this.karb,
    pro: pro ?? this.pro,
    yag: yag ?? this.yag,
  );
  KullaniciHedef copyWithCompanion(KullaniciHedefleriCompanion data) {
    return KullaniciHedef(
      id: data.id.present ? data.id.value : this.id,
      kalori: data.kalori.present ? data.kalori.value : this.kalori,
      karb: data.karb.present ? data.karb.value : this.karb,
      pro: data.pro.present ? data.pro.value : this.pro,
      yag: data.yag.present ? data.yag.value : this.yag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KullaniciHedef(')
          ..write('id: $id, ')
          ..write('kalori: $kalori, ')
          ..write('karb: $karb, ')
          ..write('pro: $pro, ')
          ..write('yag: $yag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kalori, karb, pro, yag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KullaniciHedef &&
          other.id == this.id &&
          other.kalori == this.kalori &&
          other.karb == this.karb &&
          other.pro == this.pro &&
          other.yag == this.yag);
}

class KullaniciHedefleriCompanion extends UpdateCompanion<KullaniciHedef> {
  final Value<int> id;
  final Value<double> kalori;
  final Value<double> karb;
  final Value<double> pro;
  final Value<double> yag;
  const KullaniciHedefleriCompanion({
    this.id = const Value.absent(),
    this.kalori = const Value.absent(),
    this.karb = const Value.absent(),
    this.pro = const Value.absent(),
    this.yag = const Value.absent(),
  });
  KullaniciHedefleriCompanion.insert({
    this.id = const Value.absent(),
    required double kalori,
    required double karb,
    required double pro,
    required double yag,
  }) : kalori = Value(kalori),
       karb = Value(karb),
       pro = Value(pro),
       yag = Value(yag);
  static Insertable<KullaniciHedef> custom({
    Expression<int>? id,
    Expression<double>? kalori,
    Expression<double>? karb,
    Expression<double>? pro,
    Expression<double>? yag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kalori != null) 'kalori': kalori,
      if (karb != null) 'karb': karb,
      if (pro != null) 'pro': pro,
      if (yag != null) 'yag': yag,
    });
  }

  KullaniciHedefleriCompanion copyWith({
    Value<int>? id,
    Value<double>? kalori,
    Value<double>? karb,
    Value<double>? pro,
    Value<double>? yag,
  }) {
    return KullaniciHedefleriCompanion(
      id: id ?? this.id,
      kalori: kalori ?? this.kalori,
      karb: karb ?? this.karb,
      pro: pro ?? this.pro,
      yag: yag ?? this.yag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kalori.present) {
      map['kalori'] = Variable<double>(kalori.value);
    }
    if (karb.present) {
      map['karb'] = Variable<double>(karb.value);
    }
    if (pro.present) {
      map['pro'] = Variable<double>(pro.value);
    }
    if (yag.present) {
      map['yag'] = Variable<double>(yag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KullaniciHedefleriCompanion(')
          ..write('id: $id, ')
          ..write('kalori: $kalori, ')
          ..write('karb: $karb, ')
          ..write('pro: $pro, ')
          ..write('yag: $yag')
          ..write(')'))
        .toString();
  }
}

class $OlcumlerTable extends Olcumler with TableInfo<$OlcumlerTable, Olcum> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OlcumlerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tarihMeta = const VerificationMeta('tarih');
  @override
  late final GeneratedColumn<String> tarih = GeneratedColumn<String>(
    'tarih',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _cinsiyetMeta = const VerificationMeta(
    'cinsiyet',
  );
  @override
  late final GeneratedColumn<String> cinsiyet = GeneratedColumn<String>(
    'cinsiyet',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kiloMeta = const VerificationMeta('kilo');
  @override
  late final GeneratedColumn<double> kilo = GeneratedColumn<double>(
    'kilo',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _belMeta = const VerificationMeta('bel');
  @override
  late final GeneratedColumn<double> bel = GeneratedColumn<double>(
    'bel',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _boyunMeta = const VerificationMeta('boyun');
  @override
  late final GeneratedColumn<double> boyun = GeneratedColumn<double>(
    'boyun',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kalcaMeta = const VerificationMeta('kalca');
  @override
  late final GeneratedColumn<double> kalca = GeneratedColumn<double>(
    'kalca',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tarih,
    cinsiyet,
    kilo,
    bel,
    boyun,
    kalca,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'olcumler';
  @override
  VerificationContext validateIntegrity(
    Insertable<Olcum> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tarih')) {
      context.handle(
        _tarihMeta,
        tarih.isAcceptableOrUnknown(data['tarih']!, _tarihMeta),
      );
    } else if (isInserting) {
      context.missing(_tarihMeta);
    }
    if (data.containsKey('cinsiyet')) {
      context.handle(
        _cinsiyetMeta,
        cinsiyet.isAcceptableOrUnknown(data['cinsiyet']!, _cinsiyetMeta),
      );
    } else if (isInserting) {
      context.missing(_cinsiyetMeta);
    }
    if (data.containsKey('kilo')) {
      context.handle(
        _kiloMeta,
        kilo.isAcceptableOrUnknown(data['kilo']!, _kiloMeta),
      );
    } else if (isInserting) {
      context.missing(_kiloMeta);
    }
    if (data.containsKey('bel')) {
      context.handle(
        _belMeta,
        bel.isAcceptableOrUnknown(data['bel']!, _belMeta),
      );
    }
    if (data.containsKey('boyun')) {
      context.handle(
        _boyunMeta,
        boyun.isAcceptableOrUnknown(data['boyun']!, _boyunMeta),
      );
    }
    if (data.containsKey('kalca')) {
      context.handle(
        _kalcaMeta,
        kalca.isAcceptableOrUnknown(data['kalca']!, _kalcaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Olcum map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Olcum(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tarih: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tarih'],
      )!,
      cinsiyet: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cinsiyet'],
      )!,
      kilo: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kilo'],
      )!,
      bel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bel'],
      ),
      boyun: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}boyun'],
      ),
      kalca: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kalca'],
      ),
    );
  }

  @override
  $OlcumlerTable createAlias(String alias) {
    return $OlcumlerTable(attachedDatabase, alias);
  }
}

class Olcum extends DataClass implements Insertable<Olcum> {
  final int id;
  final String tarih;
  final String cinsiyet;
  final double kilo;
  final double? bel;
  final double? boyun;
  final double? kalca;
  const Olcum({
    required this.id,
    required this.tarih,
    required this.cinsiyet,
    required this.kilo,
    this.bel,
    this.boyun,
    this.kalca,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tarih'] = Variable<String>(tarih);
    map['cinsiyet'] = Variable<String>(cinsiyet);
    map['kilo'] = Variable<double>(kilo);
    if (!nullToAbsent || bel != null) {
      map['bel'] = Variable<double>(bel);
    }
    if (!nullToAbsent || boyun != null) {
      map['boyun'] = Variable<double>(boyun);
    }
    if (!nullToAbsent || kalca != null) {
      map['kalca'] = Variable<double>(kalca);
    }
    return map;
  }

  OlcumlerCompanion toCompanion(bool nullToAbsent) {
    return OlcumlerCompanion(
      id: Value(id),
      tarih: Value(tarih),
      cinsiyet: Value(cinsiyet),
      kilo: Value(kilo),
      bel: bel == null && nullToAbsent ? const Value.absent() : Value(bel),
      boyun: boyun == null && nullToAbsent
          ? const Value.absent()
          : Value(boyun),
      kalca: kalca == null && nullToAbsent
          ? const Value.absent()
          : Value(kalca),
    );
  }

  factory Olcum.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Olcum(
      id: serializer.fromJson<int>(json['id']),
      tarih: serializer.fromJson<String>(json['tarih']),
      cinsiyet: serializer.fromJson<String>(json['cinsiyet']),
      kilo: serializer.fromJson<double>(json['kilo']),
      bel: serializer.fromJson<double?>(json['bel']),
      boyun: serializer.fromJson<double?>(json['boyun']),
      kalca: serializer.fromJson<double?>(json['kalca']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tarih': serializer.toJson<String>(tarih),
      'cinsiyet': serializer.toJson<String>(cinsiyet),
      'kilo': serializer.toJson<double>(kilo),
      'bel': serializer.toJson<double?>(bel),
      'boyun': serializer.toJson<double?>(boyun),
      'kalca': serializer.toJson<double?>(kalca),
    };
  }

  Olcum copyWith({
    int? id,
    String? tarih,
    String? cinsiyet,
    double? kilo,
    Value<double?> bel = const Value.absent(),
    Value<double?> boyun = const Value.absent(),
    Value<double?> kalca = const Value.absent(),
  }) => Olcum(
    id: id ?? this.id,
    tarih: tarih ?? this.tarih,
    cinsiyet: cinsiyet ?? this.cinsiyet,
    kilo: kilo ?? this.kilo,
    bel: bel.present ? bel.value : this.bel,
    boyun: boyun.present ? boyun.value : this.boyun,
    kalca: kalca.present ? kalca.value : this.kalca,
  );
  Olcum copyWithCompanion(OlcumlerCompanion data) {
    return Olcum(
      id: data.id.present ? data.id.value : this.id,
      tarih: data.tarih.present ? data.tarih.value : this.tarih,
      cinsiyet: data.cinsiyet.present ? data.cinsiyet.value : this.cinsiyet,
      kilo: data.kilo.present ? data.kilo.value : this.kilo,
      bel: data.bel.present ? data.bel.value : this.bel,
      boyun: data.boyun.present ? data.boyun.value : this.boyun,
      kalca: data.kalca.present ? data.kalca.value : this.kalca,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Olcum(')
          ..write('id: $id, ')
          ..write('tarih: $tarih, ')
          ..write('cinsiyet: $cinsiyet, ')
          ..write('kilo: $kilo, ')
          ..write('bel: $bel, ')
          ..write('boyun: $boyun, ')
          ..write('kalca: $kalca')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tarih, cinsiyet, kilo, bel, boyun, kalca);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Olcum &&
          other.id == this.id &&
          other.tarih == this.tarih &&
          other.cinsiyet == this.cinsiyet &&
          other.kilo == this.kilo &&
          other.bel == this.bel &&
          other.boyun == this.boyun &&
          other.kalca == this.kalca);
}

class OlcumlerCompanion extends UpdateCompanion<Olcum> {
  final Value<int> id;
  final Value<String> tarih;
  final Value<String> cinsiyet;
  final Value<double> kilo;
  final Value<double?> bel;
  final Value<double?> boyun;
  final Value<double?> kalca;
  const OlcumlerCompanion({
    this.id = const Value.absent(),
    this.tarih = const Value.absent(),
    this.cinsiyet = const Value.absent(),
    this.kilo = const Value.absent(),
    this.bel = const Value.absent(),
    this.boyun = const Value.absent(),
    this.kalca = const Value.absent(),
  });
  OlcumlerCompanion.insert({
    this.id = const Value.absent(),
    required String tarih,
    required String cinsiyet,
    required double kilo,
    this.bel = const Value.absent(),
    this.boyun = const Value.absent(),
    this.kalca = const Value.absent(),
  }) : tarih = Value(tarih),
       cinsiyet = Value(cinsiyet),
       kilo = Value(kilo);
  static Insertable<Olcum> custom({
    Expression<int>? id,
    Expression<String>? tarih,
    Expression<String>? cinsiyet,
    Expression<double>? kilo,
    Expression<double>? bel,
    Expression<double>? boyun,
    Expression<double>? kalca,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tarih != null) 'tarih': tarih,
      if (cinsiyet != null) 'cinsiyet': cinsiyet,
      if (kilo != null) 'kilo': kilo,
      if (bel != null) 'bel': bel,
      if (boyun != null) 'boyun': boyun,
      if (kalca != null) 'kalca': kalca,
    });
  }

  OlcumlerCompanion copyWith({
    Value<int>? id,
    Value<String>? tarih,
    Value<String>? cinsiyet,
    Value<double>? kilo,
    Value<double?>? bel,
    Value<double?>? boyun,
    Value<double?>? kalca,
  }) {
    return OlcumlerCompanion(
      id: id ?? this.id,
      tarih: tarih ?? this.tarih,
      cinsiyet: cinsiyet ?? this.cinsiyet,
      kilo: kilo ?? this.kilo,
      bel: bel ?? this.bel,
      boyun: boyun ?? this.boyun,
      kalca: kalca ?? this.kalca,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tarih.present) {
      map['tarih'] = Variable<String>(tarih.value);
    }
    if (cinsiyet.present) {
      map['cinsiyet'] = Variable<String>(cinsiyet.value);
    }
    if (kilo.present) {
      map['kilo'] = Variable<double>(kilo.value);
    }
    if (bel.present) {
      map['bel'] = Variable<double>(bel.value);
    }
    if (boyun.present) {
      map['boyun'] = Variable<double>(boyun.value);
    }
    if (kalca.present) {
      map['kalca'] = Variable<double>(kalca.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OlcumlerCompanion(')
          ..write('id: $id, ')
          ..write('tarih: $tarih, ')
          ..write('cinsiyet: $cinsiyet, ')
          ..write('kilo: $kilo, ')
          ..write('bel: $bel, ')
          ..write('boyun: $boyun, ')
          ..write('kalca: $kalca')
          ..write(')'))
        .toString();
  }
}

class $KullaniciAyarlariTable extends KullaniciAyarlari
    with TableInfo<$KullaniciAyarlariTable, KullaniciAyar> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KullaniciAyarlariTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _boyMeta = const VerificationMeta('boy');
  @override
  late final GeneratedColumn<double> boy = GeneratedColumn<double>(
    'boy',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, boy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kullanici_ayarlari';
  @override
  VerificationContext validateIntegrity(
    Insertable<KullaniciAyar> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('boy')) {
      context.handle(
        _boyMeta,
        boy.isAcceptableOrUnknown(data['boy']!, _boyMeta),
      );
    } else if (isInserting) {
      context.missing(_boyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KullaniciAyar map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KullaniciAyar(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      boy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}boy'],
      )!,
    );
  }

  @override
  $KullaniciAyarlariTable createAlias(String alias) {
    return $KullaniciAyarlariTable(attachedDatabase, alias);
  }
}

class KullaniciAyar extends DataClass implements Insertable<KullaniciAyar> {
  final int id;
  final double boy;
  const KullaniciAyar({required this.id, required this.boy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['boy'] = Variable<double>(boy);
    return map;
  }

  KullaniciAyarlariCompanion toCompanion(bool nullToAbsent) {
    return KullaniciAyarlariCompanion(id: Value(id), boy: Value(boy));
  }

  factory KullaniciAyar.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KullaniciAyar(
      id: serializer.fromJson<int>(json['id']),
      boy: serializer.fromJson<double>(json['boy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'boy': serializer.toJson<double>(boy),
    };
  }

  KullaniciAyar copyWith({int? id, double? boy}) =>
      KullaniciAyar(id: id ?? this.id, boy: boy ?? this.boy);
  KullaniciAyar copyWithCompanion(KullaniciAyarlariCompanion data) {
    return KullaniciAyar(
      id: data.id.present ? data.id.value : this.id,
      boy: data.boy.present ? data.boy.value : this.boy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KullaniciAyar(')
          ..write('id: $id, ')
          ..write('boy: $boy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, boy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KullaniciAyar && other.id == this.id && other.boy == this.boy);
}

class KullaniciAyarlariCompanion extends UpdateCompanion<KullaniciAyar> {
  final Value<int> id;
  final Value<double> boy;
  const KullaniciAyarlariCompanion({
    this.id = const Value.absent(),
    this.boy = const Value.absent(),
  });
  KullaniciAyarlariCompanion.insert({
    this.id = const Value.absent(),
    required double boy,
  }) : boy = Value(boy);
  static Insertable<KullaniciAyar> custom({
    Expression<int>? id,
    Expression<double>? boy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (boy != null) 'boy': boy,
    });
  }

  KullaniciAyarlariCompanion copyWith({Value<int>? id, Value<double>? boy}) {
    return KullaniciAyarlariCompanion(id: id ?? this.id, boy: boy ?? this.boy);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (boy.present) {
      map['boy'] = Variable<double>(boy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KullaniciAyarlariCompanion(')
          ..write('id: $id, ')
          ..write('boy: $boy')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BesinlerTable besinler = $BesinlerTable(this);
  late final $MenulerTable menuler = $MenulerTable(this);
  late final $MenuOgeleriTable menuOgeleri = $MenuOgeleriTable(this);
  late final $GunlukKayitlarTable gunlukKayitlar = $GunlukKayitlarTable(this);
  late final $GunlukKayitOgeleriTable gunlukKayitOgeleri =
      $GunlukKayitOgeleriTable(this);
  late final $KullaniciHedefleriTable kullaniciHedefleri =
      $KullaniciHedefleriTable(this);
  late final $OlcumlerTable olcumler = $OlcumlerTable(this);
  late final $KullaniciAyarlariTable kullaniciAyarlari =
      $KullaniciAyarlariTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    besinler,
    menuler,
    menuOgeleri,
    gunlukKayitlar,
    gunlukKayitOgeleri,
    kullaniciHedefleri,
    olcumler,
    kullaniciAyarlari,
  ];
}

typedef $$BesinlerTableCreateCompanionBuilder =
    BesinlerCompanion Function({
      Value<int> id,
      required String isim,
      Value<double?> kalori,
      Value<double?> karb,
      Value<double?> pro,
      Value<double?> yag,
    });
typedef $$BesinlerTableUpdateCompanionBuilder =
    BesinlerCompanion Function({
      Value<int> id,
      Value<String> isim,
      Value<double?> kalori,
      Value<double?> karb,
      Value<double?> pro,
      Value<double?> yag,
    });

final class $$BesinlerTableReferences
    extends BaseReferences<_$AppDatabase, $BesinlerTable, Besin> {
  $$BesinlerTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MenuOgeleriTable, List<MenuOgesi>>
  _menuOgeleriRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.menuOgeleri,
    aliasName: $_aliasNameGenerator(db.besinler.id, db.menuOgeleri.besinId),
  );

  $$MenuOgeleriTableProcessedTableManager get menuOgeleriRefs {
    final manager = $$MenuOgeleriTableTableManager(
      $_db,
      $_db.menuOgeleri,
    ).filter((f) => f.besinId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_menuOgeleriRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GunlukKayitOgeleriTable, List<GunlukKayitOgesi>>
  _gunlukKayitOgeleriRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gunlukKayitOgeleri,
        aliasName: $_aliasNameGenerator(
          db.besinler.id,
          db.gunlukKayitOgeleri.besinId,
        ),
      );

  $$GunlukKayitOgeleriTableProcessedTableManager get gunlukKayitOgeleriRefs {
    final manager = $$GunlukKayitOgeleriTableTableManager(
      $_db,
      $_db.gunlukKayitOgeleri,
    ).filter((f) => f.besinId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _gunlukKayitOgeleriRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BesinlerTableFilterComposer
    extends Composer<_$AppDatabase, $BesinlerTable> {
  $$BesinlerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get isim => $composableBuilder(
    column: $table.isim,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kalori => $composableBuilder(
    column: $table.kalori,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get karb => $composableBuilder(
    column: $table.karb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pro => $composableBuilder(
    column: $table.pro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yag => $composableBuilder(
    column: $table.yag,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> menuOgeleriRefs(
    Expression<bool> Function($$MenuOgeleriTableFilterComposer f) f,
  ) {
    final $$MenuOgeleriTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuOgeleri,
      getReferencedColumn: (t) => t.besinId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuOgeleriTableFilterComposer(
            $db: $db,
            $table: $db.menuOgeleri,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gunlukKayitOgeleriRefs(
    Expression<bool> Function($$GunlukKayitOgeleriTableFilterComposer f) f,
  ) {
    final $$GunlukKayitOgeleriTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gunlukKayitOgeleri,
      getReferencedColumn: (t) => t.besinId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GunlukKayitOgeleriTableFilterComposer(
            $db: $db,
            $table: $db.gunlukKayitOgeleri,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BesinlerTableOrderingComposer
    extends Composer<_$AppDatabase, $BesinlerTable> {
  $$BesinlerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isim => $composableBuilder(
    column: $table.isim,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kalori => $composableBuilder(
    column: $table.kalori,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get karb => $composableBuilder(
    column: $table.karb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pro => $composableBuilder(
    column: $table.pro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yag => $composableBuilder(
    column: $table.yag,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BesinlerTableAnnotationComposer
    extends Composer<_$AppDatabase, $BesinlerTable> {
  $$BesinlerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get isim =>
      $composableBuilder(column: $table.isim, builder: (column) => column);

  GeneratedColumn<double> get kalori =>
      $composableBuilder(column: $table.kalori, builder: (column) => column);

  GeneratedColumn<double> get karb =>
      $composableBuilder(column: $table.karb, builder: (column) => column);

  GeneratedColumn<double> get pro =>
      $composableBuilder(column: $table.pro, builder: (column) => column);

  GeneratedColumn<double> get yag =>
      $composableBuilder(column: $table.yag, builder: (column) => column);

  Expression<T> menuOgeleriRefs<T extends Object>(
    Expression<T> Function($$MenuOgeleriTableAnnotationComposer a) f,
  ) {
    final $$MenuOgeleriTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuOgeleri,
      getReferencedColumn: (t) => t.besinId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuOgeleriTableAnnotationComposer(
            $db: $db,
            $table: $db.menuOgeleri,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gunlukKayitOgeleriRefs<T extends Object>(
    Expression<T> Function($$GunlukKayitOgeleriTableAnnotationComposer a) f,
  ) {
    final $$GunlukKayitOgeleriTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gunlukKayitOgeleri,
          getReferencedColumn: (t) => t.besinId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GunlukKayitOgeleriTableAnnotationComposer(
                $db: $db,
                $table: $db.gunlukKayitOgeleri,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BesinlerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BesinlerTable,
          Besin,
          $$BesinlerTableFilterComposer,
          $$BesinlerTableOrderingComposer,
          $$BesinlerTableAnnotationComposer,
          $$BesinlerTableCreateCompanionBuilder,
          $$BesinlerTableUpdateCompanionBuilder,
          (Besin, $$BesinlerTableReferences),
          Besin,
          PrefetchHooks Function({
            bool menuOgeleriRefs,
            bool gunlukKayitOgeleriRefs,
          })
        > {
  $$BesinlerTableTableManager(_$AppDatabase db, $BesinlerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BesinlerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BesinlerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BesinlerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> isim = const Value.absent(),
                Value<double?> kalori = const Value.absent(),
                Value<double?> karb = const Value.absent(),
                Value<double?> pro = const Value.absent(),
                Value<double?> yag = const Value.absent(),
              }) => BesinlerCompanion(
                id: id,
                isim: isim,
                kalori: kalori,
                karb: karb,
                pro: pro,
                yag: yag,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String isim,
                Value<double?> kalori = const Value.absent(),
                Value<double?> karb = const Value.absent(),
                Value<double?> pro = const Value.absent(),
                Value<double?> yag = const Value.absent(),
              }) => BesinlerCompanion.insert(
                id: id,
                isim: isim,
                kalori: kalori,
                karb: karb,
                pro: pro,
                yag: yag,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BesinlerTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({menuOgeleriRefs = false, gunlukKayitOgeleriRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (menuOgeleriRefs) db.menuOgeleri,
                    if (gunlukKayitOgeleriRefs) db.gunlukKayitOgeleri,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (menuOgeleriRefs)
                        await $_getPrefetchedData<
                          Besin,
                          $BesinlerTable,
                          MenuOgesi
                        >(
                          currentTable: table,
                          referencedTable: $$BesinlerTableReferences
                              ._menuOgeleriRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BesinlerTableReferences(
                                db,
                                table,
                                p0,
                              ).menuOgeleriRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.besinId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (gunlukKayitOgeleriRefs)
                        await $_getPrefetchedData<
                          Besin,
                          $BesinlerTable,
                          GunlukKayitOgesi
                        >(
                          currentTable: table,
                          referencedTable: $$BesinlerTableReferences
                              ._gunlukKayitOgeleriRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BesinlerTableReferences(
                                db,
                                table,
                                p0,
                              ).gunlukKayitOgeleriRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.besinId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BesinlerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BesinlerTable,
      Besin,
      $$BesinlerTableFilterComposer,
      $$BesinlerTableOrderingComposer,
      $$BesinlerTableAnnotationComposer,
      $$BesinlerTableCreateCompanionBuilder,
      $$BesinlerTableUpdateCompanionBuilder,
      (Besin, $$BesinlerTableReferences),
      Besin,
      PrefetchHooks Function({
        bool menuOgeleriRefs,
        bool gunlukKayitOgeleriRefs,
      })
    >;
typedef $$MenulerTableCreateCompanionBuilder =
    MenulerCompanion Function({
      Value<int> id,
      required String menuAdi,
      Value<String> tur,
    });
typedef $$MenulerTableUpdateCompanionBuilder =
    MenulerCompanion Function({
      Value<int> id,
      Value<String> menuAdi,
      Value<String> tur,
    });

final class $$MenulerTableReferences
    extends BaseReferences<_$AppDatabase, $MenulerTable, Menu> {
  $$MenulerTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MenuOgeleriTable, List<MenuOgesi>>
  _menuOgeleriRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.menuOgeleri,
    aliasName: $_aliasNameGenerator(db.menuler.id, db.menuOgeleri.menuId),
  );

  $$MenuOgeleriTableProcessedTableManager get menuOgeleriRefs {
    final manager = $$MenuOgeleriTableTableManager(
      $_db,
      $_db.menuOgeleri,
    ).filter((f) => f.menuId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_menuOgeleriRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MenulerTableFilterComposer
    extends Composer<_$AppDatabase, $MenulerTable> {
  $$MenulerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get menuAdi => $composableBuilder(
    column: $table.menuAdi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tur => $composableBuilder(
    column: $table.tur,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> menuOgeleriRefs(
    Expression<bool> Function($$MenuOgeleriTableFilterComposer f) f,
  ) {
    final $$MenuOgeleriTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuOgeleri,
      getReferencedColumn: (t) => t.menuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuOgeleriTableFilterComposer(
            $db: $db,
            $table: $db.menuOgeleri,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MenulerTableOrderingComposer
    extends Composer<_$AppDatabase, $MenulerTable> {
  $$MenulerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get menuAdi => $composableBuilder(
    column: $table.menuAdi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tur => $composableBuilder(
    column: $table.tur,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MenulerTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenulerTable> {
  $$MenulerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get menuAdi =>
      $composableBuilder(column: $table.menuAdi, builder: (column) => column);

  GeneratedColumn<String> get tur =>
      $composableBuilder(column: $table.tur, builder: (column) => column);

  Expression<T> menuOgeleriRefs<T extends Object>(
    Expression<T> Function($$MenuOgeleriTableAnnotationComposer a) f,
  ) {
    final $$MenuOgeleriTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.menuOgeleri,
      getReferencedColumn: (t) => t.menuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenuOgeleriTableAnnotationComposer(
            $db: $db,
            $table: $db.menuOgeleri,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MenulerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenulerTable,
          Menu,
          $$MenulerTableFilterComposer,
          $$MenulerTableOrderingComposer,
          $$MenulerTableAnnotationComposer,
          $$MenulerTableCreateCompanionBuilder,
          $$MenulerTableUpdateCompanionBuilder,
          (Menu, $$MenulerTableReferences),
          Menu,
          PrefetchHooks Function({bool menuOgeleriRefs})
        > {
  $$MenulerTableTableManager(_$AppDatabase db, $MenulerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenulerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenulerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenulerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> menuAdi = const Value.absent(),
                Value<String> tur = const Value.absent(),
              }) => MenulerCompanion(id: id, menuAdi: menuAdi, tur: tur),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String menuAdi,
                Value<String> tur = const Value.absent(),
              }) => MenulerCompanion.insert(id: id, menuAdi: menuAdi, tur: tur),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MenulerTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({menuOgeleriRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (menuOgeleriRefs) db.menuOgeleri],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (menuOgeleriRefs)
                    await $_getPrefetchedData<Menu, $MenulerTable, MenuOgesi>(
                      currentTable: table,
                      referencedTable: $$MenulerTableReferences
                          ._menuOgeleriRefsTable(db),
                      managerFromTypedResult: (p0) => $$MenulerTableReferences(
                        db,
                        table,
                        p0,
                      ).menuOgeleriRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.menuId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MenulerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenulerTable,
      Menu,
      $$MenulerTableFilterComposer,
      $$MenulerTableOrderingComposer,
      $$MenulerTableAnnotationComposer,
      $$MenulerTableCreateCompanionBuilder,
      $$MenulerTableUpdateCompanionBuilder,
      (Menu, $$MenulerTableReferences),
      Menu,
      PrefetchHooks Function({bool menuOgeleriRefs})
    >;
typedef $$MenuOgeleriTableCreateCompanionBuilder =
    MenuOgeleriCompanion Function({
      Value<int> id,
      required int menuId,
      required int besinId,
      required double miktar,
    });
typedef $$MenuOgeleriTableUpdateCompanionBuilder =
    MenuOgeleriCompanion Function({
      Value<int> id,
      Value<int> menuId,
      Value<int> besinId,
      Value<double> miktar,
    });

final class $$MenuOgeleriTableReferences
    extends BaseReferences<_$AppDatabase, $MenuOgeleriTable, MenuOgesi> {
  $$MenuOgeleriTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MenulerTable _menuIdTable(_$AppDatabase db) => db.menuler.createAlias(
    $_aliasNameGenerator(db.menuOgeleri.menuId, db.menuler.id),
  );

  $$MenulerTableProcessedTableManager get menuId {
    final $_column = $_itemColumn<int>('menu_id')!;

    final manager = $$MenulerTableTableManager(
      $_db,
      $_db.menuler,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_menuIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BesinlerTable _besinIdTable(_$AppDatabase db) =>
      db.besinler.createAlias(
        $_aliasNameGenerator(db.menuOgeleri.besinId, db.besinler.id),
      );

  $$BesinlerTableProcessedTableManager get besinId {
    final $_column = $_itemColumn<int>('besin_id')!;

    final manager = $$BesinlerTableTableManager(
      $_db,
      $_db.besinler,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_besinIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MenuOgeleriTableFilterComposer
    extends Composer<_$AppDatabase, $MenuOgeleriTable> {
  $$MenuOgeleriTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get miktar => $composableBuilder(
    column: $table.miktar,
    builder: (column) => ColumnFilters(column),
  );

  $$MenulerTableFilterComposer get menuId {
    final $$MenulerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.menuler,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenulerTableFilterComposer(
            $db: $db,
            $table: $db.menuler,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BesinlerTableFilterComposer get besinId {
    final $$BesinlerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.besinId,
      referencedTable: $db.besinler,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BesinlerTableFilterComposer(
            $db: $db,
            $table: $db.besinler,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuOgeleriTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuOgeleriTable> {
  $$MenuOgeleriTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get miktar => $composableBuilder(
    column: $table.miktar,
    builder: (column) => ColumnOrderings(column),
  );

  $$MenulerTableOrderingComposer get menuId {
    final $$MenulerTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.menuler,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenulerTableOrderingComposer(
            $db: $db,
            $table: $db.menuler,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BesinlerTableOrderingComposer get besinId {
    final $$BesinlerTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.besinId,
      referencedTable: $db.besinler,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BesinlerTableOrderingComposer(
            $db: $db,
            $table: $db.besinler,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuOgeleriTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuOgeleriTable> {
  $$MenuOgeleriTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get miktar =>
      $composableBuilder(column: $table.miktar, builder: (column) => column);

  $$MenulerTableAnnotationComposer get menuId {
    final $$MenulerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.menuId,
      referencedTable: $db.menuler,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MenulerTableAnnotationComposer(
            $db: $db,
            $table: $db.menuler,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BesinlerTableAnnotationComposer get besinId {
    final $$BesinlerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.besinId,
      referencedTable: $db.besinler,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BesinlerTableAnnotationComposer(
            $db: $db,
            $table: $db.besinler,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MenuOgeleriTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenuOgeleriTable,
          MenuOgesi,
          $$MenuOgeleriTableFilterComposer,
          $$MenuOgeleriTableOrderingComposer,
          $$MenuOgeleriTableAnnotationComposer,
          $$MenuOgeleriTableCreateCompanionBuilder,
          $$MenuOgeleriTableUpdateCompanionBuilder,
          (MenuOgesi, $$MenuOgeleriTableReferences),
          MenuOgesi,
          PrefetchHooks Function({bool menuId, bool besinId})
        > {
  $$MenuOgeleriTableTableManager(_$AppDatabase db, $MenuOgeleriTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuOgeleriTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuOgeleriTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuOgeleriTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> menuId = const Value.absent(),
                Value<int> besinId = const Value.absent(),
                Value<double> miktar = const Value.absent(),
              }) => MenuOgeleriCompanion(
                id: id,
                menuId: menuId,
                besinId: besinId,
                miktar: miktar,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int menuId,
                required int besinId,
                required double miktar,
              }) => MenuOgeleriCompanion.insert(
                id: id,
                menuId: menuId,
                besinId: besinId,
                miktar: miktar,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MenuOgeleriTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({menuId = false, besinId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (menuId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.menuId,
                                referencedTable: $$MenuOgeleriTableReferences
                                    ._menuIdTable(db),
                                referencedColumn: $$MenuOgeleriTableReferences
                                    ._menuIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (besinId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.besinId,
                                referencedTable: $$MenuOgeleriTableReferences
                                    ._besinIdTable(db),
                                referencedColumn: $$MenuOgeleriTableReferences
                                    ._besinIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MenuOgeleriTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenuOgeleriTable,
      MenuOgesi,
      $$MenuOgeleriTableFilterComposer,
      $$MenuOgeleriTableOrderingComposer,
      $$MenuOgeleriTableAnnotationComposer,
      $$MenuOgeleriTableCreateCompanionBuilder,
      $$MenuOgeleriTableUpdateCompanionBuilder,
      (MenuOgesi, $$MenuOgeleriTableReferences),
      MenuOgesi,
      PrefetchHooks Function({bool menuId, bool besinId})
    >;
typedef $$GunlukKayitlarTableCreateCompanionBuilder =
    GunlukKayitlarCompanion Function({Value<int> id, required String tarih});
typedef $$GunlukKayitlarTableUpdateCompanionBuilder =
    GunlukKayitlarCompanion Function({Value<int> id, Value<String> tarih});

final class $$GunlukKayitlarTableReferences
    extends BaseReferences<_$AppDatabase, $GunlukKayitlarTable, GunlukKayit> {
  $$GunlukKayitlarTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$GunlukKayitOgeleriTable, List<GunlukKayitOgesi>>
  _gunlukKayitOgeleriRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gunlukKayitOgeleri,
        aliasName: $_aliasNameGenerator(
          db.gunlukKayitlar.id,
          db.gunlukKayitOgeleri.kayitId,
        ),
      );

  $$GunlukKayitOgeleriTableProcessedTableManager get gunlukKayitOgeleriRefs {
    final manager = $$GunlukKayitOgeleriTableTableManager(
      $_db,
      $_db.gunlukKayitOgeleri,
    ).filter((f) => f.kayitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _gunlukKayitOgeleriRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GunlukKayitlarTableFilterComposer
    extends Composer<_$AppDatabase, $GunlukKayitlarTable> {
  $$GunlukKayitlarTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tarih => $composableBuilder(
    column: $table.tarih,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gunlukKayitOgeleriRefs(
    Expression<bool> Function($$GunlukKayitOgeleriTableFilterComposer f) f,
  ) {
    final $$GunlukKayitOgeleriTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gunlukKayitOgeleri,
      getReferencedColumn: (t) => t.kayitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GunlukKayitOgeleriTableFilterComposer(
            $db: $db,
            $table: $db.gunlukKayitOgeleri,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GunlukKayitlarTableOrderingComposer
    extends Composer<_$AppDatabase, $GunlukKayitlarTable> {
  $$GunlukKayitlarTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tarih => $composableBuilder(
    column: $table.tarih,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GunlukKayitlarTableAnnotationComposer
    extends Composer<_$AppDatabase, $GunlukKayitlarTable> {
  $$GunlukKayitlarTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tarih =>
      $composableBuilder(column: $table.tarih, builder: (column) => column);

  Expression<T> gunlukKayitOgeleriRefs<T extends Object>(
    Expression<T> Function($$GunlukKayitOgeleriTableAnnotationComposer a) f,
  ) {
    final $$GunlukKayitOgeleriTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gunlukKayitOgeleri,
          getReferencedColumn: (t) => t.kayitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GunlukKayitOgeleriTableAnnotationComposer(
                $db: $db,
                $table: $db.gunlukKayitOgeleri,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GunlukKayitlarTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GunlukKayitlarTable,
          GunlukKayit,
          $$GunlukKayitlarTableFilterComposer,
          $$GunlukKayitlarTableOrderingComposer,
          $$GunlukKayitlarTableAnnotationComposer,
          $$GunlukKayitlarTableCreateCompanionBuilder,
          $$GunlukKayitlarTableUpdateCompanionBuilder,
          (GunlukKayit, $$GunlukKayitlarTableReferences),
          GunlukKayit,
          PrefetchHooks Function({bool gunlukKayitOgeleriRefs})
        > {
  $$GunlukKayitlarTableTableManager(
    _$AppDatabase db,
    $GunlukKayitlarTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GunlukKayitlarTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GunlukKayitlarTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GunlukKayitlarTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tarih = const Value.absent(),
              }) => GunlukKayitlarCompanion(id: id, tarih: tarih),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String tarih}) =>
                  GunlukKayitlarCompanion.insert(id: id, tarih: tarih),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GunlukKayitlarTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gunlukKayitOgeleriRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (gunlukKayitOgeleriRefs) db.gunlukKayitOgeleri,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (gunlukKayitOgeleriRefs)
                    await $_getPrefetchedData<
                      GunlukKayit,
                      $GunlukKayitlarTable,
                      GunlukKayitOgesi
                    >(
                      currentTable: table,
                      referencedTable: $$GunlukKayitlarTableReferences
                          ._gunlukKayitOgeleriRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GunlukKayitlarTableReferences(
                            db,
                            table,
                            p0,
                          ).gunlukKayitOgeleriRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.kayitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GunlukKayitlarTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GunlukKayitlarTable,
      GunlukKayit,
      $$GunlukKayitlarTableFilterComposer,
      $$GunlukKayitlarTableOrderingComposer,
      $$GunlukKayitlarTableAnnotationComposer,
      $$GunlukKayitlarTableCreateCompanionBuilder,
      $$GunlukKayitlarTableUpdateCompanionBuilder,
      (GunlukKayit, $$GunlukKayitlarTableReferences),
      GunlukKayit,
      PrefetchHooks Function({bool gunlukKayitOgeleriRefs})
    >;
typedef $$GunlukKayitOgeleriTableCreateCompanionBuilder =
    GunlukKayitOgeleriCompanion Function({
      Value<int> id,
      required int kayitId,
      required int besinId,
      required double miktar,
    });
typedef $$GunlukKayitOgeleriTableUpdateCompanionBuilder =
    GunlukKayitOgeleriCompanion Function({
      Value<int> id,
      Value<int> kayitId,
      Value<int> besinId,
      Value<double> miktar,
    });

final class $$GunlukKayitOgeleriTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GunlukKayitOgeleriTable,
          GunlukKayitOgesi
        > {
  $$GunlukKayitOgeleriTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GunlukKayitlarTable _kayitIdTable(_$AppDatabase db) =>
      db.gunlukKayitlar.createAlias(
        $_aliasNameGenerator(
          db.gunlukKayitOgeleri.kayitId,
          db.gunlukKayitlar.id,
        ),
      );

  $$GunlukKayitlarTableProcessedTableManager get kayitId {
    final $_column = $_itemColumn<int>('kayit_id')!;

    final manager = $$GunlukKayitlarTableTableManager(
      $_db,
      $_db.gunlukKayitlar,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kayitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BesinlerTable _besinIdTable(_$AppDatabase db) =>
      db.besinler.createAlias(
        $_aliasNameGenerator(db.gunlukKayitOgeleri.besinId, db.besinler.id),
      );

  $$BesinlerTableProcessedTableManager get besinId {
    final $_column = $_itemColumn<int>('besin_id')!;

    final manager = $$BesinlerTableTableManager(
      $_db,
      $_db.besinler,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_besinIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GunlukKayitOgeleriTableFilterComposer
    extends Composer<_$AppDatabase, $GunlukKayitOgeleriTable> {
  $$GunlukKayitOgeleriTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get miktar => $composableBuilder(
    column: $table.miktar,
    builder: (column) => ColumnFilters(column),
  );

  $$GunlukKayitlarTableFilterComposer get kayitId {
    final $$GunlukKayitlarTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kayitId,
      referencedTable: $db.gunlukKayitlar,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GunlukKayitlarTableFilterComposer(
            $db: $db,
            $table: $db.gunlukKayitlar,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BesinlerTableFilterComposer get besinId {
    final $$BesinlerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.besinId,
      referencedTable: $db.besinler,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BesinlerTableFilterComposer(
            $db: $db,
            $table: $db.besinler,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GunlukKayitOgeleriTableOrderingComposer
    extends Composer<_$AppDatabase, $GunlukKayitOgeleriTable> {
  $$GunlukKayitOgeleriTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get miktar => $composableBuilder(
    column: $table.miktar,
    builder: (column) => ColumnOrderings(column),
  );

  $$GunlukKayitlarTableOrderingComposer get kayitId {
    final $$GunlukKayitlarTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kayitId,
      referencedTable: $db.gunlukKayitlar,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GunlukKayitlarTableOrderingComposer(
            $db: $db,
            $table: $db.gunlukKayitlar,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BesinlerTableOrderingComposer get besinId {
    final $$BesinlerTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.besinId,
      referencedTable: $db.besinler,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BesinlerTableOrderingComposer(
            $db: $db,
            $table: $db.besinler,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GunlukKayitOgeleriTableAnnotationComposer
    extends Composer<_$AppDatabase, $GunlukKayitOgeleriTable> {
  $$GunlukKayitOgeleriTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get miktar =>
      $composableBuilder(column: $table.miktar, builder: (column) => column);

  $$GunlukKayitlarTableAnnotationComposer get kayitId {
    final $$GunlukKayitlarTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kayitId,
      referencedTable: $db.gunlukKayitlar,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GunlukKayitlarTableAnnotationComposer(
            $db: $db,
            $table: $db.gunlukKayitlar,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BesinlerTableAnnotationComposer get besinId {
    final $$BesinlerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.besinId,
      referencedTable: $db.besinler,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BesinlerTableAnnotationComposer(
            $db: $db,
            $table: $db.besinler,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GunlukKayitOgeleriTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GunlukKayitOgeleriTable,
          GunlukKayitOgesi,
          $$GunlukKayitOgeleriTableFilterComposer,
          $$GunlukKayitOgeleriTableOrderingComposer,
          $$GunlukKayitOgeleriTableAnnotationComposer,
          $$GunlukKayitOgeleriTableCreateCompanionBuilder,
          $$GunlukKayitOgeleriTableUpdateCompanionBuilder,
          (GunlukKayitOgesi, $$GunlukKayitOgeleriTableReferences),
          GunlukKayitOgesi,
          PrefetchHooks Function({bool kayitId, bool besinId})
        > {
  $$GunlukKayitOgeleriTableTableManager(
    _$AppDatabase db,
    $GunlukKayitOgeleriTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GunlukKayitOgeleriTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GunlukKayitOgeleriTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GunlukKayitOgeleriTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> kayitId = const Value.absent(),
                Value<int> besinId = const Value.absent(),
                Value<double> miktar = const Value.absent(),
              }) => GunlukKayitOgeleriCompanion(
                id: id,
                kayitId: kayitId,
                besinId: besinId,
                miktar: miktar,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int kayitId,
                required int besinId,
                required double miktar,
              }) => GunlukKayitOgeleriCompanion.insert(
                id: id,
                kayitId: kayitId,
                besinId: besinId,
                miktar: miktar,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GunlukKayitOgeleriTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({kayitId = false, besinId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (kayitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.kayitId,
                                referencedTable:
                                    $$GunlukKayitOgeleriTableReferences
                                        ._kayitIdTable(db),
                                referencedColumn:
                                    $$GunlukKayitOgeleriTableReferences
                                        ._kayitIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (besinId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.besinId,
                                referencedTable:
                                    $$GunlukKayitOgeleriTableReferences
                                        ._besinIdTable(db),
                                referencedColumn:
                                    $$GunlukKayitOgeleriTableReferences
                                        ._besinIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GunlukKayitOgeleriTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GunlukKayitOgeleriTable,
      GunlukKayitOgesi,
      $$GunlukKayitOgeleriTableFilterComposer,
      $$GunlukKayitOgeleriTableOrderingComposer,
      $$GunlukKayitOgeleriTableAnnotationComposer,
      $$GunlukKayitOgeleriTableCreateCompanionBuilder,
      $$GunlukKayitOgeleriTableUpdateCompanionBuilder,
      (GunlukKayitOgesi, $$GunlukKayitOgeleriTableReferences),
      GunlukKayitOgesi,
      PrefetchHooks Function({bool kayitId, bool besinId})
    >;
typedef $$KullaniciHedefleriTableCreateCompanionBuilder =
    KullaniciHedefleriCompanion Function({
      Value<int> id,
      required double kalori,
      required double karb,
      required double pro,
      required double yag,
    });
typedef $$KullaniciHedefleriTableUpdateCompanionBuilder =
    KullaniciHedefleriCompanion Function({
      Value<int> id,
      Value<double> kalori,
      Value<double> karb,
      Value<double> pro,
      Value<double> yag,
    });

class $$KullaniciHedefleriTableFilterComposer
    extends Composer<_$AppDatabase, $KullaniciHedefleriTable> {
  $$KullaniciHedefleriTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kalori => $composableBuilder(
    column: $table.kalori,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get karb => $composableBuilder(
    column: $table.karb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pro => $composableBuilder(
    column: $table.pro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yag => $composableBuilder(
    column: $table.yag,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KullaniciHedefleriTableOrderingComposer
    extends Composer<_$AppDatabase, $KullaniciHedefleriTable> {
  $$KullaniciHedefleriTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kalori => $composableBuilder(
    column: $table.kalori,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get karb => $composableBuilder(
    column: $table.karb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pro => $composableBuilder(
    column: $table.pro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yag => $composableBuilder(
    column: $table.yag,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KullaniciHedefleriTableAnnotationComposer
    extends Composer<_$AppDatabase, $KullaniciHedefleriTable> {
  $$KullaniciHedefleriTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get kalori =>
      $composableBuilder(column: $table.kalori, builder: (column) => column);

  GeneratedColumn<double> get karb =>
      $composableBuilder(column: $table.karb, builder: (column) => column);

  GeneratedColumn<double> get pro =>
      $composableBuilder(column: $table.pro, builder: (column) => column);

  GeneratedColumn<double> get yag =>
      $composableBuilder(column: $table.yag, builder: (column) => column);
}

class $$KullaniciHedefleriTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KullaniciHedefleriTable,
          KullaniciHedef,
          $$KullaniciHedefleriTableFilterComposer,
          $$KullaniciHedefleriTableOrderingComposer,
          $$KullaniciHedefleriTableAnnotationComposer,
          $$KullaniciHedefleriTableCreateCompanionBuilder,
          $$KullaniciHedefleriTableUpdateCompanionBuilder,
          (
            KullaniciHedef,
            BaseReferences<
              _$AppDatabase,
              $KullaniciHedefleriTable,
              KullaniciHedef
            >,
          ),
          KullaniciHedef,
          PrefetchHooks Function()
        > {
  $$KullaniciHedefleriTableTableManager(
    _$AppDatabase db,
    $KullaniciHedefleriTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KullaniciHedefleriTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KullaniciHedefleriTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KullaniciHedefleriTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> kalori = const Value.absent(),
                Value<double> karb = const Value.absent(),
                Value<double> pro = const Value.absent(),
                Value<double> yag = const Value.absent(),
              }) => KullaniciHedefleriCompanion(
                id: id,
                kalori: kalori,
                karb: karb,
                pro: pro,
                yag: yag,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double kalori,
                required double karb,
                required double pro,
                required double yag,
              }) => KullaniciHedefleriCompanion.insert(
                id: id,
                kalori: kalori,
                karb: karb,
                pro: pro,
                yag: yag,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KullaniciHedefleriTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KullaniciHedefleriTable,
      KullaniciHedef,
      $$KullaniciHedefleriTableFilterComposer,
      $$KullaniciHedefleriTableOrderingComposer,
      $$KullaniciHedefleriTableAnnotationComposer,
      $$KullaniciHedefleriTableCreateCompanionBuilder,
      $$KullaniciHedefleriTableUpdateCompanionBuilder,
      (
        KullaniciHedef,
        BaseReferences<_$AppDatabase, $KullaniciHedefleriTable, KullaniciHedef>,
      ),
      KullaniciHedef,
      PrefetchHooks Function()
    >;
typedef $$OlcumlerTableCreateCompanionBuilder =
    OlcumlerCompanion Function({
      Value<int> id,
      required String tarih,
      required String cinsiyet,
      required double kilo,
      Value<double?> bel,
      Value<double?> boyun,
      Value<double?> kalca,
    });
typedef $$OlcumlerTableUpdateCompanionBuilder =
    OlcumlerCompanion Function({
      Value<int> id,
      Value<String> tarih,
      Value<String> cinsiyet,
      Value<double> kilo,
      Value<double?> bel,
      Value<double?> boyun,
      Value<double?> kalca,
    });

class $$OlcumlerTableFilterComposer
    extends Composer<_$AppDatabase, $OlcumlerTable> {
  $$OlcumlerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tarih => $composableBuilder(
    column: $table.tarih,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cinsiyet => $composableBuilder(
    column: $table.cinsiyet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kilo => $composableBuilder(
    column: $table.kilo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bel => $composableBuilder(
    column: $table.bel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get boyun => $composableBuilder(
    column: $table.boyun,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kalca => $composableBuilder(
    column: $table.kalca,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OlcumlerTableOrderingComposer
    extends Composer<_$AppDatabase, $OlcumlerTable> {
  $$OlcumlerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tarih => $composableBuilder(
    column: $table.tarih,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cinsiyet => $composableBuilder(
    column: $table.cinsiyet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kilo => $composableBuilder(
    column: $table.kilo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bel => $composableBuilder(
    column: $table.bel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get boyun => $composableBuilder(
    column: $table.boyun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kalca => $composableBuilder(
    column: $table.kalca,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OlcumlerTableAnnotationComposer
    extends Composer<_$AppDatabase, $OlcumlerTable> {
  $$OlcumlerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tarih =>
      $composableBuilder(column: $table.tarih, builder: (column) => column);

  GeneratedColumn<String> get cinsiyet =>
      $composableBuilder(column: $table.cinsiyet, builder: (column) => column);

  GeneratedColumn<double> get kilo =>
      $composableBuilder(column: $table.kilo, builder: (column) => column);

  GeneratedColumn<double> get bel =>
      $composableBuilder(column: $table.bel, builder: (column) => column);

  GeneratedColumn<double> get boyun =>
      $composableBuilder(column: $table.boyun, builder: (column) => column);

  GeneratedColumn<double> get kalca =>
      $composableBuilder(column: $table.kalca, builder: (column) => column);
}

class $$OlcumlerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OlcumlerTable,
          Olcum,
          $$OlcumlerTableFilterComposer,
          $$OlcumlerTableOrderingComposer,
          $$OlcumlerTableAnnotationComposer,
          $$OlcumlerTableCreateCompanionBuilder,
          $$OlcumlerTableUpdateCompanionBuilder,
          (Olcum, BaseReferences<_$AppDatabase, $OlcumlerTable, Olcum>),
          Olcum,
          PrefetchHooks Function()
        > {
  $$OlcumlerTableTableManager(_$AppDatabase db, $OlcumlerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OlcumlerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OlcumlerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OlcumlerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tarih = const Value.absent(),
                Value<String> cinsiyet = const Value.absent(),
                Value<double> kilo = const Value.absent(),
                Value<double?> bel = const Value.absent(),
                Value<double?> boyun = const Value.absent(),
                Value<double?> kalca = const Value.absent(),
              }) => OlcumlerCompanion(
                id: id,
                tarih: tarih,
                cinsiyet: cinsiyet,
                kilo: kilo,
                bel: bel,
                boyun: boyun,
                kalca: kalca,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tarih,
                required String cinsiyet,
                required double kilo,
                Value<double?> bel = const Value.absent(),
                Value<double?> boyun = const Value.absent(),
                Value<double?> kalca = const Value.absent(),
              }) => OlcumlerCompanion.insert(
                id: id,
                tarih: tarih,
                cinsiyet: cinsiyet,
                kilo: kilo,
                bel: bel,
                boyun: boyun,
                kalca: kalca,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OlcumlerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OlcumlerTable,
      Olcum,
      $$OlcumlerTableFilterComposer,
      $$OlcumlerTableOrderingComposer,
      $$OlcumlerTableAnnotationComposer,
      $$OlcumlerTableCreateCompanionBuilder,
      $$OlcumlerTableUpdateCompanionBuilder,
      (Olcum, BaseReferences<_$AppDatabase, $OlcumlerTable, Olcum>),
      Olcum,
      PrefetchHooks Function()
    >;
typedef $$KullaniciAyarlariTableCreateCompanionBuilder =
    KullaniciAyarlariCompanion Function({Value<int> id, required double boy});
typedef $$KullaniciAyarlariTableUpdateCompanionBuilder =
    KullaniciAyarlariCompanion Function({Value<int> id, Value<double> boy});

class $$KullaniciAyarlariTableFilterComposer
    extends Composer<_$AppDatabase, $KullaniciAyarlariTable> {
  $$KullaniciAyarlariTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get boy => $composableBuilder(
    column: $table.boy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KullaniciAyarlariTableOrderingComposer
    extends Composer<_$AppDatabase, $KullaniciAyarlariTable> {
  $$KullaniciAyarlariTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get boy => $composableBuilder(
    column: $table.boy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KullaniciAyarlariTableAnnotationComposer
    extends Composer<_$AppDatabase, $KullaniciAyarlariTable> {
  $$KullaniciAyarlariTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get boy =>
      $composableBuilder(column: $table.boy, builder: (column) => column);
}

class $$KullaniciAyarlariTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KullaniciAyarlariTable,
          KullaniciAyar,
          $$KullaniciAyarlariTableFilterComposer,
          $$KullaniciAyarlariTableOrderingComposer,
          $$KullaniciAyarlariTableAnnotationComposer,
          $$KullaniciAyarlariTableCreateCompanionBuilder,
          $$KullaniciAyarlariTableUpdateCompanionBuilder,
          (
            KullaniciAyar,
            BaseReferences<
              _$AppDatabase,
              $KullaniciAyarlariTable,
              KullaniciAyar
            >,
          ),
          KullaniciAyar,
          PrefetchHooks Function()
        > {
  $$KullaniciAyarlariTableTableManager(
    _$AppDatabase db,
    $KullaniciAyarlariTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KullaniciAyarlariTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KullaniciAyarlariTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KullaniciAyarlariTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> boy = const Value.absent(),
              }) => KullaniciAyarlariCompanion(id: id, boy: boy),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required double boy}) =>
                  KullaniciAyarlariCompanion.insert(id: id, boy: boy),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KullaniciAyarlariTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KullaniciAyarlariTable,
      KullaniciAyar,
      $$KullaniciAyarlariTableFilterComposer,
      $$KullaniciAyarlariTableOrderingComposer,
      $$KullaniciAyarlariTableAnnotationComposer,
      $$KullaniciAyarlariTableCreateCompanionBuilder,
      $$KullaniciAyarlariTableUpdateCompanionBuilder,
      (
        KullaniciAyar,
        BaseReferences<_$AppDatabase, $KullaniciAyarlariTable, KullaniciAyar>,
      ),
      KullaniciAyar,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BesinlerTableTableManager get besinler =>
      $$BesinlerTableTableManager(_db, _db.besinler);
  $$MenulerTableTableManager get menuler =>
      $$MenulerTableTableManager(_db, _db.menuler);
  $$MenuOgeleriTableTableManager get menuOgeleri =>
      $$MenuOgeleriTableTableManager(_db, _db.menuOgeleri);
  $$GunlukKayitlarTableTableManager get gunlukKayitlar =>
      $$GunlukKayitlarTableTableManager(_db, _db.gunlukKayitlar);
  $$GunlukKayitOgeleriTableTableManager get gunlukKayitOgeleri =>
      $$GunlukKayitOgeleriTableTableManager(_db, _db.gunlukKayitOgeleri);
  $$KullaniciHedefleriTableTableManager get kullaniciHedefleri =>
      $$KullaniciHedefleriTableTableManager(_db, _db.kullaniciHedefleri);
  $$OlcumlerTableTableManager get olcumler =>
      $$OlcumlerTableTableManager(_db, _db.olcumler);
  $$KullaniciAyarlariTableTableManager get kullaniciAyarlari =>
      $$KullaniciAyarlariTableTableManager(_db, _db.kullaniciAyarlari);
}
