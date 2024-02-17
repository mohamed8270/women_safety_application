// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:women_safety_application/constants/theme.dart';
import 'package:women_safety_application/service/geocoding.dart';
import 'package:women_safety_application/service/locationcallservice.dart';

class LocationScreen extends StatefulWidget {
  final MapController mapController;
  const LocationScreen({super.key, required this.mapController});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GeocodingLocation geocodingLocation = Get.put(GeocodingLocation());

  Service service = Get.put(Service());

  @override
  void initState() {
    super.initState();
    service.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: sWhite,
        appBar: AppBar(
          backgroundColor: sPink,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Location",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: sWhite,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.toNamed("BottomNavBar");
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: sWhite,
              size: 24,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: sWhite,
          ),
          child: Column(
            children: [
              Text(
                geocodingLocation.name.value,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: sPink,
                ),
              ),
              Container(
                height: screenSize.height * 0.77,
                decoration: BoxDecoration(
                  color: sBlack.withOpacity(0.02),
                ),
                child: FlutterMap(
                  mapController: widget.mapController,
                  options: MapOptions(
                    keepAlive: true,
                    center: LatLng(service.latitude, service.longitude),
                    zoom: 10,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: "dev.fleaflet.flutter_map.example",
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(service.latitude, service.longitude),
                          child: const Icon(
                            CupertinoIcons.location_solid,
                            color: sPink,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
