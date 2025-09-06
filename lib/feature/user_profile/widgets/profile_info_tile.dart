
import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final double? topRight;
  final double? topLeft;
  final double? bottomLeft;
  final double? bottomRight;

  const ProfileInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.topRight,
    this.topLeft,
    this.bottomLeft,
    this.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? 0),
          topRight: Radius.circular(topRight ?? 0),
          bottomLeft: Radius.circular(bottomLeft ?? 0),
          bottomRight: Radius.circular(bottomRight ?? 0),
        ),
      ),
      child: Text(
        '$title : $value',
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: Colors.black),
      ),
    );
  }
}