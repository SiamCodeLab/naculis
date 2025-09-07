import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const/app_string.dart';
import '../controller/forgo_password_controller.dart';


class EmailPutScreen extends StatelessWidget {
   EmailPutScreen({super.key});

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

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
                    AppStringEn.forgotPassword.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: Get.height * 0.003),
                  Text(
                    AppStringEn.selectYouLikeToProceed.tr,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: Get.height * 0.05),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStringEn.emailAddress.tr,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      hintText: AppStringEn.enterMail.tr,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: Colors.black),

                  ),
                  SizedBox(height: Get.height * 0.05),
                  Obx(() => ElevatedButton(
                    onPressed: () {
                      controller.isLoading.value
                          ? null
                          : controller.sendForgotPasswordRequest;
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width, 50),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                      AppStringEn.sendCode.tr,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
