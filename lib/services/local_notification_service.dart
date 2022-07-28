import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context){
    final InitializationSettings initializationSettings =
    InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? route)async{
      if(route != null){
        Navigator.of(context).pushNamed(route);
      }

    });

  }

  static void display(RemoteMessage remoteMessage)async{
    try{
      final id = (DateTime.now().millisecondsSinceEpoch / 1000).toInt() ;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "easyapproach",
            "easyapproach channel",

            importance:  Importance.max,
            priority: Priority.high,
          )
      );

      await _notificationsPlugin.show(
        id,
        remoteMessage.notification!.title,
        remoteMessage.notification!.body,
        notificationDetails,
        payload: remoteMessage.data["route"]
      );
    }on Exception catch(e){
      print(e);
    }
  }
}