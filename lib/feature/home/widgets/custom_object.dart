import 'package:flutter/material.dart';

class CustomObject extends StatelessWidget {
  final String image;
  final String title;

  const CustomObject({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image, height: 60, width: 59),
        Stack(
          children: [
            // Border (Stroke)
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6   // Border thickness
                  ..color = Colors.black, // Border color
              ),
              textAlign: TextAlign.center,
            ),

            // Fill text
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Inside color
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )


      ],
    );
  }
}
