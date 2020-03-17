import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class MySearch {
  String search;
  MySearch(this.search);
  Map<String, dynamic> toMap() {
    return {
      "search": search,
    };
  }

  MySearch.fromMap(Map<String, dynamic> map) {
    search = map['search'];
  }
}

class MyDatabase {
  static final MyDatabase _instance = MyDatabase._();
  Database _db;

  MyDatabase._();
  factory MyDatabase() {
    return _instance;
  }

  Future<Database> openBd() async {
    if (_db != null) {
      return _db;
    }
    _db = await init();

    return _db;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'database.db');
    var database = openDatabase(dbPath,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE mysearch(
      search TEXT primary key)
  ''');
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {}

//own
  Future<int> insert(MySearch mySearch) async {
    await openBd();

    return await _db.insert('mysearch', mySearch.toMap());
  }

  Future getAllSearch() async {
    await openBd();
    /*
    List<Map<String, dynamic>> results = await _db.query('mysearch');
    List<MySearch> search = new List();
    results.map((map) => search.add(MySearch.fromMap(map)));
    return search;*/
    List<Map> result = await _db.query('mysearch');
    List<MySearch> search = new List();
    result.forEach((row) {
      search.add(MySearch.fromMap(row));
    });
    return search;
  }
}
