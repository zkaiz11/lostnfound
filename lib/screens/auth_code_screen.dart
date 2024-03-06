import 'package:flutter/material.dart';

class AuthCodeScreen extends StatefulWidget {
  const AuthCodeScreen({super.key});
  @override
  State<AuthCodeScreen> createState() => _AuthCodeScreenState();
}

class _AuthCodeScreenState extends State<AuthCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(children: [
          Text(
            "Enter authentication code",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Enter the 4-digit that we have sent via +85596 930 0901"),
        ]),
      ),
    );
  }
}
