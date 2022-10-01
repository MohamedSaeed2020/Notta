import 'dart:async';
import 'dart:developer';
import 'package:notes/core/network/local/local_database_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabaseHelper {
  //Make this a lazy singleton class
  LocalDatabaseHelper._privateConstructor();

  static LocalDatabaseHelper? _instance;

  static LocalDatabaseHelper? get instance {
    _instance ??= LocalDatabaseHelper._privateConstructor();
    return _instance;
  }

  //Only have a single app-wide reference to the database
  static Database? _database;
  static Future<Database?> get database async {
    // lazily instantiate the db the first time it is accessed
    if (_database == null) {
      _database = await initializeDatabase_();
      return _database;
    } else {
      return _database;
    }
  }

  static Future<Database> initializeDatabase_() async {
    String databasePath =
        await getDatabasesPath(); //data/data//databases (Android)
    String path = join(databasePath, LocalDatabaseConstants.dataBaseName);

    //This opens the database (and creates it if it doesn't exist)
    Database database = await openDatabase(path,
        version: LocalDatabaseConstants.dataBaseVersion,
        onCreate: _createDatabase,
        onUpgrade: _upgradeDatabase,
        onOpen: _openDatabase);
    return database;
  }

  static FutureOr<void> _createDatabase(Database db, int version) async {
    log("Database hase been created successfully!");
    Future.wait(
        [createInterestTable(db), createUserTable(db), createNoteTable(db)]);
  }

  static FutureOr<void> _openDatabase(Database db) {
    log("Database hase been opened successfully!");
  }

  static FutureOr<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) {
    log("Database hase been upgraded successfully!");
  }

  static Future<void> createInterestTable(Database db) async {
    await db.execute('''
    ${LocalDatabaseConstants.createTableSql} interest (
    id ${LocalDatabaseConstants.primaryKeyProperties}, 
    intrestText ${LocalDatabaseConstants.textFieldProperties}
    )
   ''').then((value) {
      log("Table Interest hase been created successfully!");
    }).catchError((error) {
      log("Error hase been occurred in table interest: ${error.toString()}");
    });
  }

  static  Future<void> createUserTable(Database db) async {
    await db.execute('''
    ${LocalDatabaseConstants.createTableSql} user (
    id ${LocalDatabaseConstants.primaryKeyProperties}, 
    username ${LocalDatabaseConstants.textFieldProperties},
    password ${LocalDatabaseConstants.textFieldProperties},
    email ${LocalDatabaseConstants.textFieldProperties},
    intrestId ${LocalDatabaseConstants.textFieldProperties},
    imageAsBase64 ${LocalDatabaseConstants.textFieldProperties}
    )
   ''').then((value) {
      log("Table User hase been created successfully!");
    }).catchError((error) {
      log("Error hase been occurred in table user: ${error.toString()}");
    });
  }

  static Future<void> createNoteTable(Database db) async {
    await db.execute('''
    ${LocalDatabaseConstants.createTableSql} note (
    id ${LocalDatabaseConstants.primaryKeyProperties}, 
    text ${LocalDatabaseConstants.textFieldProperties},
    placeDateTime ${LocalDatabaseConstants.textFieldProperties},
    userId ${LocalDatabaseConstants.textFieldProperties}
    )
   ''').then((value) {
      log("Table Note hase been created successfully!");
    }).catchError((error) {
      log("Error hase been occurred in table note: ${error.toString()}");
    });
  }

  static Future<void> deleteTableData(String tableName) async {
    Database? db = await database;
    await db!
        .execute('${LocalDatabaseConstants.deleteTableContentsSql} $tableName');
    log("deleteTableData!");
  }

  static Future<List<Map<String, Object?>>> getDataFromDatabase(
      String sqlStatement) async {
    Database? db = await database;
    List<Map<String, Object?>> data = await db!.rawQuery(sqlStatement);
    log("Data hase been returned successfully!");
    return data;
  }

  static Future<int> insertDataIntoDatabase(String sqlStatement) async {
    Database? db = await database;
    int rowNumber = await db!.rawInsert(sqlStatement);
    log("Database hase been inserted successfully! $rowNumber");
    return rowNumber;
  }

  static Future<int> updateDataFromDatabase(
      String sqlStatement, List<Object?>? arguments) async {
    Database? db = await database;
    int rowNumber = await db!.rawUpdate(sqlStatement, arguments);
    log("Database hase been updated successfully! $rowNumber");
    return rowNumber;
  }

  //DELETE from tasks WHERE id = ?', [id]
  static Future<int> deleteDataFromDatabase(String sqlStatement) async {
    Database? db = await database;
    int rowNumber = await db!.rawDelete(sqlStatement);
    log("Task hase been deleted successfully! $rowNumber");
    return rowNumber;
  }

  static Future<void> deleteMyDatabase() async {
    String databasePath =
        await getDatabasesPath(); //data/data//databases (Android)
    String path = join(databasePath, LocalDatabaseConstants.dataBaseName);
    await deleteDatabase(path);
  }

  static Future<void> dropTable(String tableName) async {
    Database? db = await database;
    await db!.execute('${LocalDatabaseConstants.deleteTableSql} $tableName');
  }
}
