import 'package:get/get.dart';
import '../../feature/auth/controller/forgo_password_controller.dart';
import '../../feature/auth/controller/new_password_set_controller.dart';
import '../../feature/auth/controller/start_registration_controller.dart';
import '../../feature/auth/controller/sign_in_controller.dart';
import '../../feature/auth/controller/sign_up_controller.dart';
import '../../feature/contact_refer/controllers/contact_us_controller.dart';
import '../../feature/user_profile/user_profile_controller/logout%20controller.dart';
import '../../feature/withdarw/package/withdarw_controller.dart';

import '../../feature/auth/controller/forget_password_controller.dart';
import '../../feature/home/controller/home_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Auth Controllers (permanent)
    Get.put(ForgotPasswordController(), permanent: true);
    Get.put(NewPasswordSetController(), permanent: true);
    Get.put(RegistrationOtpController(), permanent: true);
    Get.put(ForgotPasswordOtpController(), permanent: true);
    Get.put(SignInController(), permanent: true);
    Get.put(SignUpController(), permanent: true);

    // Profile & other controllers (permanent)
    Get.put(WithdrawController(), permanent: true);
    Get.put(LogoutController(), permanent: true);
    Get.put(ContactUsController(), permanent: true);
    Get.put(LevelsController(), permanent: true);
  }
}
