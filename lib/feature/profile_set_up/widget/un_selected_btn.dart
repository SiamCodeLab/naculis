
import 'package:flutter/material.dart';

class UnSelectedBtn extends StatelessWidget {
  String? icon;
  String? title;
  VoidCallback? onTap;
  UnSelectedBtn({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(.8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 25,
              child: Image.asset(
                icon!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title!,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}