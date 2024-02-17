import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:women_safety_application/components/custombutton.dart';
import 'package:women_safety_application/components/userinput.dart';
import 'package:women_safety_application/constants/theme.dart';
import 'package:women_safety_application/database/traveluploadsqlite.dart';

class TravelDataUploadPage extends StatefulWidget {
  const TravelDataUploadPage({super.key});

  @override
  State<TravelDataUploadPage> createState() => _TravelDataUploadPageState();
}

class _TravelDataUploadPageState extends State<TravelDataUploadPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController fromdateController = TextEditingController();
  TextEditingController todateController = TextEditingController();
  TextEditingController travelmodeController = TextEditingController();

  DateTime? selectedFromDate;
  DateTime? selectedToDate;

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedFromDate) {
      setState(() {
        selectedFromDate = picked;
        fromdateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedToDate) {
      setState(() {
        selectedToDate = picked;
        todateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  DatabaseHelper databaseHelper = Get.put(DatabaseHelper());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: sWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            click: () {
              Get.toNamed("BottomNavBar");
            },
            height: screenSize.height * 0.06,
            width: screenSize.width * 0.47,
            boxcolor: sRed,
            txt: "Cancel",
            txtcolor: sWhite,
          ),
          CustomButton(
            click: () async {
              Map<String, dynamic> userData = {
                'name': nameController.text,
                'relation': relationController.text,
                'phonenumber': phoneController.text,
                'address': addressController.text,
                'destination': destinationController.text,
                'fromdate': fromdateController.text,
                'todate': todateController.text,
                'travelmode': travelmodeController.text,
              };

              await databaseHelper.insertdetail(userData);
              Get.toNamed("BottomNavBar");
            },
            height: screenSize.height * 0.06,
            width: screenSize.width * 0.47,
            boxcolor: sGreen,
            txt: "Post",
            txtcolor: sWhite,
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.network(
            'https://www.svgrepo.com/show/474365/travel.svg',
            height: 12,
            width: 12,
            // color: sBlack.withOpacity(0.3),
          ),
        ),
        title: Text(
          "Safe Travel",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: sBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User Detail's",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: sBlack,
                ),
              ),
              const Gap(10),
              UserInputBox(
                height: screenSize.height * 0.055,
                width: screenSize.width * 0.95,
                icnLink: 'https://www.svgrepo.com/show/491095/user.svg',
                txt: 'Name',
                type: TextInputType.name,
                userController: nameController,
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserInputBox(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.47,
                    icnLink: 'https://www.svgrepo.com/show/511099/path.svg',
                    txt: 'Relation',
                    type: TextInputType.name,
                    userController: relationController,
                  ),
                  UserInputBox(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.47,
                    icnLink:
                        'https://www.svgrepo.com/show/533284/phone-alt.svg',
                    txt: 'Phone No.',
                    type: TextInputType.number,
                    userController: phoneController,
                  ),
                ],
              ),
              const Gap(10),
              UserInputBox(
                height: screenSize.height * 0.2,
                width: screenSize.width * 0.95,
                icnLink:
                    'https://www.svgrepo.com/show/408768/landmark-lighthouse-building-beach-safety-ocean.svg',
                txt: 'Address',
                type: TextInputType.streetAddress,
                userController: addressController,
              ),
              const Gap(20),
              Text(
                "Destination Detail's",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: sBlack,
                ),
              ),
              const Gap(10),
              UserInputBox(
                height: screenSize.height * 0.055,
                width: screenSize.width * 0.95,
                icnLink:
                    'https://www.svgrepo.com/show/532540/location-pin-alt-1.svg',
                txt: 'Destination',
                type: TextInputType.streetAddress,
                userController: destinationController,
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _selectFromDate(context),
                    child: AbsorbPointer(
                      child: UserInputBox(
                        height: screenSize.height * 0.055,
                        width: screenSize.width * 0.47,
                        icnLink:
                            'https://www.svgrepo.com/show/524350/calendar.svg',
                        txt: 'From Date',
                        type: TextInputType.datetime,
                        userController: fromdateController,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectToDate(context),
                    child: AbsorbPointer(
                      child: UserInputBox(
                        height: screenSize.height * 0.055,
                        width: screenSize.width * 0.47,
                        icnLink:
                            'https://www.svgrepo.com/show/524350/calendar.svg',
                        txt: 'To Date',
                        type: TextInputType.datetime,
                        userController: todateController,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              UserInputBox(
                height: screenSize.height * 0.055,
                width: screenSize.width * 0.95,
                icnLink:
                    'https://www.svgrepo.com/show/383990/travel-holidays-vacation-case-suitcase-luggage.svg',
                txt: 'Travel Mode',
                type: TextInputType.text,
                userController: travelmodeController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
