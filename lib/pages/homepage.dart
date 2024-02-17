// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:latlong2/latlong.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_application/components/boxcontentrepo.dart';
import 'package:women_safety_application/components/callnumberrepo.dart';
import 'package:women_safety_application/components/locationcard.dart';
import 'package:women_safety_application/constants/theme.dart';
import 'package:women_safety_application/database/traveluploadsqlite.dart';
import 'package:women_safety_application/service/checkservice.dart';
import 'package:women_safety_application/service/geocoding.dart';
import 'package:women_safety_application/service/locationcallservice.dart';
import 'package:women_safety_application/service/sensortrigger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //SQLite DB Dependency Injection
  DatabaseHelper databaseHelper = Get.put(DatabaseHelper());
  // WhatsApp Service Dependency Injection
  Service service = Get.put(Service());
  // Sensor Dependency Injection
  EmergencySOSController emergencySOSController =
      Get.put(EmergencySOSController());
  // Geocoding Dependency Injection
  GeocodingLocation geocodingLocation = Get.put(GeocodingLocation());
  // Permission Handler
  PermissionsHandler permissionsController = Get.put(PermissionsHandler());

  // Get all persons data and appending
  List<Map<String, dynamic>> carePerson = [];
  Future<void> allpersons() async {
    final allpersons = await databaseHelper.getalldetails();
    setState(() {
      carePerson = allpersons;
    });
  }

  // Delete persons data
  Future<void> deleteperson(int id) async {
    await databaseHelper.deletedetails(id);
    allpersons();
  }

  // WhatsApp Location
  openwhatsapp() async {
    var message =
        "https://www.google.com/maps/search/?api=1&query=${service.latitude},${service.longitude}";
    var whatsapp = '+919514114153';
    var whatsappurlAndroid =
        "whatsapp://send?phone=$whatsapp&text=${Uri.encodeFull(message)}";
    var whatappurlIos =
        "https://wa.me/$whatsapp?text=${Uri.parse('${service.latitude},${service.longitude}')}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappurlIos)) {
        await launch(whatappurlIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: sRed,
            content: Text(
              "whatsapp no installed",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: sWhite,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }
    } else {
      // android , web
      if (await canLaunch(whatsappurlAndroid)) {
        await launch(whatsappurlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: sRed,
            content: Text(
              "whatsapp no installed",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: sWhite,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }
    }
  }

  // Twillio Flutter Operation
  late TwilioFlutter twilioFlutter;
  void sendSms() async {
    twilioFlutter.sendSMS(
      toNumber: '+919514114153',
      messageBody:
          'Hurry Up!, I am over here 👇👇 \n https://www.google.com/maps/search/?api=1&query=${service.latitude},${service.longitude}',
    );
  }

  // Global variable to manage the audio player instance
  AudioPlayer? globalPlayer;

  Future<void> playPanicAlarm(String soundUrl) async {
    try {
      final player = AudioPlayer();
      globalPlayer = player; // Assign to global variable

      await player.setAsset(soundUrl);
      await player.setLoopMode(LoopMode.one);
      await player.play();
    } catch (error) {
      print(error.toString());
      Get.snackbar(
        'Error Playing',
        'Error playing alarm, please ensure device is capable of working',
        backgroundColor: sBlack,
        colorText: sWhite,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    // Don't dispose here
  }

  // Init state to call everything
  @override
  void initState() {
    super.initState();
    allpersons();
    twilioFlutter = TwilioFlutter(
      accountSid: 'AC4fb786025f16957737d3ca3068b4a2c7',
      authToken: '8eeb98f95abf01e0583041ebf578fc34',
      twilioNumber: '+16592768227',
    );
  }

  // Controller for Map from flutter_map package
  MapController myController = MapController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: sWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          emergencySOSController.triggerEmergencySOS(context);
        },
        elevation: 0,
        backgroundColor: sRed,
        child: SvgPicture.network(
          'https://www.svgrepo.com/show/435154/sos.svg',
          height: 30,
          width: 30,
          color: sWhite,
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.network(
            'https://www.svgrepo.com/show/405813/hollow-red-circle.svg',
            height: 12,
            width: 12,
            // color: sBlack.withOpacity(0.3),
          ),
        ),
        title: Text(
          "Safe Haven",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: sBlack,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed('TravelDataUploadPage');
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 15),
              child: SvgPicture.network(
                'https://www.svgrepo.com/show/302551/share.svg',
                height: 26,
                width: 26,
                // color: sBlack.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Text(
                "Safety Center",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: sBlack,
                ),
              ),
              const Gap(5),
              Text(
                "Get the support, tools and information you need to be safe with our most in-demand mobile application",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: sBlack.withOpacity(0.5),
                ),
              ),
              const Gap(10),
              Center(
                child: CallNumberRepo(
                  txt1: 'Call emergency number 📢',
                  txt2:
                      'Call to the care person and end-less posibilities to your safety which is our priority',
                  img: 'https://www.svgrepo.com/show/102161/emergency-call.svg',
                  click: () async {
                    await service.makePhonecall('1091');
                  },
                ),
              ),
              const Gap(20),
              Text(
                "We are here 👇",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: sBlack,
                ),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BoxContentRepo(
                    icnlink:
                        'https://www.svgrepo.com/show/418130/call-calling.svg',
                    txt: 'Women\nHelpline',
                    click: () async {
                      await service.makePhonecall('04428592750');
                    },
                  ),
                  BoxContentRepo(
                    icnlink:
                        'https://www.svgrepo.com/show/199969/position-gps.svg',
                    txt: 'Location\nTrack',
                    click: () async {
                      await service.getLocation();
                      myController.move(
                        LatLng(service.latitude, service.longitude),
                        18.0,
                      );
                      geocodingLocation.getPlacemark(
                        service.latitude,
                        service.longitude,
                      );
                      myController.latLngToScreenPoint(
                        LatLng(service.latitude, service.longitude),
                      );
                      Get.snackbar(
                        'Location Tracked',
                        'Location Tracking is ON while you are roaming through the world, lets explore the world without any fear',
                        backgroundColor: sGreen,
                        colorText: sWhite,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BoxContentRepo(
                    icnlink:
                        'https://www.svgrepo.com/show/343571/peanut-network-communication-connection-internet-interaction.svg',
                    txt: 'Ping\nYou',
                    click: () {
                      sendSms();
                    },
                  ),
                  BoxContentRepo(
                    icnlink: 'https://www.svgrepo.com/show/188469/sensor.svg',
                    txt: 'Sensor On',
                    click: () {
                      Get.snackbar(
                        'Success',
                        'Sensor is ON while you are roaming through the world, lets explore the world without any fear',
                        backgroundColor: sGreen,
                        colorText: sWhite,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onDoubleTap: () {
                      globalPlayer
                          ?.stop()
                          .then((value) => globalPlayer?.dispose());
                      globalPlayer = null;
                    },
                    child: BoxContentRepo(
                      icnlink:
                          'https://www.svgrepo.com/show/214434/sound-waves.svg',
                      txt: 'Sound\nOn',
                      click: () {
                        playPanicAlarm('assets/police_siren.mp3');
                        Get.snackbar(
                          'Success',
                          'Play Alarm is triggered, Double Tap to stop panic alarm!',
                          backgroundColor: sBlack,
                          colorText: sWhite,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                  ),
                  BoxContentRepo(
                    icnlink: 'https://www.svgrepo.com/show/354560/whatsapp.svg',
                    txt: 'WhatsApp\nLocation',
                    click: () {
                      openwhatsapp();
                    },
                  ),
                ],
              ),
              const Gap(20),
              Text(
                "Your Location",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: sBlack,
                ),
              ),
              const Gap(10),
              LocationCard(
                screenSize: screenSize,
                myController: myController,
              ),
              const Gap(20),
              Text(
                "Your Lovable ❣️",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: sBlack,
                ),
              ),
              const Gap(10),
              SizedBox(
                width: screenSize.width * 1,
                height: screenSize.height * 0.18,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: carePerson.length,
                  itemBuilder: (context, index) {
                    final person = carePerson[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () async {
                          await service.makePhonecall(
                              '+91${person['phonenumber'].toString()}');
                        },
                        onLongPress: () {
                          deleteperson(person['id']);
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: screenSize.height * 0.09,
                          width: screenSize.width * 0.5,
                          constraints: const BoxConstraints(
                            maxHeight: double.infinity,
                            maxWidth: double.infinity,
                          ),
                          decoration: BoxDecoration(
                            color: sBlack.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  person['relation'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: sBlack.withOpacity(0.4),
                                  ),
                                ),
                                Text(
                                  person['name'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: sPink,
                                  ),
                                ),
                                Text(
                                  person['phonenumber'].toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: sBlack,
                                  ),
                                ),
                                Text(
                                  person['destination'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: sBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
