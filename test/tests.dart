import 'dart:io';
import 'dart:async'; // Required for Timer
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'utils/theme.dart';
import 'screens/splash_setup_screen.dart';
import 'services/notification_service.dart';

// 1. Define a GlobalKey to handle logout navigation without context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await NotificationService().init();
  await initializeDateFormatting('en_US', null);
  
  runApp(const SessionManager(child: DubebookApp()));
}

// 2. The SessionManager handles the countdown and resets on interaction
class SessionManager extends StatefulWidget {
  final Widget child;
  const SessionManager({super.key, required this.child});

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  Timer? _timer;
  
  // Change this to your preferred timeout duration
  final Duration _timeoutLimit = const Duration(minutes: 5);

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(_timeoutLimit, _logoutUser);
  }

  void _logoutUser() {
    // This pushes the user back to the splash/login screen and clears the history
    // Ensure your login screen route name matches what you use here
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SplashSetupScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3. Listener detects taps, scrolls, and clicks anywhere in the app
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _startTimer(),
      child: widget.child,
    );
  }
}

class DubebookApp extends StatelessWidget {
  const DubebookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // 4. Assign the key here
      title: 'Dubebook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashSetupScreen(),
    );
  }
}