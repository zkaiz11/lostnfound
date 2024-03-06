import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String name;
  final Function() login;
  final Color color;
  final Color textColor;
  final IconData icon;
  const BigButton(
      {super.key,
      required this.login,
      required this.name,
      required this.textColor,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        // onPressed: () {
        //   context.go('/home');
        // },
        icon: Icon(
          icon,
          color: Colors.white,
          size: 30.0,
        ),
        label: Text(
          name,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
        onPressed: login,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            side: BorderSide(width: 1, color: color),
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
        // child: Text(
        //   name,
        //   style: TextStyle(color: textColor, fontSize: 16),
        // ),
      ),
    );
  }
}
