import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessage = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessage.requestPermission();

    final fCMToken = await _firebaseMessage.getToken();

    print('token : $fCMToken');
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }
    print(message);
  }
}
