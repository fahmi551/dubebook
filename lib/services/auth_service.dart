import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../database/database_helper.dart';

class AuthService {
  static const String _firstLaunchKey = "is_first_launch";

  static String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstLaunchKey) ?? true;
  }

  static Future<void> setFirstLaunchComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, false);
  }

  static Future<void> setupUser(String password, String q1, String q2) async {
    final user = User(
      passwordHash: hashPassword(password),
      securityQ1Answer: q1.toLowerCase().trim(),
      securityQ2Answer: q2.toLowerCase().trim(),
    );
    await DatabaseHelper.instance.insertUser(user);
    await setFirstLaunchComplete();
  }

  static Future<bool> login(String password) async {
    final user = await DatabaseHelper.instance.getUser();
    if (user == null) return false;
    
    final hash = hashPassword(password);
    return user.passwordHash == hash;
  }

  static Future<bool> resetPassword(String q1, String q2, String newPassword) async {
    final user = await DatabaseHelper.instance.getUser();
    if (user == null) return false;

    if (user.securityQ1Answer == q1.toLowerCase().trim() && 
        user.securityQ2Answer == q2.toLowerCase().trim()) {
      await DatabaseHelper.instance.updateUserPassword(user.id!, hashPassword(newPassword));
      return true;
    }
    return false;
  }
}
