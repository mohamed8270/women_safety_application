// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:just_audio/just_audio.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:women_safety_application/constants/theme.dart';
import 'package:women_safety_application/service/locationcallservice.dart';

class EmergencySOSController extends GetxController {
  final Rx<AudioPlayer?> player = Rx(null);
  final Rx<UserAccelerometerEvent?> lastAccel = Rx(null);
  final Rx<GyroscopeEvent?> lastGyro = Rx(null);

  // Call ans LOcation Dependency Injection
  Service service = Get.put(Service());

  // Emergency LOcation Share Function
  // Twillio Flutter Operation
  late TwilioFlutter twilioFlutter;
  void sendSms() async {
    twilioFlutter.sendSMS(
      toNumber: '+919514114153',
      messageBody:
          'Hurry Up!, I am over here 👇👇 \n https://www.google.com/maps/search/?api=1&query=${service.latitude},${service.longitude}',
    );
  }

  @override
  void onInit() {
    super.onInit();
    // Access sensor streams directly
    userAccelerometerEvents.listen((event) {
      lastAccel.value = event;
      if (isRunningDetected() || isFallingDetected()) {
        print('Shake or fall detected');
        // You can trigger SOS here or in a separate method
        triggerEmergencySOS(Get.context!);
      }
    });
    gyroscopeEvents.listen((event) => lastGyro.value = event);
    twilioFlutter = TwilioFlutter(
      accountSid: 'AC4fb786025f16957737d3ca3068b4a2c7',
      authToken: '8eeb98f95abf01e0583041ebf578fc34',
      twilioNumber: '+16592768227',
    );
  }

  @override
  void dispose() {
    player.value?.dispose();
    super.dispose();
  }

  bool isRunningDetected() {
    if (lastAccel.value == null) return false;
    const threshold = 10.0; // Adjust based on testing
    // print(
    //     'Accel: X=${lastAccel.value!.x}, Y=${lastAccel.value!.y}, Z=${lastAccel.value!.z}');
    return lastAccel.value!.x.abs() > threshold ||
        lastAccel.value!.y.abs() > threshold;
  }

  bool isFallingDetected() {
    if (lastAccel.value == null || lastGyro.value == null) return false;
    const accelThreshold = 35.0; // Adjust based on testing
    const gyroThreshold = 25.0; // Adjust based on testing
    // print(
    //     'Gyro: X=${lastGyro.value!.x}, Y=${lastGyro.value!.y}, Z=${lastGyro.value!.z}');
    return lastAccel.value!.z.abs() > accelThreshold ||
        lastGyro.value!.x.abs() > gyroThreshold;
  }

  void triggerEmergencySOS(BuildContext context) async {
    // Play alarm sound
    // player.value
    //     ?.setUrl('https://example.com/alarm.mp3'); // Replace with your URL
    // player.value?.play();

    // Emergency Call Function
    await service.makePhonecall('04428592750');

    // Sent Location SMS
    sendSms();

    // Show snackbar for confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: sGreen,
        content: Text(
          'Emergency SOS triggered!',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: sWhite,
          ),
        ),
      ),
    );

    // Implement your specific emergency response logic here
    // Get.find<LocationController>().shareLocation(); // Example using another controller
    // Contact emergency services or send location using appropriate APIs
  }
}
