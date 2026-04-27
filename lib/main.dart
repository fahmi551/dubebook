import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'utils/theme.dart';
import 'screens/splash_setup_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await NotificationService().init();
  await initializeDateFormatting('en_US', null);
  
  runApp(const DubebookApp());
}

class DubebookApp extends StatelessWidget {
  const DubebookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dubebook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashSetupScreen(),
    );
  }
}
