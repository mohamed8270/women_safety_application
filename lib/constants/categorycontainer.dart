// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CatergoryContainer extends StatelessWidget {
  const CatergoryContainer({
    super.key,
    required this.icnlink,
    required this.click,
    required this.height,
    required this.width,
    required this.color,
    required this.txt,
    required this.txtcolor,
  });

  final String icnlink;
  final VoidCallback click;
  final double height;
  final double width;
  final Color color;
  final String txt;
  final Color txtcolor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.network(
                icnlink,
                height: 18,
                width: 18,
              ),
              Text(
                txt,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: txtcolor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
