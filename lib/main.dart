// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:naculis/core/local_storage/user_info.dart';
// import 'package:naculis/routes/app_route.dart';
// import 'package:naculis/routes/route_name.dart';
//
// import 'core/localization/localization.dart';
// import 'core/theme/theme_data.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final bool isLoggedIn = await UserInfo.getIsLoggedIn();
//   print('The user satus for logdin is $isLoggedIn');
//
//   runApp(MyApp(isLoggedIn: isLoggedIn));
// }
//
// class MyApp extends StatelessWidget {
//   final bool isLoggedIn;
//
//   const MyApp({super.key, required this.isLoggedIn});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       translations: Message(),
//
//       locale: const Locale('en', 'US'),
//       fallbackLocale: const Locale('en', 'US'),
//
//       theme: lightTheme,
//       darkTheme: darkTheme,
//       themeMode: ThemeMode.light,
//
//       // initialRoute: isLoggedIn ? RouteName.home : RouteName.signin,
//       initialRoute: RouteName.loadingSplash,
//       getPages: AppRoute.pages,
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naculis/core/local_storage/user_info.dart';
import 'package:naculis/routes/app_route.dart';
import 'package:naculis/routes/route_name.dart';

import 'core/localization/localization.dart';
import 'core/theme/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
    _loadTheme().then((isDarkMode) {
      setState(() {
        // Update the theme mode based on user preference
        if (isDarkMode) {
          Get.changeThemeMode(ThemeMode.dark);
        } else {
          Get.changeThemeMode(ThemeMode.light);
        }
      });
    });
  }

  Future<void> _loadLocale() async {
    final locale = await UserInfo.getLocale();
    setState(() {
      _locale = locale ?? const Locale('en', 'US');
    });
  }

  Future<bool> _loadTheme() async {
    bool isDarkMode = await UserInfo.getIsDarkMode();
    return isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return const SizedBox.shrink();
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Message(),
      locale: _locale,
      fallbackLocale: const Locale('en', 'US'),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: RouteName.loadingSplash,
      getPages: AppRoute.pages,
    );
  }
}
