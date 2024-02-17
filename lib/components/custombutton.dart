// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.boxcolor,
    required this.txt,
    required this.txtcolor,
    required this.click,
  });

  final double height;
  final double width;
  final Color boxcolor;
  final String txt;
  final Color txtcolor;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: boxcolor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          txt,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: txtcolor,
          ),
        ),
      ),
    );
  }
}
