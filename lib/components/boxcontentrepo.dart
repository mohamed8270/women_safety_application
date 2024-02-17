import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_application/constants/theme.dart';

class BoxContentRepo extends StatelessWidget {
  const BoxContentRepo({
    super.key,
    required this.icnlink,
    required this.txt,
    required this.click,
  });

  final String icnlink;
  final String txt;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: click,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: screenSize.height * 0.2,
        width: screenSize.width * 0.4,
        decoration: BoxDecoration(
          color: sWhite,
          border: Border.all(
            strokeAlign: BorderSide.strokeAlignCenter,
            style: BorderStyle.solid,
            color: sBlack.withOpacity(0.08),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.network(
              icnlink,
              height: 35,
              width: 35,
            ),
            const Gap(10),
            Text(
              txt,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: sPink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
