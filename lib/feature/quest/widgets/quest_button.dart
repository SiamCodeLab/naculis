import 'package:flutter/material.dart';

class QuestButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String iconAsset;

  const QuestButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 109,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconAsset,
              height: 30, // Scaled down to fit nicely in 109 height
              width: 30,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Quest card

class QuestCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconAsset;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const QuestCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconAsset,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 129,

        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconAsset, width: 30, height: 30, fit: BoxFit.contain),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

//QuestProgressCard Auto_Tracked

class QuestProgressCard extends StatelessWidget {
  final String category;
  final String title;
  final String subtitle;
  final double currentProgress;
  final double totalProgress;
  final int rewardXP;
  final Widget progressbar;

  const QuestProgressCard({
    super.key,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.currentProgress,
    required this.totalProgress,
    required this.rewardXP,
    required this.progressbar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFAEDDA5), // light green
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Get Reward $rewardXP XP",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 4),

          /// Subtitle
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),

          const SizedBox(height: 12),

          /// Progress Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Progress $totalProgress",
                style: const TextStyle(fontSize: 13),
              ),
              Text("$currentProgress %", style: const TextStyle(fontSize: 13)),
            ],
          ),

          const SizedBox(height: 6),

          /// Progress Bar
          progressbar,
        ],
      ),
    );
  }
}

//Lesson Starts Card

class LessonStatsCard extends StatelessWidget {
  final int? level;
  final int totalLesson;
  final int totalXP;
  final int? completedLesson;
  final int? earnedXP;
  final bool showLevel;

  const LessonStatsCard({
    super.key,
    this.level,
    required this.totalLesson,
    required this.totalXP,
    this.completedLesson,
    this.earnedXP,
    this.showLevel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFAEDDA5), // light green
        borderRadius: BorderRadius.circular(12),
        border: showLevel ? Border.all(color: Colors.blueAccent) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLevel)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildRow(
                icon: Icons.star,
                iconColor: Colors.orange,
                label: "Level",
                value: level?.toString() ?? "1",
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildRow(
              icon: Icons.layers,
              iconColor: Colors.grey,
              label: showLevel ? "Total Lesson :" : "Complete Lesson :",
              value: (showLevel ? totalLesson : completedLesson ?? 6)
                  .toString()
                  .padLeft(2, '0'),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildRow(
              icon: Icons.flash_on,
              iconColor: Colors.cyan,
              label: showLevel ? "Total XP :" : "Earned XP :",
              value: (showLevel ? totalXP : earnedXP ?? 45).toString(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
