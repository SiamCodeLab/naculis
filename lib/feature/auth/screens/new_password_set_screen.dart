import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const/app_string.dart';
import '../../../routes/route_name.dart';
import '../controller/new_password_set_controller.dart';

class NewPasswordSetScreen extends StatelessWidget {
  NewPasswordSetScreen({Key? key}) : super(key: key);

  final NewPasswordSetController controller = Get.put(NewPasswordSetController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    AppStringEn.newPassword.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: Get.height * 0.003),
                  Text(
                    AppStringEn.selectYouLikeToProceed.tr,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: Get.height * 0.05),

                  // New Password Label & TextField
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStringEn.newPassword.tr,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  TextField(
                    controller: controller.newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '*** *** ***',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black),
                  ),

                  SizedBox(height: Get.height * 0.03),

                  // Confirm Password Label & TextField
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStringEn.confirmPassword.tr,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  TextField(
                    controller: controller.confirmNewPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '*** *** ***',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black),
                  ),

                  SizedBox(height: Get.height * 0.05),

                  Obx(() {
                    return ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                        controller.setNewPassword();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(Get.width, 50),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                        AppStringEn.save.tr,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
