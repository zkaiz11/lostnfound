import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lostnfound/controllers/authentication_controller.dart';
import 'package:lostnfound/navigation_menu.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final AuthenticationController _authcontroller =
      Get.put(AuthenticationController());

  Future<void> initializeSettings() async {
    _authcontroller.checkLoginStatus();

    //Simulate other services for 3 seconds
    // await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return welcomeView(context);
        } else {
          if (snapshot.hasError) {
            return errorView(snapshot);
          } else {
            return const OnBoard();
          }
        }
      },
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold welcomeView(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Lost",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text("nFound",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SvgPicture.asset(
                'assets/svg/welcome.svg',
                semanticsLabel: "welcome",
                width: 200,
                height: 200,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text("Post and Find your lost belonging",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  side: BorderSide(
                      width: 1, color: Theme.of(context).colorScheme.primary),
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
              child: const Text(
                "Get Started",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationController authController = Get.find();

    return Obx(() {
      return authController.isLoggedIn.value
          ? const NavigationMenu()
          : WelcomeScreen().welcomeView(context);
    });
  }
}
