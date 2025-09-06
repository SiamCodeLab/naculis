import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/const/image_icon.dart';
import '../../../core/theme/theme_data.dart';

class GemsDialog extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onConfirm;

  const GemsDialog({required this.onClose, required this.onConfirm, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();

    return Dialog(
      backgroundColor: colors?.messageBackground, // Light green background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  height: 50,
                  width: 50,
                  ImageAndIconConst.diamonds,
                  color: Colors.white,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 16),
                Text(
                  'Earn Gems with Chat!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                const InfoRow(
                  icon: CupertinoIcons.chat_bubble,
                  text: 'Chat for 10+ seconds to earn 1 gem',
                ),
                const InfoRow(
                  icon: CupertinoIcons.mic,
                  text: 'Hold the mic button and speak',
                ),
                const InfoRow(
                  icon: Icons.diamond_outlined,
                  text: 'Use gems in the shop for rewards',
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: onConfirm,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text(
                      'Got it',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: onClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Info Row Widget
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black87, weight: 20, grade: 10),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
