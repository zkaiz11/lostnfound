import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lostnfound/core/loader.dart';
import 'package:lostnfound/core/network_manager.dart';
import 'package:lostnfound/models/user_model.dart';
import 'package:lostnfound/repositories/user_repository.dart';
import 'package:lostnfound/services/firebase_auth_service.dart';
import 'package:lostnfound/core/cache_manager.dart';

class AuthenticationController extends GetxController with CacheManager {
  final isLoggedIn = false.obs;

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
        final user = UserModel(
          googleUid: userCredential.user!.uid,
          name: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
          pfp: userCredential.user!.photoURL!,
          location: '',
          createdAt: Timestamp.fromDate(DateTime.now()),
          isDeleted: false,
        );
        await saveToken(userCredential.credential?.accessToken);
        if (userCredential.additionalUserInfo!.isNewUser == false) {
          await UserRepository.instance.saveUser(user);
        } else {
          Loader.closeLoading();
          Loader.success(title: "Login Successful.");
          Get.offAllNamed('/home');
        }
      }
    } catch (e) {
      Loader.error(title: "Something is wrong");
      Loader.closeLoading();
      print(e);
    } finally {
      // Loader.closeLoading();
    }
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLoggedIn.value = true;
    }
  }

  void logout() async {
    isLoggedIn.value = false;
    await FirebaseAuth.instance.signOut();
    await removeToken();
    Get.offAllNamed('/login');
  }
}
