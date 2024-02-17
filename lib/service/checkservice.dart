import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler extends GetxController {
  var allpermissionGranted = "0".obs;
  var locationperssion = false.obs;
  var callpermission = false.obs;
  Location location = Location();

  @override
  void onInit() {
    super.onInit();
    checkservice();
  }

  bool checkpermission() {
    if (allpermissionGranted.value == "1") {
      return true;
    } else {
      return false;
    }
  }

  void checkservice() async {
    if (await Permission.location.isGranted &&
        await Permission.phone.isGranted) {
      allpermissionGranted.value == "1";
    } else {
      (await Permission.location.isGranted == true)
          ? locationperssion.value = true
          : null;
      (await Permission.phone.isGranted == true)
          ? callpermission.value = true
          : null;
    }
  }

  void requestpermission() async {
    await Permission.location.request();
    await Permission.phone.request();
    checkservice();
  }

  void permissiondenied() async {
    if (!await Permission.location.request().isGranted) {
      AppSettings.openAppSettings();
    }
    if (!await Permission.phone.request().isGranted) {
      AppSettings.openAppSettings();
    }
    checkservice();
  }
}
