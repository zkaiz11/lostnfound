import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:lostnfound/controllers/user_controller.dart';
import 'package:lostnfound/core/loader.dart';
import 'package:lostnfound/core/network_manager.dart';
import 'package:lostnfound/models/user_model.dart';
import 'package:lostnfound/repositories/user_repository.dart';
import 'package:lostnfound/services/firebase_auth_service.dart';
import 'package:lostnfound/core/cache_manager.dart';

class AuthenticationController extends GetxController with CacheManager {
  final isLoggedIn = false.obs;
  final _firebaseMessaging = FirebaseMessaging.instance;
  String? fcmToken;
  //Google Login
  Future<void> loginWithGoogle() async {
    try {
      // Check connection status
      Loader.openLoading();
      final isConnected = await NetWorkManager.instance.isConnected();
      if (!isConnected) {
        Loader.closeLoading();
        Loader.error(title: "No internet connection");
        return;
      } else {
        Loader.closeLoading();
      }
      // Start auth flow
      Loader.openLoading();
      UserCredential userCredential =
          await FirebaseAuthService().signInWithGoogle();
      if (FirebaseAuth.instance.currentUser != null) {
        await saveToken(userCredential.credential?.accessToken);
        await _firebaseMessaging.requestPermission(provisional: true);
        fcmToken = await _firebaseMessaging.getAPNSToken();

        fcmToken ??= await _firebaseMessaging.getToken();

        final user = UserModel(
          googleUid: userCredential.user!.uid,
          name: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
          pfp: userCredential.user!.photoURL!,
          location: '',
          createdAt: Timestamp.fromDate(DateTime.now()),
          isDeleted: false,
          fcmToken: fcmToken,
        );
        // new user, create a db record
        if (userCredential.additionalUserInfo!.isNewUser == true) {
          await UserRepository.instance.saveUser(user);
        }
        await UserController.instance.setUser(user);
        Loader.closeLoading();
        Loader.success(title: "Login Successful.");
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Loader.error(title: "Something is wrong");
      Loader.closeLoading();
      print(e);
    } finally {
      // Loader.closeLoading();
    }
  }

  void checkLoginStatus() async {
    if (FirebaseAuth.instance.currentUser != null) {
      isLoggedIn.value = true;
      UserModel user = await UserRepository.instance
          .getUserById(FirebaseAuth.instance.currentUser!.uid);
      await UserController.instance.setUser(user);
    }
  }

  void logout() async {
    isLoggedIn.value = false;
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }
}
