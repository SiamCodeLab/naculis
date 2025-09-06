import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/const/app_string.dart';
import '../../core/const/nav_ids.dart';
import '../widgets/profile_app_bar.dart';
import 'controllers/contact_us_controller.dart';

class ContactUs extends GetView<ContactUsController> {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ProfileAppBar(
          onBackPressed: () => Get.back(id: NavIds.profile),
          title: AppStringEn.contactUs.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Illustration Image
            Image.asset('assets/images/contact.png', height: 180),

            // Welcome text
            Text(
              AppStringEn.contactSubtitle.tr,
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).colorScheme.tertiaryFixed,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),

            // Title Field
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStringEn.titleLabel.tr,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.tertiaryFixed,
                ),
              ),
            ),
            const SizedBox(height: 6),
            customInputField(
                controller.titleController,
                AppStringEn.titleHint.tr, context),

            const SizedBox(height: 16),

            // Message Field
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStringEn.messageLabel.tr,
                style: labelStyle.copyWith(
                  color: Theme.of(context).colorScheme.tertiaryFixed,
                ),
              ),
            ),
            const SizedBox(height: 6),
            customInputField(
              controller.messageController,
                AppStringEn.messageHint.tr, context, maxLines: 5),

            const SizedBox(height: 30),

            // Send Button
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                   controller.sendContactUs();
                  },
                  child: Text(
                    AppStringEn.send.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Reusable input field
  Widget customInputField(
      TextEditingController controller,
    String hint,
    BuildContext context, {
    int maxLines = 1,
  }) {
    return TextField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey),
      filled: true, // 👈 Required to make background + border visible
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:BorderSide(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),

    );
  }


  // Label style
  TextStyle get labelStyle => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Color(0xFF333333),
  );
}
