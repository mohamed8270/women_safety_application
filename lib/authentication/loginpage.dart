import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_application/authentication/authservice.dart';
import 'package:women_safety_application/constants/categorycontainer.dart';
import 'package:women_safety_application/constants/theme.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String img =
      'https://st3.depositphotos.com/1267918/12605/v/450/depositphotos_126055094-stock-illustration-concept-of-woman-unity.jpg';

  String icnlink = 'https://www.svgrepo.com/show/475656/google-color.svg';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: sWhite,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenSize.height * 0.3,
                width: screenSize.width * 0.8,
                decoration: BoxDecoration(
                  color: sWhite,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(20),
              Text(
                "Safe Haven",
                style: GoogleFonts.poppins(
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                  color: sPink,
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Ensure safety in every aspects of your life and move forward without any fear, Let the world knows your existance",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: sBlack.withOpacity(0.3),
                  ),
                ),
              ),
              const Gap(30),
              CatergoryContainer(
                icnlink: icnlink,
                click: () {
                  AuthService().signInWithGoogle();
                },
                height: screenSize.height * 0.06,
                width: screenSize.width * 0.6,
                color: sBlack.withOpacity(0.03),
                txt: "Continue with Google",
                txtcolor: sBlack,
              )
            ],
          ),
        ),
      ),
    );
  }
}
