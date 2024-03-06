import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lostnfound/screens/home_screen.dart';
import 'package:lostnfound/screens/profile_screen.dart';
import 'package:lostnfound/screens/search_screan.dart';
import 'package:lostnfound/screens/upload_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  String? name = FirebaseAuth.instance.currentUser!.displayName;

  String timeOfDay = '';

  final controller = Get.put(NaviagtaionController());

  @override
  void initState() {
    super.initState();
    updateTimeOfDay();
  }

  void updateTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    setState(() {
      if (hour >= 6 && hour < 12) {
        timeOfDay = 'Morning';
      } else if (hour >= 12 && hour < 17) {
        timeOfDay = 'Afternoon';
      } else {
        timeOfDay = 'Evening';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              Text(
                "Good $timeOfDay",
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Text(
                formattedDate,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.chat_bubble_2_fill),
              onPressed: () {
                updateTimeOfDay();
              },
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.bell_fill),
              onPressed: () {
                updateTimeOfDay();
              },
            ),
          ],
        ),
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
                    label: "profile"),
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
    ProfileScreen(),
  ];
}
