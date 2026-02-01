import 'dart:developer';
import 'package:drivado_b2b_app/screens/booking_recipet/widget/clipper_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/create_booking/create_booking_page.dart';
import 'package:drivado_b2b_app/screens/home/home_screens/home_page.dart';
import 'package:drivado_b2b_app/screens/home/home_widget/bottom_nav_items.dart';
import 'package:drivado_b2b_app/screens/passenger_detail/widget/custom_top_progress_bar.dart';
import 'package:drivado_b2b_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingReceiptPage extends StatefulWidget {
  final bool isTapOneway;
  final bool? isLogin;
  final vehicleWithPrice;
  final String? countryCode;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? flightNo;
  final String? splReq;
  const BookingReceiptPage({
    required this.isTapOneway,
    this.isLogin,
    this.countryCode,
    this.phoneNumber,
    this.email,
    this.name,
    this.flightNo,
    this.splReq,
    this.vehicleWithPrice,
    super.key});

  @override
  State<BookingReceiptPage> createState() => _BookingReceiptPageState();
}

class _BookingReceiptPageState extends State<BookingReceiptPage> {
  bool isCongressText = true;

  @override
  void initState() {
    super.initState();
    changeView();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  changeView() async{
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isCongressText = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: isCongressText ? Colors.white : Color(0xffE6E8E7),
        appBar: isCongressText
            ? null : AppBar(
          backgroundColor: Color(0xffffffff),
          elevation: 0.0,
          shadowColor: Color(0xFFD9D9D9),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16,),
              GestureDetector(
                onTap: () {
                  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          RootShell()
                      ), (Route<dynamic> route) => false);
                },
                child:
                SvgPicture.asset('assets/booking_recipet/backhome.svg',),
              ),
              const Spacer(),
              InkWell(
                  onTap: () {
                    log(widget.vehicleWithPrice!.price.toString());
                  },
                  child: const CustomText(title: 'Booking Receipt', color: Color(0xFF101010), fontWeight: FontWeight.w600, fontSize: 20)),
              const Spacer(),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () async{
                },
                child: SvgPicture.asset('assets/booking_recipet/pdf.svg',)
              ),
            ],
          ),
        ),
        body: isCongressText?
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/booking_recipet/congress.gif', height: 230, width: 230),
              const SizedBox(height: 30,),
              const CustomText(title: 'Congratulations', color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
              const SizedBox(height: 7,),
              const CustomText(title: 'Your ride is booked', color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12)
            ],
          ),
        )
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              CustomTopProgressBar(tabCount: topProgressBarIndex, isActive: false,),
              const SizedBox(height: 20,),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTicket(isTapOneway: widget.isTapOneway,countryCode: widget.countryCode),
                        const SizedBox(height: 15,),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      RootShell()
                                  ), (Route<dynamic> route) => false);
                            },
                            child: const CustomText(title: 'Back to Home Page', color: Color(0xff595959), fontWeight: FontWeight.w600, fontSize: 14)
                        ),
                        const SizedBox(height: 35,),

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}