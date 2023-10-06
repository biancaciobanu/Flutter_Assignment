import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../domain/entities/contact.dart';

class ContactData {
  static const String _tableName = 'contacts';
  static const String _columnId = 'id';
  static const String _columnName = 'name';
  static const String _columnMobilePhoneNumber = 'mobilePhoneNumber';
  static const String _columnLandlineNumber = 'landlineNumber';
  static const String _columnIsFavorite = 'isFavorite';

  Future<Database> _initializeDatabase() async {
    final String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'contacts.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_tableName (
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnName TEXT,
            $_columnMobilePhoneNumber TEXT,
            $_columnLandlineNumber TEXT,
            $_columnIsFavorite INTEGER
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> addContact(Contact contact) async {
    final Database db = await _initializeDatabase();
    await db.insert(
      _tableName,
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contact>> getContacts() async {
    final Database db = await _initializeDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (index) {
      return Contact.fromMap(maps[index]);
    });
  }

  Future<Contact> getContactById(int id) async {
    final Database db = await _initializeDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      throw Exception('Contact not found');
    }
  }

  Future<void> updateContact(Contact contact) async {
    final Database db = await _initializeDatabase();
    await db.update(
      _tableName,
      contact.toMap(),
      where: '$_columnId = ?',
      whereArgs: [contact.id],
    );
  }

  Future<void> deleteContact(int id) async {
    final Database db = await _initializeDatabase();
    await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
}
