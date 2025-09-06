import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 390,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFF2ECC40),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String question;
  final String buttonText;
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final VoidCallback onTypeTap;
  final VoidCallback onSpeakTap;
  final Widget typeIcon;
  final Widget speakIcon;

  const QuestionCard({
    super.key,
    required this.question,
    required this.controller,
    required this.onSubmit,
    required this.onTypeTap,
    required this.onSpeakTap,
    required this.typeIcon,
    required this.speakIcon,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            question,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          CustomTypeSpeakBar(
            onTypeTap: onTypeTap,
            onSpeakTap: onSpeakTap,
            typeIcon: typeIcon,
            speakIcon: speakIcon,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Type Your Answer',
              hintStyle: const TextStyle(fontSize: 15),
              filled: true,
              fillColor: const Color(0xFFE7DA92),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSubmit,
              child: Text(
                buttonText,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTypeSpeakBar extends StatelessWidget {
  final VoidCallback onTypeTap;
  final VoidCallback onSpeakTap;
  final Widget typeIcon;
  final Widget speakIcon;

  const CustomTypeSpeakBar({
    super.key,
    required this.onTypeTap,
    required this.onSpeakTap,
    required this.typeIcon,
    required this.speakIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Type Button
          GestureDetector(
            onTap: onTypeTap,
            child: Container(
              width: 110,
              height: 84,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  typeIcon,
                  const SizedBox(width: 10),
                  const Text(
                    'Type',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          // Speak Button
          GestureDetector(
            onTap: onSpeakTap,
            child: Container(
              width: 120,
              height: 84,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF42515E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  speakIcon,
                  const SizedBox(width: 10),
                  const Text(
                    'Speak',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
