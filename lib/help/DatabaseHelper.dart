import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  // Constructor
  DatabaseHelper._internal();

  // ฟังก์ชันสำหรับการสร้างฐานข้อมูลและเปิดการเชื่อมต่อ
  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            isCompleted INTEGER NOT NULL DEFAULT 0,
            category TEXT,
            priority INTEGER,
            date TEXT  -- เพิ่มคอลัมน์สำหรับวันที่
          )
        ''');
      },
    );
  }

  // ฟังก์ชันดึงงานทั้งหมดในช่วงวันที่ที่ระบุ
  Future<List<Map<String, dynamic>>> getTasksInDateRange(DateTime startDate, DateTime endDate) async {
    final dbClient = await db;
    String start = DateFormat('yyyy-MM-dd').format(startDate);
    String end = DateFormat('yyyy-MM-dd').format(endDate);

    List<Map<String, dynamic>> result = await dbClient.query(
      'tasks',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [start, end],
    );
    return result;
  }

  // ฟังก์ชันดึงงานทั้งหมด
  Future<List<Map<String, dynamic>>> getTasks() async {
    final dbClient = await db;
    final result = await dbClient.query('tasks');
    return result;
  }

  // ฟังก์ชันเพิ่มงานใหม่
  Future<int> insertTask(Map<String, dynamic> task) async {
    final dbClient = await db;
    return await dbClient.insert('tasks', task);
  }

  // ฟังก์ชันอัปเดตงาน
  Future<int> updateTask(Map<String, dynamic> task) async {
    final dbClient = await db;
    return await dbClient.update(
      'tasks',
      task,
      where: 'id = ?',
      whereArgs: [task['id']],
    );
  }

  // ฟังก์ชันลบงาน
  Future<int> deleteTask(int id) async {
    final dbClient = await db;
    return await dbClient.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
