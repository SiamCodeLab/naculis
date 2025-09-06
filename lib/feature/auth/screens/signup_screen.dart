import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const/app_string.dart';
import '../../../routes/route_name.dart';
import '../controller/sign_up_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});


  final SignUpController controller = Get.find<SignUpController>();


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
                    AppStringEn.signUp.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Text(
                    AppStringEn.getStarted.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: Get.height * 0.01),

                  buildLabel(context, AppStringEn.yourname.tr),
                  buildField(
                    context,
                    AppStringEn.enterName.tr,
                    controller.usernameController,
                    keyboardType: TextInputType.text,
                  ),

                  buildLabel(context, AppStringEn.enterMail.tr),
                  buildField(
                    context,
                    AppStringEn.enterMail.tr,
                    controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  buildLabel(context, AppStringEn.phone.tr),
                  buildField(
                    context,
                    '+44 258 6649 565',
                    controller.phoneController,
                    keyboardType: TextInputType.phone,
                  ),

                  buildLabel(context, AppStringEn.password.tr),
                  buildField(
                    context,
                    '*** *** ***',
                    controller.passwordController,
                    obscure: true,
                    isHidden: controller.isPasswordHidden,
                    onToggle: controller.togglePasswordVisibility,
                  ),

                  buildLabel(context, AppStringEn.confirmPassword.tr),
                  buildField(
                    context,
                    '*** *** ***',
                    controller.confirmPasswordController,
                    obscure: true,
                    isHidden: controller.isConfirmPasswordHidden,
                    onToggle: controller.toggleConfirmPasswordVisibility,
                  ),

                  buildLabel(context, AppStringEn.refercode.tr),
                  buildField(
                    context,
                    'Enter refer code (optional)',
                    controller.referCodeController,
                    keyboardType: TextInputType.text,
                  ),

                  SizedBox(height: Get.height * 0.05),

                  Obx(
                        () => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                        controller.registerUser(); // ✅ call the function
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(Get.width, 50),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                        AppStringEn.signUp.tr,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),

                  SizedBox(height: Get.height * 0.02),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStringEn.alreadyHaveAccount.tr,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(RouteName.signin),
                        child: Text(
                          AppStringEn.signIn.tr,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(BuildContext context, String label) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label, style: Theme.of(context).textTheme.labelMedium),
        ),
        SizedBox(height: Get.height * 0.01),
      ],
    );
  }

  Widget buildField(
    BuildContext context,
    String hint,
    TextEditingController controller, {
    bool obscure = false,
    RxBool? isHidden,
    VoidCallback? onToggle,
    TextInputType keyboardType = TextInputType.text,
  }) {
    if (isHidden != null && onToggle != null) {
      return Obx(() {
        return _buildTextField(
          context,
          hint,
          controller,
          obscureText: isHidden.value,
          onToggle: onToggle,
          keyboardType: keyboardType,
        );
      });
    }

    return _buildTextField(
      context,
      hint,
      controller,
      obscureText: obscure,
      keyboardType: keyboardType,
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String hint,
    TextEditingController controller, {
    bool obscureText = false,
    VoidCallback? onToggle,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: Colors.grey),
        suffixIcon: onToggle != null
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: onToggle,
              )
            : null,
      ),
      style: Theme.of(
        context,
      ).textTheme.labelMedium?.copyWith(color: Colors.black),
    );
  }
}
