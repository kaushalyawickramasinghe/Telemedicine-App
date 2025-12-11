import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  LocalDB._privateConstructor();
  static final LocalDB instance = LocalDB._privateConstructor();

  Database? _db;

  Future<void> init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'careplus_local.db');
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE appointments(
        id TEXT PRIMARY KEY,
        doctor TEXT,
        patient TEXT,
        scheduled_at TEXT,
        status TEXT,
        synced INTEGER DEFAULT 0
      )
    ''');
  }

  Future<void> insertAppointment(Map<String, dynamic> appt) async {
    await _db!.insert('appointments', {...appt, 'synced': 0}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getUnsyncedAppointments() async {
    return await _db!.query('appointments', where: 'synced = ?', whereArgs: [0]);
  }

  Future<void> markAppointmentSynced(String id) async {
    await _db!.update('appointments', {'synced': 1}, where: 'id = ?', whereArgs: [id]);
  }

  // Example sync: push local unsynced appointments to server via provided function
  Future<void> syncAppointments(Future<void> Function(Map<String, dynamic>) pushToServer) async {
    final unsynced = await getUnsyncedAppointments();
    for (final row in unsynced) {
      try {
        await pushToServer(row);
        await markAppointmentSynced(row['id'] as String);
      } catch (e) {
        // leave unsynced for next attempt
      }
    }
  }
}