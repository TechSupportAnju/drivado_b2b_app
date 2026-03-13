// import 'package:drivado_b2b_app/screens/auth/login/login_screen.dart';
// import 'package:drivado_b2b_app/screens/common_widgets/custom_buttons.dart';
// import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
// import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
// import 'package:drivado_b2b_app/utils/theme/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ChangePasswordPage extends StatefulWidget {
//   const ChangePasswordPage({super.key});
//
//   @override
//   State<ChangePasswordPage> createState() => _ChangePasswordPageState();
// }
//
// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//
//   TextEditingController password = TextEditingController();
//   TextEditingController confirmPassword = TextEditingController();
//   bool isButtonActive = false;
//   bool isConfirmPasswordValidator = false;
//   bool isPasswordValidator = false;
//   bool isValidPassword = false;
//
//   bool isTapConfirmPasswordName = false;
//   bool isTapPasswordName = false;
//   bool observeText = true;
//   bool isRemember = false;
//   bool observeText2 = true;
//   bool isLoad = false;
//
//
//   @override
//   void initState() {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement initState
//     super.dispose();
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //final Size screenSize = MediaQuery.of(context).size;
//     //final double screenHeight = screenSize.height;
//     return PopScope(
//       canPop: true,
//       onPopInvokedWithResult: (bool didPop, Object? result) async {
//         Navigator.pop(context);
//         Navigator.pop(context);
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 280,
//                   decoration: BoxDecoration(
//                       color: Color(0xff190C0C),
//                       image: DecorationImage(
//                           image: AssetImage(
//                               'assets/auth/signup.png'),
//                           fit: BoxFit.fill)),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 22.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pop(context);
//                                 // Navigator.pop(context);
//                               },
//                               child: const Icon(
//                                 Icons.keyboard_backspace,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 18,
//                         ),
//                         Row(
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                 text: 'Change your\n',
//                                 style: GoogleFonts.plusJakartaSans(
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 28,
//                                     height: 1.2,
//                                     color: Colors.white),
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                       text: 'Password',
//                                       style: GoogleFonts.plusJakartaSans(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 28,
//                                           height: 1.2,
//                                           color: AppColors.secondary)),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 18,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const Spacer()
//               ],
//             ),
//             Positioned.fill(
//               top: 250,
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: CustomDecorations().baseBackgroundDecoration(20.0, 1.0, Colors.white, Colors.transparent),
//                 child:  SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 0),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 20,),
//                         CustomTextField(
//                           title: 'Password',
//                           hintText: 'Enter your password',
//                           controller: password,
//                           isPassword: observeText,
//                           icon: 'null',
//                           height: 52,
//                           width: MediaQuery.of(context).size.width,
//                           onChanged: (val) {
//                             if(password.text != '') {
//                               isPasswordValidator = false;
//                             }else {
//                               isPasswordValidator = true;
//                             }
//                             setState(() {
//                             });
//                           },
//                           onTap: () {
//                             // isTapPassword = true;
//                             // setState(() {
//                             // });
//                           },
//                           onTapSuffix: () {
//                             setState(() {
//                               observeText = !observeText;
//                             });
//                           },
//                           suffix: true,
//                           readOnly: false,
//                           astric: true,
//                           error: isPasswordValidator,
//                         ),
//                         const SizedBox(height: 12,),
//                         CustomTextField(
//                           title: 'Confirm Password',
//                           hintText: 'Enter your confirm password',
//                           controller: confirmPassword,
//                           isPassword: observeText2,
//                           icon: 'null',
//                           height: 52,
//                           width: MediaQuery.of(context).size.width,
//                           onChanged: (val) {
//                             if(confirmPassword.text != '') {
//                               isConfirmPasswordValidator = false;
//                             }else {
//                               isConfirmPasswordValidator = true;
//                             }
//                             setState(() {
//                             });
//                           },
//                           onTap: () {
//                             // isTapPassword = true;
//                             // setState(() {
//                             // });
//                           },
//                           onTapSuffix: () {
//                             setState(() {
//                               observeText2 = !observeText2;
//                             });
//                           },
//                           suffix: true,
//                           readOnly: false,
//                           astric: true,
//                           error: isConfirmPasswordValidator,
//                         ),
//
//                         const SizedBox(
//                           height: 32,
//                         ),
//                         CustomButtons(onTap: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
//                         },
//                             isIcon: false,
//                             title: 'Change Password', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
//
//
