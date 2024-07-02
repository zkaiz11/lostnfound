import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lostnfound/controllers/authentication_controller.dart';
import 'package:lostnfound/screens/account_detial_screen.dart';
import 'package:lostnfound/screens/your_claims_screen.dart';
import 'package:lostnfound/screens/your_posts_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              "Account",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(() => const AccountDetial());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(CupertinoIcons.person_crop_square),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Change Account Information",
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
                  Icon(CupertinoIcons.chevron_forward),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(CupertinoIcons.globe),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Change Language",
                    style: TextStyle(fontSize: 16),
                  ),
                )),
                Icon(CupertinoIcons.chevron_forward),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const YourPostsScreen());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(CupertinoIcons.list_dash),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Your Posts",
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
                  Icon(CupertinoIcons.chevron_forward),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const YourClaimsScreen());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(CupertinoIcons.arrow_turn_down_right),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Your Claim Requests",
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
                  Icon(CupertinoIcons.chevron_forward),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              "More",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(CupertinoIcons.star),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Rate and Review",
                    style: TextStyle(fontSize: 16),
                  ),
                )),
                Icon(CupertinoIcons.chevron_forward),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(CupertinoIcons.question_square),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Help",
                    style: TextStyle(fontSize: 16),
                  ),
                )),
                Icon(CupertinoIcons.chevron_forward),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => AuthenticationController().logout(),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(CupertinoIcons.chevron_right_square),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
                  Icon(CupertinoIcons.chevron_forward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
