// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Appointment extends DataClass implements Insertable<Appointment> {
  final int id;
  final DateTime czas;
  final String title;
  Appointment({@required this.id, @required this.czas, @required this.title});
  factory Appointment.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Appointment(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      czas: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}czas']),
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || czas != null) {
      map['czas'] = Variable<DateTime>(czas);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    return map;
  }

  AppointmentsCompanion toCompanion(bool nullToAbsent) {
    return AppointmentsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      czas: czas == null && nullToAbsent ? const Value.absent() : Value(czas),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
    );
  }

  factory Appointment.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Appointment(
      id: serializer.fromJson<int>(json['id']),
      czas: serializer.fromJson<DateTime>(json['czas']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'czas': serializer.toJson<DateTime>(czas),
      'title': serializer.toJson<String>(title),
    };
  }

  Appointment copyWith({int id, DateTime czas, String title}) => Appointment(
        id: id ?? this.id,
        czas: czas ?? this.czas,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('Appointment(')
          ..write('id: $id, ')
          ..write('czas: $czas, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(czas.hashCode, title.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Appointment &&
          other.id == this.id &&
          other.czas == this.czas &&
          other.title == this.title);
}

class AppointmentsCompanion extends UpdateCompanion<Appointment> {
  final Value<int> id;
  final Value<DateTime> czas;
  final Value<String> title;
  const AppointmentsCompanion({
    this.id = const Value.absent(),
    this.czas = const Value.absent(),
    this.title = const Value.absent(),
  });
  AppointmentsCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime czas,
    @required String title,
  })  : czas = Value(czas),
        title = Value(title);
  static Insertable<Appointment> custom({
    Expression<int> id,
    Expression<DateTime> czas,
    Expression<String> title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (czas != null) 'czas': czas,
      if (title != null) 'title': title,
    });
  }

  AppointmentsCompanion copyWith(
      {Value<int> id, Value<DateTime> czas, Value<String> title}) {
    return AppointmentsCompanion(
      id: id ?? this.id,
      czas: czas ?? this.czas,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (czas.present) {
      map['czas'] = Variable<DateTime>(czas.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsCompanion(')
          ..write('id: $id, ')
          ..write('czas: $czas, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $AppointmentsTable extends Appointments
    with TableInfo<$AppointmentsTable, Appointment> {
  final GeneratedDatabase _db;
  final String _alias;
  $AppointmentsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _czasMeta = const VerificationMeta('czas');
  GeneratedDateTimeColumn _czas;
  @override
  GeneratedDateTimeColumn get czas => _czas ??= _constructCzas();
  GeneratedDateTimeColumn _constructCzas() {
    return GeneratedDateTimeColumn(
      'czas',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, czas, title];
  @override
  $AppointmentsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'appointments';
  @override
  final String actualTableName = 'appointments';
  @override
  VerificationContext validateIntegrity(Insertable<Appointment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('czas')) {
      context.handle(
          _czasMeta, czas.isAcceptableOrUnknown(data['czas'], _czasMeta));
    } else if (isInserting) {
      context.missing(_czasMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Appointment map(Map<String, dynamic> data, {String tablePrefix}) {
    return Appointment.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AppointmentsTable createAlias(String alias) {
    return $AppointmentsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $AppointmentsTable _appointments;
  $AppointmentsTable get appointments =>
      _appointments ??= $AppointmentsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [appointments];
}
