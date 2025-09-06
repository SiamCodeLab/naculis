import 'package:flutter/material.dart';

import '../../../core/theme/theme_data.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final int lessons;
  final int completed;
  final double progress;
  final VoidCallback? onPress;

  const ProgressCard({
    super.key,
    required this.title,
    required this.lessons,
    required this.completed,
    required this.progress,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 5),
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: appColors?.sectionBackground ?? Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$lessons Lessons",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "$completed Completed",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 15, right: 15, top: 2),
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  value: progress,
                  color: Theme.of(context).colorScheme.primary,
                  minHeight: 13,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
