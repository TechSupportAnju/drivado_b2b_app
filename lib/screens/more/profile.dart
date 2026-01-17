// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'widgets/account_widget.dart';
//
// class MorePage extends StatefulWidget {
//   const MorePage({super.key});
//
//   @override
//   State<MorePage> createState() => _MorePageState();
// }
//
// class _MorePageState extends State<MorePage> {
//
//   var isLoad = true;
//   String? name;
//   String? email;
//
//   @override
//   void initState() {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     final double screenHeight = screenSize.height;
//     final double screenWidth = screenSize.width;
//
//     return  Container(
//       color: AppColors.adminUserMangBgColor,
//       width: screenWidth,
//       height: screenHeight,
//       child: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//             ),
//             alignment: Alignment.topLeft,
//             child: SafeArea(
//               child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 20.0, right: 20, top: 40, bottom: 13),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         CustomText(title: 'Profile',
//                             color: AppColors.manageBookingAdminbookedbyTitleTextColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: screenWidth >= 650 ? 28 : 24),
//                       ]
//                   )
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage()));
//                     context.read<ProfileBloc>().add(
//                         ProfileDetails()
//                     );
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(16),
//                     decoration: CustomDecorations().baseBackgroundDecoration(16.0, 1.0, Colors.white, Colors.white),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: screenWidth >= 650 ? 68 : 48,
//                           height: screenWidth >= 650 ? 68 : 48,
//                           decoration: BoxDecoration(
//                             // image: DecorationImage(
//                             //   image: SvgPicture.asset("assets/profile/profile_circle_icon.svg"),
//                             // ),
//                             borderRadius: BorderRadius.circular(100),
//                             border: Border.all(
//                                 color: Colors.white, width: 1.5),
//                           ),
//                           //padding: const EdgeInsets.all(0),
//                           alignment: Alignment.center,
//                           child: SvgPicture.asset("assets/profile/profile_circle_icon.svg"),
//                         ),
//                         const SizedBox(width: 16),
//                         isLoad
//                             ? Column(
//                           children: [
//                             CustomSingleLineShimmer(),
//                             const SizedBox(height: 3),
//                             CustomSingleLineShimmer(),
//                           ],
//                         )
//                             : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             AccountInfoWidget(
//                                 text: name ?? 'Not Found',
//                                 style: GoogleFonts.plusJakartaSans(
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.manageBookingAdminbookedbyTitleTextColor,
//                                   fontSize: screenWidth >= 650 ? 22 : 16,
//                                 )),
//                             const SizedBox(height: 3),
//                             AccountInfoWidget(
//                               text: '$email',
//                               style: GoogleFonts.plusJakartaSans(
//                                   fontWeight: FontWeight.w400,
//                                   color: AppColors.manageBookingbokkedByTextColor,
//                                   fontSize: screenWidth >= 650 ? 22 : 12),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: CustomDecorations().baseBackgroundDecoration(16.0, 1.0, Colors.white, Colors.white),
//                   child: Column(
//                     children: [
//                       AccountPageHeader(
//                         text: 'Account Setting',
//                         image: 'assets/profile/sett.svg',
//                         route: AccountSettingPage(),
//                       ),
//                       SizedBox(height: 20,),
//                       AccountPageHeader(
//                         text: 'Terms & Conditions',
//                         image: 'assets/profile/t&c.svg',
//                         route: TermsAndConditionPage(),
//                       ),
//                       SizedBox(height: 20,),
//                       const AccountPageHeader(
//                         text: 'Privacy Policy',
//                         image: 'assets/profile/privacy.svg',
//                         route: PrivacyPolicyPage(),
//                       ),
//                       SizedBox(height: 20,),
//                       AccountPageHeader(
//                         text: 'FAQ\'S',
//                         image: 'assets/profile/faq.svg',
//                         route: FaqPage(),
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: CustomDecorations().baseBackgroundDecoration(16.0, 1.0, Colors.white, Colors.white),
//                   child: Column(
//                     children: [
//                       const AccountPageHeader(
//                         text: 'Logout',
//                         image: 'assets/profile/logout.svg',
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
