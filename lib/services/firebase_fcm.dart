import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:lostnfound/models/user_model.dart';
import 'package:lostnfound/repositories/user_repository.dart';
import 'package:lostnfound/screens/notification_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage msg) async {
  print('title: ${msg.notification?.title}');
  print('body: ${msg.notification?.body}');
  print('payload: ${msg.data}');
}

class FirebaseFCM {
  final _firebaseMessaging = FirebaseMessaging.instance;
  String? fcmToken;


  void handleMessage(RemoteMessage? message) {
    Get.toNamed('notification', arguments: message);
  }

  Future<void> initPushNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(provisional: true);
    fcmToken = await _firebaseMessaging.getAPNSToken();

    fcmToken ??= await _firebaseMessaging.getToken();
    // String? email = FirebaseAuth.instance.currentUser!.email;

    // UserModel user = await UserRepository.instance.getUserByEmail(email!);
    // Map<String, dynamic> updatedData = user.toJson();
    // updatedData["fcm_token"] = fcmToken;
    // await UserRepository.instance.updateUserDataByEmail(email, updatedData);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initNotification();
  }
}
