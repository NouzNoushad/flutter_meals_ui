import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class Db {
  Database? db;
  Future open() async {
    sqfliteFfiInit();
    var databasePath = await databaseFactoryFfi.getDatabasesPath();
    String path = join(databasePath, 'mealsDB.db');
    DatabaseFactory databaseFactory = databaseFactoryFfi;

    db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
          version: 1,
          onCreate: (Database db, int index) async {
            await db.execute('''
                CREATE TABLE meals (
                  id integer primary key autoIncrement,
                  name varchar(255) not null,
                  image varchar(255) not null,
                  price double not null
                );
              ''');
          }),
    );
  }
}
