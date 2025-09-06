

import 'package:flutter/material.dart';


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
    required this.buttonText,
    required this.controller,
    required this.onSubmit,
    required this.onTypeTap,
    required this.onSpeakTap,
    required this.typeIcon,
    required this.speakIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD9F0C3), // light green background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTypeTap,
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6F00),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        typeIcon,
                        const SizedBox(width: 6),
                        const Text(
                          'Type',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onSpeakTap,
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF444444),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        speakIcon,
                        const SizedBox(width: 6),
                        const Text(
                          'Speak',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Type Your Answer',
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC40),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
