import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_application/constants/theme.dart';

class CallNumberRepo extends StatelessWidget {
  const CallNumberRepo({
    super.key,
    required this.txt1,
    required this.txt2,
    required this.img,
    required this.click,
  });

  final String txt1;
  final String txt2;
  final String img;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: click,
      child: Container(
        height: screenSize.height * 0.15,
        width: screenSize.width * 0.93,
        decoration: BoxDecoration(
          color: sWhite,
          border: Border.all(
            strokeAlign: BorderSide.strokeAlignCenter,
            color: sBlack.withOpacity(0.08),
            style: BorderStyle.solid,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.network(
              img,
              height: 42,
              width: 42,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  txt1,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: sPink,
                  ),
                ),
                const Gap(10),
                SizedBox(
                  width: screenSize.width * 0.6,
                  child: Text(
                    txt2,
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: sBlack.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
