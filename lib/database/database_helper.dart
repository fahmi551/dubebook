import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/customer.dart';
import '../models/app_transaction.dart';
import '../models/user.dart';

class DatabaseHelper {
  static const _databaseName = "Dubebook.db";
  static const _databaseVersion = 1;

  static const tableUser = 'users';
  static const tableCustomer = 'customers';
  static const tableTransaction = 'transactions';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUser (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        password_hash TEXT NOT NULL,
        security_q1_answer TEXT NOT NULL,
        security_q2_answer TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableCustomer (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        note TEXT,
        deadline TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableTransaction (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_id INTEGER NOT NULL,
        item_name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        total REAL NOT NULL,
        status INTEGER NOT NULL DEFAULT 0,
        date TEXT NOT NULL,
        FOREIGN KEY (customer_id) REFERENCES $tableCustomer (id) ON DELETE CASCADE
      )
    ''');
  }

  // User Operations
  Future<int> insertUser(User user) async {
    Database db = await instance.database;
    return await db.insert(tableUser, user.toMap());
  }

  Future<User?> getUser() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableUser, limit: 1);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateUserPassword(int id, String newHash) async {
    Database db = await instance.database;
    return await db.update(tableUser, {'password_hash': newHash}, where: 'id = ?', whereArgs: [id]);
  }

  // Customer Operations
  Future<int> insertCustomer(Customer customer) async {
    Database db = await instance.database;
    return await db.insert(tableCustomer, customer.toMap());
  }

  Future<List<Customer>> getCustomers() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableCustomer);
    return maps.map((c) => Customer.fromMap(c)).toList();
  }
  
  Future<int> updateCustomer(Customer customer) async {
    Database db = await instance.database;
    return await db.update(tableCustomer, customer.toMap(), where: 'id = ?', whereArgs: [customer.id]);
  }

  Future<int> deleteCustomer(int id) async {
    Database db = await instance.database;
    return await db.delete(tableCustomer, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getUnpaidCustomersWithDebt() async {
    Database db = await instance.database;
    return await db.rawQuery('''
      SELECT c.*, COALESCE(SUM(t.total), 0) as total_debt 
      FROM $tableCustomer c
      LEFT JOIN $tableTransaction t ON c.id = t.customer_id AND t.status = 0
      GROUP BY c.id
      ORDER BY total_debt DESC, c.name ASC
    ''');
  }

  // Transaction Operations
  Future<int> insertTransaction(AppTransaction transaction) async {
    Database db = await instance.database;
    return await db.insert(tableTransaction, transaction.toMap());
  }

  Future<List<AppTransaction>> getTransactionsForCustomer(int customerId, {int? status}) async {
    Database db = await instance.database;
    String where = 'customer_id = ?';
    List<dynamic> whereArgs = [customerId];
    
    if (status != null) {
      where += ' AND status = ?';
      whereArgs.add(status);
    }
    
    final List<Map<String, dynamic>> maps = await db.query(
      tableTransaction,
      where: where,
      whereArgs: whereArgs,
      orderBy: 'date DESC',
    );
    return maps.map((t) => AppTransaction.fromMap(t)).toList();
  }
  
  Future<List<AppTransaction>> getAllTransactions({int? status}) async {
    Database db = await instance.database;
    String? where = status != null ? 'status = ?' : null;
    List<dynamic>? whereArgs = status != null ? [status] : null;

    final List<Map<String, dynamic>> maps = await db.query(
      tableTransaction,
      where: where,
      whereArgs: whereArgs,
      orderBy: 'date DESC',
    );
    return maps.map((t) => AppTransaction.fromMap(t)).toList();
  }

  Future<int> markAllCustomerTransactionsAsPaid(int customerId) async {
    Database db = await instance.database;
    return await db.update(
      tableTransaction,
      {'status': 1},
      where: 'customer_id = ? AND status = 0',
      whereArgs: [customerId],
    );
  }
  
  Future<int> deleteTransaction(int id) async {
    Database db = await instance.database;
    return await db.delete(tableTransaction, where: 'id = ?', whereArgs: [id]);
  }
}
