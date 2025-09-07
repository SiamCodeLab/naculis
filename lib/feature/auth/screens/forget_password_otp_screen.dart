import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_string.dart';
import '../../../routes/route_name.dart';
import '../controller/forget_password_controller.dart';


class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  State<ForgotPasswordOtpScreen> createState() => _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final ForgotPasswordOtpController controller = Get.put(ForgotPasswordOtpController());

  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    final emailArg = Get.arguments?['email'] ?? '';
    controller.setEmail(emailArg);

    _focusNodes = List.generate(6, (_) => FocusNode());
    _controllers = List.generate(6, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var node in _focusNodes) node.dispose();
    for (var c in _controllers) c.dispose();
    super.dispose();
  }

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
                  Text(AppStringEn.OTPVerification.tr, style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: Get.height * 0.003),
                  Text(AppStringEn.selectYouLikeToProceed.tr, style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(height: Get.height * 0.05),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AppStringEn.enterCode.tr, style: Theme.of(context).textTheme.labelMedium),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 50,
                        height: 55,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) _focusNodes[index + 1].requestFocus();
                            else if (value.isEmpty && index > 0) _focusNodes[index - 1].requestFocus();
                          },
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: Get.height * 0.05),
                  Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                      final otp = _controllers.map((c) => c.text).join();
                      controller.verifyOtp(otp);
                    },
                    style: ElevatedButton.styleFrom(minimumSize: Size(Get.width, 50)),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(AppStringEn.next.tr, style: Theme.of(context).textTheme.labelLarge),
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
