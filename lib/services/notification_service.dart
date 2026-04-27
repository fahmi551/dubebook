import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin.initialize(settings: initializationSettings);
    
    // Request permissions for Android 13+
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestNotificationsPermission();
    }
  }

  Future<void> scheduleDeadlineNotification(int id, String customerName, DateTime deadline) async {
    // 1. Notification for the Day of Deadline (Arrived)
    DateTime scheduleDayOf = DateTime(deadline.year, deadline.month, deadline.day, 9, 0);
    if (scheduleDayOf.isBefore(DateTime.now())) {
      scheduleDayOf = DateTime.now().add(const Duration(minutes: 5));
    }

    await _schedule(
      notificationId: id * 2,
      title: 'Payment Deadline: $customerName',
      body: '$customerName hasn\'t paid and the deadline is arrived.',
      scheduledTime: scheduleDayOf,
    );

    // 2. Reminder Notification 1 Day Before
    DateTime scheduleBefore = scheduleDayOf.subtract(const Duration(days: 1));
    if (scheduleBefore.isAfter(DateTime.now())) {
      await _schedule(
        notificationId: id * 2 + 1,
        title: 'Upcoming Deadline: $customerName',
        body: '$customerName\'s payment deadline is tomorrow.',
        scheduledTime: scheduleBefore,
      );
    }
  }

  Future<void> _schedule({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    // Linux does not support zonedSchedule in flutter_local_notifications yet.
    // We provide a fallback for Linux users to at least see immediate notifications or logs.
    if (Platform.isLinux) {
      await flutterLocalNotificationsPlugin.show(
        id: notificationId,
        title: title,
        body: body,
        notificationDetails: const NotificationDetails(
          linux: LinuxNotificationDetails(),
        ),
      );
      return;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: notificationId,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'deadline_channel',
          'Deadlines',
          channelDescription: 'Notifications for customer payment deadlines',
          importance: Importance.max,
          priority: Priority.high,
          color: ui.Color(0xFF2E32FF),
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id: id * 2);
    await flutterLocalNotificationsPlugin.cancel(id: id * 2 + 1);
  }
}
