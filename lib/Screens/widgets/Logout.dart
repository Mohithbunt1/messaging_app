import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "LogOut",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Icon(
          Icons.exit_to_app_outlined,
          color: Color(0x66775577),
        ),
      ],
    );
  }
}
