class LocalDatabaseConstants {
  static const String dataBaseName = 'notes.db';
  static const int dataBaseVersion = 1;
  static const String createTableSql = 'CREATE TABLE';
  static const String primaryKeyProperties = 'INTEGER PRIMARY KEY NOT NULL';
  static const String textFieldProperties = 'TEXT NOT NULL';
  static const String deleteTableContentsSql = 'DELETE FROM';
  static const String deleteTableSql = 'DROP TABLE IF EXISTS';
  static const String getAllDataFromTableSql = 'SELECT * FROM';
  static const String insertDataIntoTableSql = 'INSERT INTO';
}
