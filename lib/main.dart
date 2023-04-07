import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/screens/splash.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final service = FlutterBackgroundService();
  service.invoke("stopService");
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print(fcmToken);
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (kDebugMode) {
    print('User granted permission: ${settings.authorizationStatus}');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (kDebugMode) {
      print('Got a foreground message!');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
    }
    if (message.notification != null) {
      final AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        message.messageId.toString(),
        message.senderId.toString(),
        channelDescription: message.data.toString(),
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      );
      final NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        platformChannelSpecifics,
        payload: message.data.toString(),
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle message when app is in foreground and opened
  });

  await FirebaseMessaging.instance.subscribeToTopic("topic");

  Map<String, dynamic> payload = {
    'notification': {
      'title': 'New message',
      'body': 'You have a new message',
    },
    'priority': 'high',
    'data': {"message": "Hey, Hii there"},
    'topic': 'topic',
  };
  sendNotification(payload);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      builder: EasyLoading.init(),
    );
  }
}

// #TODO Gitesh why was this added please comment
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> sendNotification(var payload) async {
  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=AAAACF9gVpE:'
        'APA91bFz4djAMiUE8rJcQyX80pIcbkAX8cSebochz2dG9l1maKEDlGXMQZx_BFaATx_iUhVXJHrnp_ATzUj0nroK92HsnDl3XndoDWsTtpQzL4vbhkyae'
        '-KIKLQjb1UkPXZwNt8ojxaD'
  };
  final response = await http.post(
    url,
    headers: headers,
    body: json.encode(payload),
  );
  if (kDebugMode) {
    print(response.body);
  }
}
