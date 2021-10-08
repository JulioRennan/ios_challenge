import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Dao {
  late var path;
  late Database dataBase;
  String tableRepository = "table_repository";
  Future<void> init() async {
    path = (await getDatabasesPath() + "/core_data.db");
    dataBase = await openDatabase(path);

    dataBase.execute(
        "CREATE TABLE IF NOT EXISTS $tableRepository ($columnsRepository)");
  }

  String get columnsRepository {
    return [
      "id INTEGER PRiMARY KEY",
      "owner_name TEXT",
      "owner_url_avatar TEXT",
      "stargazers_count INTEGER",
      "name TEXT",
      "full_name TEXT",
      "language TEXT",
      "description TEXT"
    ].join(",");
  }
}
