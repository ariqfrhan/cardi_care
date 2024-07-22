import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');

    // You might want to send this token to your server
  }
}
