class ApiEndpoints {
  static const String baseUrl = 'http://103.186.20.115:10002/api';

// Authentication Endpoints
  static const String signup = '$baseUrl/start-registration/';
  static const String login = '$baseUrl/login/';
  static const String verifyRegistration = '$baseUrl/verify-registration-otp/';
  static const String forgetPasswordOtp = '$baseUrl/verify-otp/';
  static const String resetPassword = '$baseUrl/reset-password/';
  static const String forgotPassword = '$baseUrl/send-otp/';

  // User Profile Endpoints
  static const String userProfileInfo = '$baseUrl/profile/';
  static const String userProfileInfoUpdate = '$baseUrl/profile/update/';

  //walet activity
  static const String walletActivity = '$baseUrl/wallet/activity/';

  // Leaderboard Endpoints
  static const String gems = '$baseUrl/leaderboard/combined/gems/';
  static const String xp = '$baseUrl/leaderboard/combined/xp/';
  static const String dailyStreak = '$baseUrl/leaderboard/combined/daily_streak/';
  static const String perfectLesson = '$baseUrl/leaderboard/combined/perfect_lessons/';

  //Logout Endpoints
  static const String logout = '$baseUrl/logout/';


  // Shop Endpoints
  static const String getheart = '$baseUrl/shop/hearts/status/';
  static const String refilloneHeart = '$baseUrl/shop/hearts/refill-one/';
  static const String refillAlleHeart = '$baseUrl/shop/hearts/refill-full/';
  static const String exchangeGems = '$baseUrl/shop/gem/withdraw-amount/';
  static const String notification = '$baseUrl/notifications/';
  static const String payoutRequest = '$baseUrl/shop/payout/request/';
  static const String deleteNotification = '$baseUrl/notifications/delete-notification/';
  static const String contactUs = '$baseUrl/support/contact/';

  // Subscription Endpoints

  static const String startSubscription = '$baseUrl/shop/subscription/start-subscription/';

  // Slang Categories Endpoints
  static const String slangCategories = '$baseUrl/core/slang-categories/';
  static const String moodCategories = '$baseUrl/core/mood-categories/';
  static const String onboardingProcess = '$baseUrl/core/onboarding/';

  //get levels
  static const String getLevels = '$baseUrl/core/levels/';
  static const String   levelDetails = '$baseUrl/core/levels-details/';
  static const String   chatbot = '$baseUrl/core/chatbot/';
  //lesson quest
  static const String   lessonquest = '$baseUrl/core/lesson-quest/';
  static const String   autoTracked = '$baseUrl/tasks/user-tasks/';
  static const String   personality = '$baseUrl/core/personality/';
  static const String   ansSubmit = '$baseUrl/core/lessons/submit/';











}