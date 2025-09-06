import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onPress;

  const LanguageCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subTitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
