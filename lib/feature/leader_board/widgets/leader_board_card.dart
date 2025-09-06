import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/image_icon.dart';

class LeaderboardCard extends StatelessWidget {
  final int rank;
  final String avatarUrl; // Pass a Network or Asset image path
  final String name;
  final String score;
  final Color backgroundColor;
  final Color iconColor;

  const LeaderboardCard({
    super.key,
    required this.rank,
    required this.avatarUrl,
    required this.name,
    required this.score,
    this.backgroundColor = const Color(0xFFFFE0B2), // light orange
    this.iconColor = const Color(0xFFFF9800), // orange
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange,width: 2)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            rank.toString().padLeft(2, '0').tr,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(
              avatarUrl,
            ), // Use NetworkImage(avatarUrl) if needed
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
          Image.asset(
            ImageAndIconConst.diamonds,
            // Replace with your custom diamond icon if you have one
            color: iconColor,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 8),
          Text(
            score,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
