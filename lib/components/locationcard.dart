import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_application/constants/theme.dart';
import 'package:women_safety_application/pages/locationpage.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.screenSize,
    required this.myController,
  });

  final Size screenSize;
  final MapController myController;

  final String url =
      'https://img.freepik.com/free-vector/address-concept-illustration_114360-321.jpg?w=900&t=st=1695377666~exp=1695378266~hmac=39af6bdb0f7c162829a66335975af562643e1eb22e62ec9b88049d15bb6bed85';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.18,
      width: screenSize.width * 0.95,
      decoration: BoxDecoration(
        color: sBlack.withOpacity(0.03),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Go safe with Ease",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: sBlack,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: screenSize.width * 0.6,
              child: Text(
                "Don't worry you are on track, We will update your data accordingly to your exact location. Nice day!",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: sBlack.withOpacity(0.5),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(
                  LocationScreen(mapController: myController),
                );
              },
              child: Text(
                "Know more",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: sPink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
