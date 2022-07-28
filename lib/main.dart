

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:push_notification/green_page.dart';
import 'package:push_notification/services/local_notification_service.dart';

  Future<void> backGroundHandler (RemoteMessage remoteMessage)async{
    print(remoteMessage.data.toString());
    print(remoteMessage.notification!.title);
  }
  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backGroundHandler);
  runApp(App());
}
class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Push App',
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget{
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotificationService.initialize(context);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message != null){
        var resourceMessage = message.data["route"];
        Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> Green(routeMessage: resourceMessage)));
        print(resourceMessage);
      }
    });

    //ForeGround
    FirebaseMessaging.onMessage.listen((message) {
      if(message != null){
        print(message.notification?.body);
      }
      LocalNotificationService.display(message);
    });

    //When the app is in the background but opens when user taps

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      var resourceMessage = message.data["route"];
      Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> Green(routeMessage: resourceMessage)));
      print(resourceMessage);
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Some Text'),
        ),
      ),
    );
  }
}
