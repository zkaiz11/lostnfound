// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lostnfound/components/big_button.dart';
import 'package:lostnfound/components/phone_number_input_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lostnfound/controllers/authentication_controller.dart';
import 'package:lostnfound/core/loader.dart';
import 'package:lostnfound/screens/home_screen.dart';
import 'package:lostnfound/services/firebase_auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome back.",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Log in to your account",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // BigButton(
                  //     icon: Icons.facebook_outlined,
                  //     login: () => FirebaseAuthService()
                  //         .signInWithFacebook()
                  //         .then((user) =>
                  //             Loader.success(title: 'Login Successful.'))
                  //         .then((value) => Get.offAllNamed('/home'))
                  //     // .catchError((err) => {print(err)})
                  //     ,
                  //     name: "Continue with Facebook",
                  //     textColor: Colors.white,
                  //     color: const Color(0xff316FF6)),
                  BigButton(
                      icon: Icons.mail,
                      login: () => AuthenticationController().loginWithGoogle(),
                      name: "Continue with Google",
                      textColor: Colors.white,
                      color: const Color(0xffff3e30)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
