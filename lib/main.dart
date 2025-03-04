import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lostnfound/controllers/authentication_controller.dart';
import 'package:lostnfound/controllers/post_controller.dart';
import 'package:lostnfound/controllers/user_controller.dart';
import 'package:lostnfound/core/network_manager.dart';
import 'package:lostnfound/firebase_options.dart';
import 'package:lostnfound/navigation_menu.dart';
import 'package:lostnfound/repositories/post_repository.dart';
import 'package:lostnfound/repositories/user_repository.dart';
import 'package:lostnfound/screens/login_screen.dart';
import 'package:lostnfound/screens/notification_screen.dart';
import 'package:lostnfound/screens/post_screen.dart';
import 'package:lostnfound/screens/search_result_screen.dart';
import 'package:lostnfound/screens/welcome_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(GetMaterialApp(
    initialRoute: '/welcome',
    defaultTransition: Transition.native,
    translations: MyTranslations(),
    locale: const Locale('en', 'US'),
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff6b4eff)),
      useMaterial3: true,
    ),
    initialBinding: GeneralBindings(),
    getPages: [
      GetPage(
          name: '/welcome',
          page: () => WelcomeScreen(),
          customTransition: SizeTransitions()),
      GetPage(name: '/login', page: () => const LoginScreen()),
      GetPage(name: '/home', page: () => const NavigationMenu()),
      GetPage(name: '/post', page: () => const PostScreen()),
      GetPage(name: '/notification', page: () => const NotificationScreen()),
      GetPage(name: '/result', page: () => const SearchResultScreen()),
    ],
  ));
  configLoading();
}

//TODO: config and set up This library for future use
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'title': 'Hello World %s',
        },
        'en_US': {
          'title': 'Hello World from US',
        },
        'pt': {
          'title': 'Olá de Portugal',
        },
        'pt_BR': {
          'title': 'Olá do Brasil',
        },
      };
}

class SizeTransitions extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return Align(
      alignment: Alignment.center,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animation,
          curve: curve!,
        ),
        child: child,
      ),
    );
  }
}

class GeneralBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(NetWorkManager());
    Get.put(UserRepository());
    Get.put(PostRepository());
    Get.put(UserController());
    Get.put(AuthenticationController());
    Get.put(PostController());
  }
}
