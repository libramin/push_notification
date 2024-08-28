

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text('push notification'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(onPressed: () async {
                await _showNotification();
              }, child: const Text('푸시알람')),
              TextButton(onPressed: () async {
               await showImgNotification();
              }, child: const Text('이미지 알림'))
            ],
          ),
        )
    );
  }

  Future<void> _showNotification() async {
    //showId : 고유한 ID 값 사용
    //channelName : 앱 설정 > 알림에 보여지는 네임
    //channelDescription : 해당 채널에 대한 설명
    //importance, priority : 중요도를 설정하는 부분으로 아래와 같이 중요도를 높혀서 전송을 해야지만 Foreground에서 노출이 가능함.
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await notification.show(
        1, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  Future<void> timeScheduleNotification()async{
    tz.TZDateTime schedule = tz.TZDateTime.now(tz.local).add(const Duration(minutes: 5));//현시간에서 5분뒤 알람
    tz.TZDateTime schedule2 = tz.TZDateTime.now(tz.local); //매일 동일한 시간에 알람

    // await notification.zonedSchedule(
    //   1,
    //   'title',
    //   'body',
    //   schedule,
    //   // details,
    //   uiLocalNotificationDateInterpretation:
    //   UILocalNotificationDateInterpretation.absoluteTime,
    //   matchDateTimeComponents: null,
    // );
  }

  Future<void> showImgNotification() async {
    //showId : 고유한 ID 값 사용
    //channelName : 앱 설정 > 알림에 보여지는 네임
    //channelDescription : 해당 채널에 대한 설명
    //importance, priority : 중요도를 설정하는 부분으로 아래와 같이 중요도를 높혀서 전송을 해야지만 Foreground에서 노출이 가능함.
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    //asset 이미지 사용
    // final String asset = "your_asset_image";
    // final ByteData byteData = await rootBundle.load(asset);
    // final Directory directory = await getTemporaryDirectory();
    // final File file = File('${directory.path}/${asset.split('/').last}');
    // await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    // print(file.path);
    // String filePath = file.path;

    //networkImg 사용
      String url = 'https://picsum.photos/100';
      final http.Response response = await http.get(Uri.parse(url));
      final Directory directory = await getTemporaryDirectory();
      final String name = "${directory.path}/${url.split('/').last}.png";
      final File file = File(name);
      await file.writeAsBytes(response.bodyBytes);
      String filePath = file.path;

     NotificationDetails notificationDetails = NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        badgeNumber: 1,
        attachments: [
          DarwinNotificationAttachment(filePath)
        ],
      ),
      android: AndroidNotificationDetails(
        'send.type.channelId',
        'send.type.channelName',
        channelDescription: 'send.type.channelDescription',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: BigPictureStyleInformation(
          FilePathAndroidBitmap(filePath),
        ),
      ),
    );
    await notification.show(
        13, '이미지알림', '이미지알림입니다', notificationDetails,
        payload: 'item x');
  }


}