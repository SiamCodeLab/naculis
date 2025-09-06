import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const ProfileAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPressed ?? Get.back,
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
