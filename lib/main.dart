import 'package:cardi_care/firebase_options.dart';
import 'package:cardi_care/routes.dart';
import 'package:cardi_care/services/auth_services.dart';
import 'package:cardi_care/services/firebase_api.dart';
import 'package:cardi_care/services/local_notification_services.dart';
import 'package:cardi_care/shared/theme.dart';
import 'package:cardi_care/shared/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  LocalNotificationServices.createNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  LocalNotificationServices.initialize();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Get.put(AuthServices());

  String initialRoute = await Utils.getInitialRoute();

  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    initialRoute = Routes.alarm;
    selectNotificationSubject.add('alarm');
  }

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(ProviderScope(
    child: MainApp(
      initialRoute: initialRoute,
    ),
  ));
}

class MainApp extends StatefulWidget {
  final String initialRoute;
  const MainApp({super.key, required this.initialRoute});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LocalNotificationServices.createNotification(message);
        selectNotificationSubject.add('alarm');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        selectNotificationSubject.add('alarm');
      }
    });

    selectNotificationSubject.stream.listen((String payload) async {
      if (payload == 'alarm' && Get.currentRoute != Routes.alarm) {
        Get.toNamed(Routes.alarm);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: whiteColor,
      ),
      initialRoute: widget.initialRoute,
      getPages: Routes.routes,
    );
  }
}
