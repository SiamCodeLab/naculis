import 'package:get/get.dart';
import 'package:naculis/routes/route_name.dart';

import '../feature/auth/screens/email_put_screen.dart';
import '../feature/auth/screens/forget_password_otp_screen.dart';
import '../feature/auth/screens/new_password_set_screen.dart';
import '../feature/auth/screens/registration_otp_screen.dart';
import '../feature/auth/screens/signin_screen.dart';
import '../feature/auth/screens/signup_screen.dart';
import '../feature/contact_refer/contact_us.dart';
import '../feature/contact_refer/refer_a_friend.dart';
import '../feature/home/screens/game_level_screen.dart';
import '../feature/home/screens/greetings_intro_screen.dart';
import '../feature/home/screens/progress_screen.dart';
import '../feature/leader_board/screens/leader_board_screen.dart';
import '../feature/main_screen.dart';
import '../feature/notifications/notification.dart';
import '../feature/profile_set_up/screens/feeling_screen.dart';
import '../feature/profile_set_up/screens/often_lang_screen.dart';
import '../feature/profile_set_up/screens/vibe_screen.dart';
import '../feature/quest/quest.dart';
import '../feature/quest/widgets/auto_tracked_quest.dart';
import '../feature/quest/widgets/lesson_quest.dart';
import '../feature/quiz/screens/auto_tracked_quest_question.dart';
import '../feature/quiz/screens/quiz_screen.dart';
import '../feature/quiz/screens/result_screen.dart';
import '../feature/shop/screen/shop_screen1.dart';
import '../feature/shop/screen/shop_screen2.dart';
import '../feature/shop/screen/shop_screen4.dart';
import '../feature/shop/screen/shop_screen5.dart';
import '../feature/speak/screens/chat_with_bot.dart';
import '../feature/splash/screens/splash_lang_screen.dart';
import '../feature/splash/screens/splash_loading_screen.dart';
import '../feature/user_profile/screens/edit_profile_screen.dart';
import '../feature/user_profile/screens/personal_info_screen.dart';
import '../feature/user_profile/screens/profile_screen.dart';
import '../feature/withdarw/withdarw.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(
      name: RouteName.home,
      page: () => MainScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),

    // Splash screen route
    GetPage(
      name: RouteName.loadingSplash,
      page: () => SplashLoadingScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.langSplash,
      page: () => SplashLangScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),

    // Profile Setup and Settings routes
    GetPage(
      name: RouteName.oftenLang,
      page: () => OftenLangScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.vibe,
      page: () => VibeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.feeling,
      page: () => FeelingScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),

    // Authentication routes
    GetPage(
      name: RouteName.signin,
      page: () => SigninScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.signup,
      page: () => SignupScreen(), // Replace with actual SignUp screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.emailPut,
      page: () => EmailPutScreen(), // Replace with actual EmailPut screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.registerationOtp,
      page: () => RegistrationOtpScreen(),
      // Replace with actual OTPVerification screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.forgetpasswordOtp,
      page: () => ForgotPasswordOtpScreen(),
      // Replace with actual OTPVerification screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.newPasswordSet,
      page: () => NewPasswordSetScreen(),
      // Replace with actual NewPasswordSet screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.gameLevel,
      page: () => GameLevelScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.greetingsAndIntro,
      page: () => GreetingsIntroScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.gameProgress,
      page: () => ProgressScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.contactUs,
      page: () => ContactUs(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.referFriend,
      page: () => ReferFriend(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.leaderboard,
      page: () => LeaderBoardScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.notification,
      page: () => NotificationsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.quest,
      page: () => QuestScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.quiz,
      page: () => QuizScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.quizResult,
      page: () => ResultScreen(), // Replace with actual Shop1 screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.shop1,
      page: () => ShopScreen1(), // Replace with actual Shop1 screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.shop2,
      page: () => ShopScreen2(), // Replace with actual Shop2 screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    // GetPage(
    //   name: RouteName.shop3,
    //   page: () => ShopScreen3(), // Replace with actual Shop3 screen
    //   transition: Transition.rightToLeft,
    //   transitionDuration: Duration(milliseconds: 300),
    // ),
    GetPage(
      name: RouteName.shop4,
      page: () => ShopScreen4(), // Replace with actual Shop4 screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.shop5,
      page: () => ShopScreen5(), // Replace with actual Shop5 screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.chatWithBot,
      page: () => ChatWithBotScreen(), // Replace with actual ChatWithBot screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.userProfile,
      page: () => ProfileScreen(), // Replace with actual UserProfile screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.userProfileEdit,
      page: () => EditProfileScreen(),
      // Replace with actual UserProfileEdit screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.personalInfo,
      page: () => PersonalInfoScreen(), // Replace with actual Settings screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.withdraw,
      page: () => Withdarw(), // Replace with actual Withdraw screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.lessonQuest,
      page: () => LessonQuest(), // Replace with actual Withdraw screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.autoTracked,
      page: () => Auto_Tracked(), // Replace with actual Withdraw screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),  GetPage(
      name: RouteName.questQuestion,
      page: () => AutoTrackedQuestQuestion(), // Replace with actual Withdraw screen
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];
}
