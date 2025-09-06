import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naculis/core/local_storage/user_info.dart';
import 'package:naculis/routes/app_route.dart';
import 'package:naculis/routes/route_name.dart';

import 'core/localization/localization.dart';
import 'core/theme/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool isLoggedIn = await UserInfo.getIsLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Message(),

      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),

      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,

      initialRoute: isLoggedIn ? RouteName.home : RouteName.signin,
      getPages: AppRoute.pages,
    );
  }
}
