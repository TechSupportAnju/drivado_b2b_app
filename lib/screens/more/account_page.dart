//
// import 'package:cached_network_svg_image/cached_network_svg_image.dart';
// import 'package:drivado_b2b_app/models/country_code/country_code_model.dart';
// import 'package:figma_squircle/figma_squircle.dart' show SmoothRectangleBorder, SmoothBorderRadius;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'widgets/account_widget.dart';
//
// class AccountPage extends StatefulWidget {
//   const AccountPage({super.key});
//
//   @override
//   State<AccountPage> createState() => _AccountPageState();
// }
//
// class _AccountPageState extends State<AccountPage> {
//
//   TextEditingController firstName = TextEditingController();
//   TextEditingController emailId = TextEditingController();
//   TextEditingController lastName = TextEditingController();
//   TextEditingController phoneNumber = TextEditingController();
//
//   String countryCode = '';
//   String countryCodeShow = '';
//   List countrtyList = [];
//   List<CountryCodeModel> countrylisttt = [];
//   TextEditingController country = TextEditingController();
//   List<CountryCodeModel> filterList = [];
//
//   bool isTapContactName = false;
//   bool firstNameValidator = false;
//   bool lastNameValidator = false;
//   bool contactValidator = false;
//
//   bool saveActive = false;
//   bool isLoad = true;
//   bool isLoadPopup = false;
//
//   @override
//   void initState() {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//     super.initState();
//     fetchCountryCode();
//     context.read<ProfileBloc>().add(
//         ProfileDetails()
//     );
//   }
//
//
//   Future<void> fetchCountryCode() async {
//     countrtyList.clear();
//     countrylisttt.clear();
//     countrylisttt = countryCodeData;
//     filterList = List.from(countrylisttt);
//     if (countrylisttt.isNotEmpty) {
//       for (var element in countrylisttt) {
//         // if (element.code == _currentAddress) {
//         //   countryCode = element['dial_code'];
//         // }
//         countrtyList.add(element.dial_code);
//       }
//     }
//     // setState(() {
//     //   isLoading = false;
//     // });
//   }
//   @override
//   void dispose() {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     final Size screenSize = MediaQuery.of(context).size;
//     final double screenWidth = screenSize.width;
//
//     return Scaffold(
//         backgroundColor: AppColors.adminUserMangBgColor,
//         body: BlocListener<ProfileBloc, ProfileState>(
//             listener: (context, state) async{
//               if (state is ProfileSuccess) {
//                 firstName = TextEditingController(text: '${state.ProfileResponse.firstName}') ;
//                 emailId = TextEditingController(text: '${state.ProfileResponse.email}');
//                 lastName = TextEditingController(text: '${state.ProfileResponse.lastName}');
//                 phoneNumber = TextEditingController(text: '${state.ProfileResponse.phone}');
//                 countryCodeShow = '${state.ProfileResponse.countryCode}';
//                 setState(() {
//                   isLoad = false;
//                 });
//               } else if (state is ProfileFailure) {
//                 setState(() {
//                   isLoad = false;
//                 });
//                 // return CustomText(title: 'Something went wrong', color: AppColors.manageBookingAdminbookedbyTitleTextColor, fontWeight: FontWeight.w500, fontSize: 18);
//               }
//             },
//             child: isLoad
//            ? Center(child:  LoadingAnimationWidget.threeArchedCircle(
//                 color: AppColors.secondary,
//                 size: 30
//             ),)
//            : Column(
//               children: [
//                 Container(
//                   height: 110,
//                   color: Colors.white,
//                   alignment: Alignment.bottomLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 20.0, left: 16, right: 16),
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Icon(Icons.keyboard_backspace, color: AppColors.manageBookingbokkedByTextColor,)),
//                         SizedBox(width: 16,),
//                         CustomText(title: 'User Details', fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.manageBookingAdminbookedbyTitleTextColor,),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Container(
//                     decoration: CustomDecorations().baseBackgroundDecoration(12.0, 1.0, Colors.white, Colors.white),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         children: [
//                           Container(
//                             width: screenWidth,
//                             height: 110,
//                             decoration: CustomDecorations().baseBackgroundDecoration(12.0, 1.0, AppColors.adminUserMangBgColor, AppColors.adminUserMangBgColor),
//                             padding: EdgeInsets.all(12),
//                             child: SvgPicture.asset("assets/profile/profile_circle_icon.svg"),
//                           ),
//                           SizedBox(height: 24,),
//                           UserProfileWidget(
//                             text: 'Full Name',
//                             image: 'assets/profile/user.svg',
//                             desc: '${firstName.text} ${lastName.text}',),
//                           SizedBox(height: 20,),
//                           UserProfileWidget(
//                             text: 'Email',
//                             image: 'assets/profile/mail.svg',
//                             desc: '${emailId.text}',),
//                           SizedBox(height: 20),
//                           UserProfileWidget(
//                             text: 'Contact Number',
//                             image: 'assets/profile/contact.svg',
//                             desc: '$countryCodeShow ${phoneNumber.text}',),
//                           SizedBox(height: 24,),
//                           GestureDetector(
//                             onTap: () async{
//                               showEditDialog(context);
//                               setState(() {
//                                 isLoad = true;
//                               });
//                               context.read<ProfileBloc>().add(
//                                   ProfileDetails()
//                               );
//                             },
//                             child: Container(
//                               height: 48,
//                               decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, AppColors.secondary, AppColors.secondary),
//                               alignment: Alignment.center,
//                               child: const CustomText(
//                                   title: 'Edit Profile',
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16),
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )
//         )
//
//     );
//   }
//
//   //edit popup ----------------------
//   showEditDialog(context) {
//     TextEditingController phoneEdit = TextEditingController();
//     TextEditingController firstEdit = TextEditingController();
//     TextEditingController lastEdit = TextEditingController();
//     isTapContactName = true;
//     firstNameValidator = false;
//     lastNameValidator = false;
//     contactValidator = false;
//
//       phoneEdit = TextEditingController(text: phoneNumber.text);
//       firstEdit = TextEditingController(text: firstName.text);
//       lastEdit = TextEditingController(text: lastName.text);
//       countryCode = countryCodeShow;
//       setState(() {
//       });
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(builder: (context, newState) {
//           // Start a timer to update progress
//           return Dialog(
//             insetPadding: const EdgeInsets.symmetric(horizontal: 15),
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             backgroundColor: Colors.transparent,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: contactValidator && firstNameValidator && lastNameValidator ? 460
//                   : contactValidator && firstNameValidator ? 440
//                   : firstNameValidator && lastNameValidator ? 440
//                   : contactValidator && lastNameValidator ? 440
//                   : contactValidator || firstNameValidator || lastNameValidator ? 420: 400,
//               decoration: CustomDecorations().baseBackgroundDecoration(16.0, 1.0, AppColors.adminUserMangBgColor, Colors.transparent),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 56,
//                     padding: EdgeInsets.all(12),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                        CustomText(title: 'Edit your profile', color: AppColors.manageBookingbokkedByTextColor, fontWeight: FontWeight.w500, fontSize: 14),
//                         GestureDetector(
//                            onTap: () {
//                              //context.pop();
//                              Navigator.pop(context);
//                            },
//                            child:SvgPicture.asset('assets/profile/close-circle.svg')),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child:
//                   Container(
//                     // color: Colors.white,
//                     decoration: CustomDecorations().baseBackgroundDecoration(16.0, 1.0, Colors.white, Colors.white),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 16,),
//                           firstTextField(context, 'First Name', 'Enter your first name', firstEdit, false, newState),
//                            SizedBox(height: firstNameValidator ? 5 : 0,),
//                           _validationMessage(firstNameValidator, 'Please enter your first name'),
//                           const SizedBox(height: 12,),
//                           lastTextField(context, 'Last Name', 'Enter your last name', lastEdit, false, newState),
//                           SizedBox(height: lastNameValidator ? 5 : 0,),
//                           _validationMessage(lastNameValidator, 'Please enter your last name'),
//                           const SizedBox(height: 12,),
//                           _contactTextField(context, phoneEdit, newState),
//                           SizedBox(height: contactValidator ? 5 : 0,),
//                           _validationMessage(contactValidator, 'Please enter your contact number'),
//                           const SizedBox(height: 12,),
//                           Container(
//                         height: MediaQuery.of(context).size.height * 0.06,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: ShapeDecoration(
//                           color: AppColors.backArrowColor.withOpacity(0.2),
//                           shape: SmoothRectangleBorder(
//                             side: BorderSide(
//                                 color: AppColors.backArrowColor),
//                             borderRadius: SmoothBorderRadius(
//                               cornerRadius: 10,
//                               cornerSmoothing: 1,
//                             ),
//                           ),
//                         ),
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         alignment: Alignment.center,
//                         child: TextFormField(
//                           readOnly: true,
//                           textCapitalization: TextCapitalization.sentences,
//                           controller: emailId,
//                           cursorColor: Colors.black,
//                           cursorHeight: 15,
//                           cursorWidth: 1.5,
//                           style: GoogleFonts.plusJakartaSans( color: AppColors.textFieldLabelTextColor,
//                               fontWeight: FontWeight.w600, fontSize: 13),
//                           decoration: InputDecoration(
//                               border: InputBorder.none,
//                               label: Container(
//                                 transform: Matrix4.translationValues(
//                                     0.0, -4.0, 0.0),
//                                 child: RichText(
//                                   text: TextSpan(
//                                       text: 'Email ID',
//                                       style: GoogleFonts.plusJakartaSans(
//                                           color: AppColors.textFieldTextColor,
//                                           fontWeight: FontWeight.w400, fontSize: 12),
//                                       children: [
//                                         const TextSpan(
//                                             text: '*',
//                                             style: TextStyle(
//                                               color: AppColors.secondary,
//                                             ))
//                                       ]),
//                                 ),
//                               ),
//                               hintStyle: GoogleFonts.plusJakartaSans(
//                                 fontWeight: FontWeight.w600,
//                                   color: AppColors.textFieldLabelTextColor, fontSize: 13),
//                               hintText: 'techSupport@gmail.com'),
//                           onTap: () {
//                             if(country.text == '') {
//                               isTapContactName = false;
//                             }
//                             newState(() {
//                             });
//                           },
//                         ),
//                       ),
//                           const SizedBox(height: 16,),
//                           Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.pop(context);
//                                    },
//                                   child: Container(
//                                     height: 44,
//                                     decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, Colors.white, AppColors.manageBookingbokkedByTextColor),
//                                     alignment: Alignment.center,
//                                     child: const CustomText(title: 'Cancel', color: AppColors.manageBookingbokkedByTextColor, fontWeight: FontWeight.w600, fontSize: 16),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 12,),
//                               BlocListener<EditProfileBloc, EditProfileState>(
//                               listener: (context, state) async{
//                               if (state is EditProfileSuccess) {
//
//                               toastification.show(
//                                 context: context,
//                                 title: Text('Profile edited successfully'),
//                                 type: ToastificationType.success,
//                                 autoCloseDuration: const Duration(seconds:3),
//                               );
//                               context.read<ProfileBloc>().add(
//                                   ProfileDetails()
//                               );
//                               newState(() {
//                                 isLoadPopup = false;
//                                 isLoad = true;
//                               });
//                               Navigator.pop(context);
//
//                             } else if (state is EditProfileFailure) {
//                               newState(() {
//                                 isLoadPopup = false;
//                               });
//                               toastification.show(
//                                 context: context,
//                                 title: Text('Something went wrong , Please try again '),
//                                 type: ToastificationType.error,
//                                 autoCloseDuration: const Duration(seconds:3),
//                               );
//                               Navigator.pop(context);
//                             }
//                           },
//                           child:
//                             Expanded(
//                             flex: 1,
//                             child: InkWell(
//                               onTap: () {
//                                 if(saveActive) {
//                                   newState(() {
//                                     isLoadPopup = true;
//                                   });
//                                   context.read<EditProfileBloc>().add(
//                                       EditProfileDetails(
//                                           firstName: firstEdit.text.trim(),
//                                           lastName: lastEdit.text.trim(),
//                                           countryCode: countryCode.trim(),
//                                           phoneNumber: phoneEdit.text.trim()
//                                       )
//                                   );
//                                 }
//                               },
//                               child: Container(
//                                 height: 44,
//                                 decoration: CustomDecorations().baseBackgroundDecoration(8.0, 1.0, saveActive ?  AppColors.secondary : AppColors.secondary.withOpacity(0.3), saveActive ?  AppColors.secondary : Colors.transparent),
//                                 alignment: Alignment.center,
//                                 child: isLoadPopup
//                                   ? Center(child:  LoadingAnimationWidget.threeArchedCircle(
//                                     color: Colors.white,
//                                     size: 30
//                                 ))
//                                   : const CustomText(title: 'Save', color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
//                               ),
//                             ),
//                           ),
//                             )
//                             ],
//                           ),
//                           const SizedBox(height: 16,),
//                         ],
//                       ),
//                     ),
//                   ))
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }
//
//   //----For country code & contact number text filed----
//   Widget _contactTextField(BuildContext context, controller, setState) {
//     return Container(
//       height:52,
//       decoration: ShapeDecoration(
//         shape: SmoothRectangleBorder(
//           side: BorderSide(
//               color: contactValidator ? AppColors.secondary : AppColors.background),
//           borderRadius: SmoothBorderRadius(
//             cornerRadius: 10,
//             cornerSmoothing: 1,
//           ),
//         ),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       alignment: Alignment.center,
//       child: TextFormField(
//         textCapitalization: TextCapitalization.sentences,
//         controller: controller,
//         cursorColor: Colors.black,
//         cursorHeight: 15,
//         cursorWidth: 1.5,
//         keyboardType: TextInputType.number,
//         style: GoogleFonts.plusJakartaSans(
//             fontWeight: FontWeight.w600, fontSize: 14),
//         decoration: InputDecoration(
//             prefixIcon: !isTapContactName
//                 ? Stack(
//               alignment: Alignment.centerLeft,
//               children: [
//                 _countryCodePicker(
//                     context), // Positioned country code picker
//               ],
//             )
//                 : null,
//             prefix: isTapContactName
//                 ? Stack(
//               alignment: Alignment.centerLeft,
//               children: [
//                 _countryCodePicker(
//                     context), // Positioned country code picker
//               ],
//             )
//                 : null,
//             isDense: true,
//             label: Container(
//               transform: Matrix4.translationValues(
//                   0.0, isTapContactName ? -1.0 :-1.0, 0.0),
//               child: RichText(
//                 text: TextSpan(
//                     text: 'Contact number',
//                     style: GoogleFonts.plusJakartaSans(
//                         color: AppColors.textFieldTextColor,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 13),
//                     children: const [
//                       // TextSpan(
//                       //     text: ' *',
//                       //     style: TextStyle(
//                       //       color: Colors.red,
//                       //     ))
//                     ]),
//               ),
//             ),
//             border: InputBorder.none,
//             hintStyle: GoogleFonts.plusJakartaSans(
//                 color: AppColors.textFieldTextColor, fontSize: 13),
//             hintText: 'Enter your contact number'),
//         onChanged: (val) {
//           if(val.isEmpty){
//             setState(() {
//               contactValidator = true;
//               saveActive = false;
//             });
//           } else {
//             setState(() {
//               contactValidator = false;
//              if(!contactValidator && !firstNameValidator && !lastNameValidator) {
//                saveActive = true;
//              }
//             });
//           }
//         },
//         onTap: () {
//           isTapContactName = true;
//           if(firstName.text == '') {
//             firstNameValidator = true;
//           }
//           if(lastName.text == '') {
//             lastNameValidator = true;
//           }
//           setState(() {
//           });
//         },
//       ),
//     );
//   }
//
//   Widget _countryCodePicker(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: () => _showDropdown(context),
//       child: SizedBox(
//         width: countryCode.length > 4
//             ? 69
//             : countryCode.length > 3
//             ? 60
//             : 54,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             countryCode.isEmpty
//                 ?  LoadingAnimationWidget.threeArchedCircle(
//                 color: AppColors.secondary,
//                 size: 30
//             )
//                 : Text(countryCode,
//                 style: GoogleFonts.plusJakartaSans(
//                     color: Colors.black,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500)),
//             const SizedBox(width: 2),
//             const Icon(Icons.expand_more_sharp,
//                 color: AppColors.textFieldIconColor, size: 20),
//           ],
//         ),
//       ),
//     );
//   }
//   //--------------------------------------------------
//
//   //-------First Name Text Field-----------------------------
//   Widget firstTextField(
//       BuildContext context, title, hintText, controller, isStarShow, setState) {
//     return Container(
//       height: 52,
//       width: MediaQuery.of(context).size.width,
//       decoration: ShapeDecoration(
//         shape: SmoothRectangleBorder(
//           side: BorderSide(
//               color: firstNameValidator ? AppColors.secondary : AppColors.background),
//           borderRadius: SmoothBorderRadius(
//             cornerRadius: 10,
//             cornerSmoothing: 1,
//           ),
//         ),
//       ),
//       padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
//       alignment: Alignment.center,
//       child: TextFormField(
//         textCapitalization: TextCapitalization.sentences,
//         controller: controller,
//         cursorColor: Colors.black,
//         cursorHeight: 15,
//         cursorWidth: 1.5,
//         style: GoogleFonts.plusJakartaSans(
//             fontWeight: FontWeight.w600, fontSize: 14),
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             label: Container(
//               transform: Matrix4.translationValues(
//                   0.0, firstNameValidator ? 0.0  : -4.0, 0.0),
//               child: RichText(
//                 text: TextSpan(
//                     text: '$title',
//                     style: GoogleFonts.plusJakartaSans(
//                         color: AppColors.textFieldTextColor,
//                         fontWeight: FontWeight.w400, fontSize: 13),
//                     children: isStarShow
//                         ? [
//                       const TextSpan(
//                           text: ' *',
//                           style: TextStyle(
//                             color: AppColors.secondary,
//                           ))
//                     ]
//                         : null),
//               ),
//             ),
//             // isDense: true,
//             hintStyle: GoogleFonts.plusJakartaSans(
//                 color: AppColors.textFieldTextColor, fontSize: 13),
//             hintText: '$hintText'),
//         onChanged: (val) {
//           if(val.isEmpty){
//             setState(() {
//               firstNameValidator = true;
//               saveActive = false;
//             });
//           } else {
//             setState(() {
//               firstNameValidator = false;
//               if(!contactValidator && !firstNameValidator && !lastNameValidator) {
//                 saveActive = true;
//               }
//             });
//           }
//         },
//         onTap: () {
//           if(country.text == '') {
//             isTapContactName = false;
//           }
//           if(lastName.text == '') {
//             lastNameValidator = true;
//           }
//           setState(() {
//           });
//         },
//       ),
//     );
//   }
//   //---------------------------------------------------
//
//   //-------Last Name Text Field-----------------------------
//   Widget lastTextField(
//       BuildContext context, title, hintText, controller, isStarShow,setState) {
//     return Container(
//       height: 52,
//       width: MediaQuery.of(context).size.width,
//       decoration: ShapeDecoration(
//         shape: SmoothRectangleBorder(
//           side: BorderSide(
//               color: lastNameValidator ? AppColors.secondary : AppColors.background),
//           borderRadius: SmoothBorderRadius(
//             cornerRadius: 10,
//             cornerSmoothing: 1,
//           ),
//         ),
//       ),
//       padding: const EdgeInsets.only(left: 15, right: 15, top:0),
//       alignment: Alignment.center,
//       child: TextFormField(
//         textCapitalization: TextCapitalization.sentences,
//         controller: controller,
//         cursorColor: Colors.black,
//         cursorHeight: 15,
//         cursorWidth: 1.5,
//         style: GoogleFonts.plusJakartaSans(
//             fontWeight: FontWeight.w600, fontSize: 14),
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             // isDense: true,
//             label: Container(
//               transform: Matrix4.translationValues(
//                   0.0,lastNameValidator ? 0.0 : -4.0, 0.0),
//               child: RichText(
//                 text: TextSpan(
//                     text: '$title',
//                     style: GoogleFonts.plusJakartaSans(
//                         color: AppColors.textFieldTextColor,
//                         fontWeight: FontWeight.w400, fontSize: 13),
//                     children: isStarShow
//                         ? [
//                       const TextSpan(
//                           text: ' *',
//                           style: TextStyle(
//                             color: AppColors.secondary,
//                           ))
//                     ]
//                         : null),
//               ),
//             ),
//             hintStyle: GoogleFonts.plusJakartaSans(
//                 color: AppColors.textFieldTextColor, fontSize: 13),
//             hintText: '$hintText'),
//         onChanged: (val) {
//           if(val.isEmpty){
//             setState(() {
//               lastNameValidator = true;
//               saveActive = false;
//             });
//           } else {
//             setState(() {
//               lastNameValidator = false;
//               if(!contactValidator && !firstNameValidator && !lastNameValidator) {
//                 saveActive = true;
//               }
//             });
//           }
//         },
//         onTap: () {
//           if(country.text == '') {
//             isTapContactName = false;
//           } if(firstName.text == '') {
//             firstNameValidator = true;
//           }
//           setState(() {
//
//           });
//         },
//       ),
//     );
//   }
// //---------------------------------------------------
//
//   void _showDropdown(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return _buildCountryCodeDialog(context);
//       },
//     );
//   }
//
//   Dialog _buildCountryCodeDialog(BuildContext context) {
//     return Dialog(
//       insetPadding: EdgeInsets.zero,
//       backgroundColor: Colors.transparent,
//       child: StatefulBuilder(
//         builder: (BuildContext context, StateSetter newState) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Container(
//               decoration: CustomDecorations().baseBackgroundDecoration(
//                   5.0, 1.0, const Color(0xFFFBFBFB), Colors.transparent),
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 2.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     _countrySearchField(context, newState),
//                     _countryList(context, newState),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Container _countrySearchField(BuildContext context, StateSetter newState) {
//     return Container(
//       decoration: CustomDecorations().baseBackgroundDecoration(
//           5.0, 1.0, const Color(0xFFFBFBFB), Colors.transparent),
//       // BoxDecoration(color: const Color(0xFFFBFBFB), borderRadius: BorderRadius.circular(5)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
//         child: Row(
//           children: [
//             SvgPicture.asset(
//               'assets/search.svg',
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: TextField(
//                 controller: country,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Search for countries',
//                   hintStyle: GoogleFonts.plusJakartaSans(
//                       fontSize: 14, color: const Color(0xFF828282)),
//                 ),
//                 onChanged: (val) async {
//                   filterList.clear();
//                   if (val.isNotEmpty) {
//                     filterList = countrylisttt
//                         .where((element) =>
//                     element.dial_code.contains(val) ||
//                         element.name
//                             .toLowerCase()
//                             .contains(val.toLowerCase()) ||
//                         element.code.contains(val))
//                         .toList();
//                   } else {
//                     filterList = List.from(countrylisttt);
//                   }
//                   newState(() {
//                     // shouldAutoFocus = true;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Container _countryList(BuildContext context, StateSetter newState) {
//     return Container(
//       height: 250,
//       color: const Color(0xFFFBFBFB),
//       // width: MediaQuery.of(context).size.width / 1.2,
//       child: ListView.builder(
//         itemCount: filterList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             behavior: HitTestBehavior.translucent,
//             onTap: () async {
//
//               if(!contactValidator && !firstNameValidator && !lastNameValidator) {
//                 saveActive = true;
//               }else {
//                 saveActive = false;
//               }
//               setState(() {
//                 countryCode = filterList[index].dial_code;
//               });
//               Navigator.pop(context);
//               country.clear();
//               filterList = List.from(countrylisttt);
//
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 1),
//               child: Container(
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 12.0, vertical: 12),
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 24,
//                         height: 24,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(1000),
//                           child: CachedNetworkSVGImage(
//                             'https://country-code-au6g.vercel.app/${filterList[index].image}',
//                             placeholder: const CustomSingleLineShimmer(
//                               height: 20,
//                               width: 20,
//                             ),
//                             errorWidget:
//                             const Icon(Icons.error, color: Colors.red),
//                             width: 20.0,
//                             height: 20.0,
//                             fit: BoxFit.cover,
//                             fadeDuration: const Duration(milliseconds: 500),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 3,
//                         child: Text(
//                           filterList[index].name,
//                           overflow: TextOverflow.ellipsis,
//                           style:
//                           GoogleFonts.plusJakartaSans(color: Colors.black),
//                         ),
//                       ),
//                       const Spacer(),
//                       Text(filterList[index].dial_code,
//                           style:
//                           GoogleFonts.plusJakartaSans(color: Colors.black)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   //-----------------Error Message----------------------
//   Widget _validationMessage(bool isVisible, String message) {
//     return isVisible?
//     Padding(
//       padding: const EdgeInsets.only(left: 5.0),
//       child: Row(
//         children: [
//           Text(
//             message,
//             style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w400, fontSize: 11, color: Colors.red),
//           ),
//         ],
//       ),
//     )
//         : Container();
//   }
// //--------------------------------------------------
//
// }