import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'dart:io';
part 'database.g.dart';

class Appointments extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get czas => dateTime()();
  TextColumn get title => text()();
}

@UseMoor(tables:[Appointments])
class MyDatabase extends _$MyDatabase {

  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;
/*  Future<int> addWydarzenie(AppointmentsCompanion entry) {
    return into(appointments).insert(entry);
  }
  */
  Future<List<Appointment>> getAppointmentsTimed({DateTime czas}) {
    final _select = select(appointments);
    if (czas != null) {
      _select..where((tbl) => tbl.czas.equals(czas));
    }
    return _select.get();
  }
  Future<List<Appointment>> getAllAppointments() => select(appointments).get();
  Future deleteAppointment(czas,tekst) {
    return (delete(appointments)..where((t) => t.title.like(tekst))..where((t) => t.czas.equals(czas))).go();
  }
  Future<int> addAppointment(AppointmentsCompanion entry) {
    return into(appointments).insert(entry);
  }
  /*
  Future<List<>>*/
  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
}


LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}