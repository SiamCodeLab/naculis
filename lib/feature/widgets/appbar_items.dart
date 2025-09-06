import 'package:flutter/material.dart';

class AppbarItems extends StatelessWidget {
  final String icon;
  final int count;

  const AppbarItems({super.key, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          count.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        SizedBox(width: 6),
        Image.asset(icon),
      ],
    );
  }
}
