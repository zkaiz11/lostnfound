import 'package:flutter/material.dart';
import 'package:lostnfound/controllers/authentication_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ElevatedButton(
            onPressed: () => AuthenticationController().logout(),
            child: const Text("Log Out")),
      ],
    );
  }
}
