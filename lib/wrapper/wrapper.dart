import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_application/authentication/loginpage.dart';
import 'package:women_safety_application/components/travelupload.dart';
import 'package:women_safety_application/constants/theme.dart';
import 'package:women_safety_application/interface/bottomnavbar.dart';
import 'package:women_safety_application/main.dart';
import 'package:women_safety_application/onboarding/onboardingpage.dart';
import 'package:women_safety_application/pages/homepage.dart';
import 'package:women_safety_application/pages/profilepage.dart';
import 'package:women_safety_application/splashpage/splashpage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Safe Haven',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: sPink),
        useMaterial3: true,
      ),
      routes: {
        "BottomNavBar": (c) => const BottomNavBar(),
        "HomePage": (c) => const HomePage(),
        "ProfilePage": (c) => const ProfilePage(),
        "TravelDataUploadPage": (c) => const TravelDataUploadPage(),
        "LogInPage": (c) => const LogInPage(),
        "onboardingPage": (c) => const OnBoardingScreen(),
        "SplashPage": (c) => const SplashPage(),
      },
      home: isviewed != 0 ? const OnBoardingScreen() : const SplashPage(),
    );
  }
}
