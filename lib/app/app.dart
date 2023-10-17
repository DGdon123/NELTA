import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/dashboard.dart';
import 'package:nelta/features/auth/presentation/controllers/token/token_request_controller.dart';
import 'package:nelta/features/auth/presentation/login/login_screen.dart';

class NeltaApp extends ConsumerWidget {
  const NeltaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: ref.watch(tokenControllerProvider).when(
            loggedIn: () => const Dashboard(),
            loggedOut: () => const LoginScreen(),
            loading: CircularProgressIndicator.adaptive));
  }

  ThemeData appTheme() {
    return ThemeData(
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith(
              (states) => AppColorResources.appSecondaryColor),
        ),
        useMaterial3: true,
        fontFamily: "Gil",
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white, size: 20),
            backgroundColor: AppColorResources.appPrimaryColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            titleTextStyle: TextStyle(
              fontFamily: "PS",
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.white,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                fixedSize: const Size(350, 0),
                foregroundColor: Colors.white,
                elevation: 0,
                backgroundColor: AppColorResources.appSecondaryColor)));
  }
}
