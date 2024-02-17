// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:women_safety_application/constants/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Get.toNamed("BottomNavBar");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sWhite,
      body: SafeArea(
        child: Center(
          child: SvgPicture.network(
            'https://www.svgrepo.com/show/405813/hollow-red-circle.svg',
            height: 200,
            width: 200,
            color: sPink,
          ),
        ),
      ),
    );
  }
}
