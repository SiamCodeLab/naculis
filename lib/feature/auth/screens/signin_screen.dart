import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const/app_string.dart';
import '../../../routes/route_name.dart';
import '../controller/sign_in_controller.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SignInController controller = Get.put(SignInController()); // ✅ fallback safe put
  bool _obscureText = true;

  InputDecoration _inputDecoration(BuildContext context, String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  AppStringEn.signIn.tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  AppStringEn.getStarted.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  AppStringEn.tellUsAboutYourself.tr,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 30),

                // Username
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStringEn.yourname.tr,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: controller.usernameController,
                  decoration: _inputDecoration(context, AppStringEn.yourname.tr),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 20),

                // Email
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStringEn.emailAddress.tr,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress, // ✅
                  decoration:
                  _inputDecoration(context, AppStringEn.emailAddress.tr),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 20),

                // Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStringEn.password.tr,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: controller.passwordController,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.visiblePassword, // ✅
                  decoration: _inputDecoration(context, AppStringEn.enterPassword.tr).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(RouteName.emailPut),
                    child: Text(
                      AppStringEn.forgotPassword.tr,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Sign in button
                Obx(
                      () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.loginUser,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                      AppStringEn.signIn.tr,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStringEn.dontHaveAccount.tr,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(RouteName.signup),
                      child: Text(
                        AppStringEn.signUp.tr,
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
    );
  }
}
