import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Model/usermodel.dart';
import 'package:lexiquest/Features/Quest/Domain/queststatus.dart';
import 'package:lexiquest/Features/Quest/Domain/questtype.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  static final Databasehelper _instance = Databasehelper._internal();
  factory Databasehelper() => _instance;
  Databasehelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'lexiquest.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        uid TEXT PRIMARY KEY,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        profilepicture TEXT,
        userXp INTEGER,
        userlevel INTEGER,
        streak INTEGER,
        leaderboardRank INTEGER,
        scannedWords TEXT,
        completedQuests TEXT,
        incompletedQuests TEXT,
        languagesExplored TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE quests(
        uid TEXT PRIMARY KEY,
        questName TEXT NOT NULL,
        status TEXT,
        questType TEXT,
        questHint TEXT,
        questXp INTEGER,
        completedAt TEXT,
        completedLocation TEXT,
        scannedPhoto TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE offline_completed_quests (
        localId INTEGER PRIMARY KEY AUTOINCREMENT,
        questId TEXT NOT NULL,
        userId TEXT NOT NULL,
        completedLocation TEXT,
        completedAt TEXT,
        scannedPhoto TEXT
      )
    ''');
  }

  Future<int> insertUser(Usermodel user) async {
    final db = await database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Usermodel?> getUserById(String id) async {
    final db = await database;
    final result = await db.query('users', where: 'uid = ?', whereArgs: [id]);
    if (result.isNotEmpty) return Usermodel.fromMap(result.first);
    return null;
  }

  Future<int> updateUser(Usermodel user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'uid = ?',
      whereArgs: [user.uid],
    );
  }

  Future<int> deleteUser(String id) async {
    final db = await database;
    return await db.delete('users', where: 'uid = ?', whereArgs: [id]);
  }

  Future<List<Usermodel>> getAllUsers() async {
    final db = await database;
    final result = await db.query('users');
    return result.map((e) => Usermodel.fromMap(e)).toList();
  }

  // ---------------- Quests ----------------
  Future<int> insertQuest(Questmodel quest) async {
    final db = await database;
    return await db.insert(
      'quests',
      quest.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Questmodel> getQuestById(String id) async {
    final db = await database;
    final result = await db.query('quests', where: 'uid = ?', whereArgs: [id]);
    return Questmodel.fromMap(result.first);
  }

  Future<int> updateQuest(Questmodel quest) async {
    final db = await database;
    return await db.update(
      'quests',
      quest.toMap(),
      where: 'uid = ?',
      whereArgs: [quest.uid],
    );
  }

  Future<int> deleteQuest(String id) async {
    final db = await database;
    return await db.delete('quests', where: 'uid = ?', whereArgs: [id]);
  }

  Future<List<Questmodel>> getAllQuests() async {
    final db = await database;
    final result = await db.query('quests');
    return result.map((e) => Questmodel.fromMap(e)).toList();
  }

  Future<int> insertOfflineQuest(Questmodel quest) async {
    final db = await database;
    return await db.insert('offline_completed_quests', {
      'questId': quest.uid,
      'userId': '', // optional: pass userId if available
      'completedLocation': quest.completedLocation,
      'completedAt': quest.completedAt.toIso8601String(),
      'scannedPhoto': quest.scannedPhoto,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteOfflineQuest(String questId) async {
    final db = await database;
    return await db.delete(
      'offline_completed_quests',
      where: 'questId = ?',
      whereArgs: [questId],
    );
  }

  Future<List<Questmodel>> getAllOfflineQuests() async {
    final db = await database;
    final result = await db.query('offline_completed_quests');
    return result.map((e) {
      return Questmodel(
        uid: e['questId'] as String,
        questName: '', // optional
        questHint: '',
        questXp: 0,
        questType: Questtype.scanWord,
        completedLocation: (e['completedLocation'] as String?) ?? '',
        scannedPhoto: (e['scannedPhoto'] as String?) ?? '',
        completedAt:
            DateTime.tryParse((e['completedAt'] as String?) ?? '') ??
            DateTime.now(),
        status: Queststatus.complete,
      );
    }).toList();
  }

  Future<int> updateOfflineQuest(Questmodel quest) async {
    final db = await database;
    return await db.update(
      'offline_completed_quests',
      {
        'completedLocation': quest.completedLocation,
        'completedAt': quest.completedAt.toIso8601String(),
        'scannedPhoto': quest.scannedPhoto,
      },
      where: 'questId = ?',
      whereArgs: [quest.uid],
    );
  }

  Future<void> clearOfflineQuests() async {
    final db = await database;
    await db.delete('offline_completed_quests');
  }
}
