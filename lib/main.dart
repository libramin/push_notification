import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification/notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'homepage.dart';

final notification = FlutterLocalNotificationsPlugin();
final chaduckNotification = ChaduckNotificationService();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  chaduckNotification.initializeNotification();
  NotificationAppLaunchDetails? details = await notification.getNotificationAppLaunchDetails();
  if (details != null) {
    if (details.notificationResponse != null) {
      if (details.notificationResponse!.payload != null) {
        //
      }
    }
  }
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Notifications',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

