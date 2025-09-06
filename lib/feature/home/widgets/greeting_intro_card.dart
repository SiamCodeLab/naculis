import 'package:flutter/material.dart';

import '../../../core/const/image_icon.dart';
import '../../../core/theme/theme_data.dart';
import 'current_button.dart';

class GreetingIntroCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String leading;
  final String trailing;
  final bool isCurrent;
  VoidCallback onPressed;

  GreetingIntroCard({
    super.key,
    required this.title,
    required this.onPressed,
    required this.subTitle,
    required this.leading,
    required this.trailing,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 2),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appColors?.sectionBackground ?? Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: ListTile(
            title: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              subTitle,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: Colors.black),
            ),
            leading: Image.asset(leading),
            trailing: isCurrent
                ? CurrentButton(
                    onPressed: onPressed,
                    title: 'Start',
                    icon: ImageAndIconConst.play,
                  )
                : Image.asset(trailing),
          ),
        ),
      ),
    );
  }
}
