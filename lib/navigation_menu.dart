import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lostnfound/screens/home_screen.dart';
import 'package:lostnfound/screens/menu_screen.dart';
import 'package:lostnfound/screens/search_screan.dart';
import 'package:lostnfound/screens/upload_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  String? name = FirebaseAuth.instance.currentUser!.displayName;

  final controller = Get.put(NaviagtaionController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => controller.screens[controller.selectedIndex.value]),
        bottomNavigationBar: Obx(() => NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: const <Widget>[
                NavigationDestination(
                    icon: Icon(CupertinoIcons.home), label: "home"),
                NavigationDestination(
                    icon: Icon(CupertinoIcons.search), label: "search"),
                NavigationDestination(
                    icon: Icon(CupertinoIcons.add), label: "post"),
                NavigationDestination(
                    icon: Icon(CupertinoIcons.profile_circled),
                    label: "Settings"),
              ],
            )));
  }
}

class NaviagtaionController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    UploadScreen(),
    MenuScreen(),
  ];
}
