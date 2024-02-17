// // ignore_for_file: unused_local_variable, unused_field

// // import 'dart:convert';
// // import 'dart:io';

// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AdminActivity extends StatefulWidget {
//   const AdminActivity({super.key});

//   @override
//   State<AdminActivity> createState() => _AdminActivityState();
// }

// class _AdminActivityState extends State<AdminActivity> {
//   TextEditingController NameController = TextEditingController();
//   TextEditingController DepartController = TextEditingController();
//   TextEditingController StudentController = TextEditingController();

//   final cloudName = 'dztgmgwu1';
//   final cloudapikey = '497233343816649';
//   final cloudapisecret = 'InQdUFk1_uynDNLe70jzFBBF60U';

//   Future<void> CompletePopup(BuildContext context) async {
//     final screenSize = MediaQuery.of(context).size;
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SizedBox(
//             height: screenSize.height * 0.2,
//             child: Text(
//               'Your data has added successfully',
//               style: GoogleFonts.poppins(
//                 color: cBlack,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//           actions: [
//             ButtonRes(
//               btntxt: 'Go back',
//               Height: screenSize.height * 0.04,
//               Width: screenSize.width * 0.1,
//               ctncolor: cBlue,
//               txtcolor: cWhite,
//               Click: () {
//                 Get.to(
//                   const AdminHomePage(),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: cWhite,
//         title: Text(
//           'MAKE YOUR OWN FANTASY PROFILE',
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: cBlack,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(
//           left: 10,
//           right: 10,
//           top: 10,
//         ),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Gap(25),
//               UserInputField(
//                 Height: screenSize.height * 0.06,
//                 Width: screenSize.width,
//                 Controller: NameController,
//                 Label: 'Name',
//                 htxt: 'Enter your name',
//               ),
//               const Gap(15),
//               UserInputField(
//                 Height: screenSize.height * 0.06,
//                 Width: screenSize.width,
//                 Controller: DepartController,
//                 Label: 'Department',
//                 htxt: 'Enter your Department',
//               ),
//               const Gap(15),
//               UserInputField(
//                 Height: screenSize.height * 0.06,
//                 Width: screenSize.width,
//                 Controller: StudentController,
//                 Label: 'No. of Students',
//                 htxt: 'Enter count of students',
//               ),
//               const Gap(20),
//               ButtonRes(
//                 btntxt: 'upload',
//                 Height: screenSize.height * 0.05,
//                 Width: screenSize.width * 0.4,
//                 ctncolor: cBlue,
//                 txtcolor: cWhite,
//                 Click: () async {},
//               ),
//               const Gap(300),
//               ButtonRes(
//                 btntxt: 'Submit',
//                 Height: screenSize.height * 0.05,
//                 Width: screenSize.width,
//                 ctncolor: cBlue,
//                 txtcolor: cWhite,
//                 Click: () async {
//                   FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if(result != null) {
//       File file = File(result.files.single.path.toString());
//       FirebaseStorage storage = FirebaseStorage.instance;
//       Reference ref = storage.ref().child("path/to/destination");

//       UploadTask uploadTask = ref.putFile(file);
//       uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
//         print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
//       }, onError: (e) {
//         print(uploadTask.snapshot);

//         if (e.code == 'permission-denied') {
//           print('User does not have permission to upload to this reference.');
//         }
//       });
//     } else {
//       // User canceled the picker
//     },
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
