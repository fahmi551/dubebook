import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  static Future<void> exportDatabase() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final dbPath = join(documentsDirectory.path, "Dubebook.db");
      
      final dbFile = File(dbPath);
      if (await dbFile.exists()) {
        await Share.shareXFiles([XFile(dbPath)], text: 'Dubebook Database Backup');
      } else {
        throw Exception("Database file not found.");
      }
    } catch (e) {
      throw Exception("Failed to export database: $e");
    }
  }
}
