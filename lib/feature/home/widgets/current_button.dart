import 'package:flutter/material.dart';

class CurrentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String icon;

  const CurrentButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(title,style: Theme.of(context).textTheme.titleMedium,), Image.asset(icon)],
        ),
      ),
    );
  }
}
