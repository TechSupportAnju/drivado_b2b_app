import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:drivado_b2b_app/models/currency/currency_data.dart';
import 'package:drivado_b2b_app/models/currency/currency_model.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/common_widgets/notification_widget.dart';
import 'package:drivado_b2b_app/screens/create_booking/select_location.dart';
import 'package:drivado_b2b_app/screens/create_booking/widgets/ride_type_options.dart';
import 'package:drivado_b2b_app/screens/create_booking/widgets/show_draggable_sheet_widget.dart';
import 'package:drivado_b2b_app/screens/create_booking/widgets/show_error_required_field_widget.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CreateBookingPage extends StatefulWidget {
  const CreateBookingPage({super.key});

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}
TextEditingController hourlyFromController = TextEditingController();
TextEditingController fromController = TextEditingController();
TextEditingController toController = TextEditingController();
var isSelectPickup = true;

class _CreateBookingPageState extends State<CreateBookingPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  RideType selectedType = RideType.airport;
  var isTapOneway = 0;

  var noOfPassenger = 1;

  int passengerCount = 1;

  String? currency;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xff190C0C),
                image: DecorationImage(
                  image: AssetImage('assets/create_booking/mask.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 40),
              child: Row(
                children: [
                  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width/1.4,
                                child: CustomText(
                                  title: 'Good Morning',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width/1.4,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Let’s Explore ',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'World',
                                        style:
                                        GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width/1.4,
                                child: CustomText(
                                  title: 'With Us',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  const Spacer(),
                  notificationWidget()
                ],
              ),
            ),
            Positioned(
              top: 200,
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: CustomDecorations().baseBackgroundDecoration(25.0, 1.0, Colors.white, Colors.transparent,),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      RideTypeSelector(
                        initial: selectedType,
                        onChanged: (value) {
                          setState(() {
                           if(value == RideType.hourly) {
                             isTapOneway = 1;
                           } else {
                             isTapOneway = 0;
                           }
                          });
                        },
                      ),
                      SizedBox(height: 24),
                      isTapOneway == 0
                          ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 128,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 21,
                              right: 21,
                              top: 2,
                              child: CustomTextField(
                                readOnly: true,
                                title: 'From',
                                hintText: 'Enter your pickup location',
                                icon: 'assets/create_booking/location_icon.svg',
                                astric: true,
                                controller: fromController,
                                height: 52.0,
                                width: MediaQuery.of(context,).size.width / 1.13,
                                onTap: () async {
                                  isSelectPickup = true;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                      const SelectLocationPage(
                                        isOneway: true,
                                      ),
                                    ),
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                onChanged: (val) async {
                                },
                                suffix: false, isPassword: false,
                              ),
                            ),
                            Positioned(
                              top: 74,
                              left: 21,
                              right: 21,
                              bottom: 2,
                              child: CustomTextField(
                                readOnly: true,
                                title: 'To',
                                hintText: 'Enter your drop off location',
                                icon: 'assets/create_booking/location_icon.svg',
                                astric: true,
                                controller: toController,
                                height: 52.0,
                                width: MediaQuery.of(context,).size.width / 1.13,
                                onTap: () {
                                  isSelectPickup = false;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                      const SelectLocationPage(
                                        isOneway: true,
                                      ),
                                    ),
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                onChanged: (val) {
                                },
                                suffix: false, isPassword: false,
                              ),
                            ),
                          ],
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 21.0,
                          vertical: 2,
                        ),
                        child: Column(
                          children: [
                              CustomTextField(
                                readOnly: true,
                                title: 'From',
                                hintText: 'Enter your pickup location',
                                icon: 'assets/create_booking/location_icon.svg',
                                controller: hourlyFromController,
                                height: 52.0,
                                astric: true,
                                width: MediaQuery.of(context).size.width,
                                onTap: () {
                                  isSelectPickup = true;
                                  Navigator.push(context,
                                    MaterialPageRoute( builder:
                                          (context) =>
                                              const SelectLocationPage(
                                                isOneway: false,),
                                    ),
                                  ).then((_) async {
                                    durationController.clear();
                                    setState(() {});
                                  });
                                },
                                onChanged: (val) {},
                                suffix: false, isPassword: false,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              readOnly: true,
                              title: 'Duration',
                              hintText: 'Select Duration',
                              icon: 'assets/create_booking/hourly_duration.svg',
                              controller: durationController,
                              astric: true,
                              height: 52.0,
                              width: MediaQuery.of(context).size.width,
                              onTap: () {
                                showGeneralDialog(
                                  useRootNavigator: false,
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                  transitionDuration: const Duration(milliseconds: 300),
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return Dialog(
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      child: PopScope(
                                        canPop: true,
                                        onPopInvokedWithResult: (bool didPop, Object? result) async {
                                          setState(() {});
                                        },
                                        child: StatefulBuilder(
                                          builder: (context, newState) {
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 0),
                                              child: Container(
                                                height: 300,
                                                decoration: CustomDecorations().baseBackgroundDecoration(
                                                    15.0, 1.0, Colors.white, Colors.transparent),
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                      },
                                                      child:  Padding(
                                                        padding: EdgeInsets.only(
                                                            left: 20.0, right: 20, top: 15, bottom: 5),
                                                        child: Row(
                                                          children: [
                                                            CustomText(
                                                              title: 'Select Duration',
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 16,
                                                            ),
                                                            Spacer(),
                                                            Icon(
                                                              Icons.keyboard_arrow_up_sharp,
                                                              color: Color(0xFFF7FAFF),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(
                                                      height: 1,
                                                      color: Color(0xFFF2F2F2),
                                                      thickness: 1,
                                                    ),
                                                    Expanded(
                                                      child: ListView.builder(
                                                        padding: const EdgeInsets.only(top: 10),
                                                        itemCount: 8,
                                                        itemBuilder: (context, index) {
                                                          final text = '3 Hour / 60 Km';
                                                          return GestureDetector(
                                                            onTap: () {
                                                              durationController.text = text;
                                                              setState(() {});
                                                              Navigator.pop(context);
                                                            },
                                                            child:
                                                            Material(
                                                              color: Colors.transparent,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  durationController.text = text;
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Container(
                                                                  width: double.infinity,
                                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                        child: Row(
                                                                          children: [
                                                                            CustomText(
                                                                              title: text,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 14,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const Divider(
                                                                        color: Color(0xFFF7FAFF),
                                                                        thickness: 1,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  transitionBuilder: (context, animation, secondaryAnimation, child) {
                                    final curve = Curves.easeInOut.transform(animation.value);
                                    return Transform.scale(
                                      scale: curve,
                                      child: child,
                                    );
                                  },
                                );
                              },
                              onChanged: (val) {},
                              suffix: true, isPassword: false, isExpand: true,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 21.0,
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomTextField(
                                readOnly: true,
                                title: 'Date',
                                hintText: 'Date',
                                icon: 'assets/create_booking/calendar.svg',
                                astric: true,
                                controller: dateController,
                                height: 52.0,
                                width: MediaQuery.of(context,).size.width * 0.42,
                                onTap: () async {
                                  DateTime? newSelectedDate =
                                  await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2040),
                                  );
                                  if (newSelectedDate != null) {
                                    String formattedPickupDate = DateFormat('dd-MMM-yyyy',).format(newSelectedDate);
                                    dateController.text = formattedPickupDate;
                                      setState(() {});
                                    }


                                },
                                onChanged: (val) {},
                                suffix: false, isPassword: false,
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              flex: 1,
                              child: CustomTextField(
                                readOnly: true,
                                title: 'Time',
                                hintText: 'Time',
                                icon:
                                'assets/create_booking/clock_icon.svg',
                                astric: true,
                                controller: timeController,
                                height: 52.0,
                                width:
                                MediaQuery.of(
                                  context,
                                ).size.width *
                                    0.42,
                                onTap: () async {
                                  final TimeOfDay initialTime = TimeOfDay.now();
                                  final picked = await showTimePicker(
                                    context: context,
                                    initialTime: initialTime,
                                  );
                                  if (picked != null) {
                                    final formattedTime =
                                        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

                                    setState(() {
                                      timeController.text =
                                          formattedTime;
                                    });
                                  }
                                },
                                onChanged: (val) {},
                                suffix: false, isPassword: false,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 21.0,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 60,
                                  width:
                                  MediaQuery.of(
                                    context,
                                  ).size.width /
                                      2.45,
                                  decoration: CustomDecorations()
                                      .baseBackgroundDecoration(
                                    10.0,
                                    1.0,
                                    Colors.transparent,
                                    Color(0xffE6E8E7),
                                  ),
                                  padding: const EdgeInsets.only(
                                    right: 16,
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    spacing: 10,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: SvgPicture.asset(
                                            "assets/create_booking/pax_icon.svg",
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                title: 'Passenger',
                                                color:
                                                AppColors
                                                    .textFieldTextColor,
                                                fontWeight:
                                                FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (noOfPassenger > 1) {
                                                    setState(() {
                                                      noOfPassenger = noOfPassenger - 1;
                                                      passengerCount = noOfPassenger;
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  height: 24,
                                                  width: 24,
                                                  decoration: BoxDecoration(
                                                    color: noOfPassenger != 1 ? AppColors.secondary : AppColors.secondary.withOpacity(0.2,),
                                                    borderRadius:
                                                    BorderRadius.circular(5,),
                                                  ),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              AnimatedFlipCounter(
                                                value: noOfPassenger,
                                                textStyle:
                                                GoogleFonts.plusJakartaSans(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              InkWell(
                                                onTap: () {
                                                  if (noOfPassenger < 5) {
                                                    setState(() {
                                                      noOfPassenger = noOfPassenger + 1;
                                                      passengerCount = noOfPassenger;
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  height: 24,
                                                  width: 24,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    noOfPassenger != 5 ? AppColors.secondary : AppColors.secondary.withOpacity(0.2,),
                                                    borderRadius: BorderRadius.circular(5,),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              // Spacer(),
                              Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  readOnly: true,
                                  title: 'Currency',
                                  hintText: 'Currency',
                                  icon:  'assets/create_booking/currency_icon.svg',
                                  astric: true,
                                  controller: currencyController,
                                  height: 60.0,
                                  width: MediaQuery.of(context).size.width / 2.45,
                                  onTap: () async {
                                    List<CurrencyModel> searchItem = [];
                                    TextEditingController search =
                                    TextEditingController();
                                    showGeneralDialog(
                                      useRootNavigator: false,
                                      context: context,
                                      barrierDismissible: true,
                                      barrierLabel:
                                      MaterialLocalizations.of(
                                        context,
                                      ).modalBarrierDismissLabel,
                                      transitionDuration:
                                      const Duration(
                                        milliseconds: 300,
                                      ),
                                      pageBuilder: (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                          ) {
                                        return Dialog(
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor:
                                          Colors.transparent,
                                          child: PopScope(
                                            canPop: true,
                                            onPopInvokedWithResult: (
                                                bool didPop,
                                                Object? result,
                                                ) async {
                                              setState(() {});
                                            },
                                            child: StatefulBuilder(
                                              builder: (
                                                  context,
                                                  newState,
                                                  ) {
                                                return Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20.0,
                                                    top: 0,
                                                    bottom: 20,
                                                  ),
                                                  child: Container(
                                                    height: 310.0,
                                                    decoration: CustomDecorations()
                                                        .baseBackgroundDecoration(
                                                      15.0,
                                                      1.0,
                                                      Colors.white,
                                                      Colors
                                                          .transparent,
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                      MainAxisSize
                                                          .min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                            left:
                                                            20.0,
                                                            right:
                                                            20,
                                                            top: 3,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  const SizedBox(
                                                                    height:
                                                                    5,
                                                                  ),
                                                                  SvgPicture.asset(
                                                                    'assets/create_booking/search.svg',
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                width:
                                                                15,
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                45,
                                                                width:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.width /
                                                                    1.53,
                                                                child: TextFormField(
                                                                  controller:
                                                                  search,
                                                                  cursorColor:
                                                                  Colors.black,
                                                                  cursorHeight:
                                                                  15,
                                                                  cursorWidth:
                                                                  1.5,
                                                                  style: GoogleFonts.plusJakartaSans(
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                    fontSize:
                                                                    16,
                                                                  ),
                                                                  decoration: InputDecoration(
                                                                    border:
                                                                    InputBorder.none,
                                                                    hintStyle: GoogleFonts.plusJakartaSans(
                                                                      color: Color(0xFF535353),
                                                                      fontWeight:
                                                                      FontWeight.w500,
                                                                      fontSize:
                                                                      16,
                                                                    ),
                                                                    hintText:
                                                                    'Search',
                                                                  ),
                                                                  onChanged: (
                                                                      val,
                                                                      ) {
                                                                    searchItem.clear();
                                                                    searchItem =
                                                                        currencyData
                                                                            .where(
                                                                              (
                                                                              element,
                                                                              ) => element.isoCode.toLowerCase().contains(
                                                                            val.toLowerCase(),
                                                                          ),
                                                                        )
                                                                            .toList();
                                                                    newState(
                                                                          () {},
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const Divider(
                                                          height: 1,
                                                          color: Color(0xFFF2F2F2),
                                                          thickness: 1,
                                                        ),
                                                        Expanded(
                                                          child: ListView.separated(
                                                            separatorBuilder:
                                                                (
                                                                context,
                                                                pos,
                                                                ) => const Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                horizontal:
                                                                8.0,
                                                              ),
                                                              child: Divider(
                                                                height: 1,
                                                                color: Color(0xFFF7FAFF),
                                                                thickness: 1,
                                                              ),
                                                            ),
                                                            shrinkWrap: true,
                                                            padding: const EdgeInsets.only(top: 0,),
                                                            itemCount:
                                                            search.text !=
                                                                ''
                                                                ? searchItem.length
                                                                : currencyData.length,
                                                            itemBuilder: (
                                                                BuildContext
                                                                context,
                                                                int index,
                                                                ) {
                                                              var value =
                                                              search.text !=
                                                                  ''
                                                                  ? searchItem[index]
                                                                  : currencyData[index];
                                                              return GestureDetector(
                                                                behavior:
                                                                HitTestBehavior.translucent,
                                                                onTap: () {
                                                                  currencyController = TextEditingController(
                                                                    text:
                                                                    value.isoCode,
                                                                  );
                                                                  Navigator.pop(context,);
                                                                  setState(() {
                                                                    currency = value.isoCode.toString();
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(
                                                                    left:
                                                                    20.0,
                                                                    right:
                                                                    20,
                                                                    bottom:
                                                                    18,
                                                                    top:
                                                                    20,
                                                                  ),
                                                                  child: Container(
                                                                    color:
                                                                    Colors.transparent,
                                                                    width:
                                                                    MediaQuery.of(
                                                                      context,
                                                                    ).size.width,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        CustomText(
                                                                          title:
                                                                          value.isoCode,
                                                                          color:
                                                                          Colors.black,
                                                                          fontWeight:
                                                                          FontWeight.w600,
                                                                          fontSize:
                                                                          16,
                                                                        ),
                                                                        CustomText(
                                                                          title:
                                                                          value.state,
                                                                          color: Color(0xFF535353),
                                                                          fontWeight:
                                                                          FontWeight.w400,
                                                                          fontSize:
                                                                          14,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      transitionBuilder: (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                          child,
                                          ) {
                                        // Apply a scaling transition
                                        final curve = Curves.easeInOut
                                            .transform(animation.value);
                                        return Transform.scale(
                                          scale: curve,
                                          child: child,
                                        );
                                      },
                                    );
                                  },
                                  onChanged: (val) {},
                                  suffix: true, isPassword: false, isExpand: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 21.0,
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (isTapOneway == 0) {
                              final invalid =
                                  fromController.text.isEmpty ||
                                      toController.text.isEmpty ||
                                      dateController
                                          .text
                                          .isEmpty ||
                                      timeController
                                          .text
                                          .isEmpty ||
                                      currencyController
                                          .text
                                          .isEmpty;
                              if (invalid) {
                                showRequiredFieldDialog(
                                  context,
                                );
                              } else {
                                print('showw thiss ===');
                                await showModalBottomSheet(
                                  backgroundColor:
                                  Colors.transparent,
                                  context: context,
                                  isScrollControlled: true,
                                  builder:
                                      (_) => DraggableSheetWidget(
                                    isTapOneway: true,
                                    bookingSearchId: '',
                                  ),
                                );
                              }
                            } else {
                              final invalid =
                                  hourlyFromController
                                      .text
                                      .isEmpty ||
                                      durationController
                                          .text
                                          .isEmpty ||
                                      dateController
                                          .text
                                          .isEmpty ||
                                      timeController
                                          .text
                                          .isEmpty ||
                                      currencyController
                                          .text
                                          .isEmpty;
                              if (invalid) {
                                showRequiredFieldDialog(context,
                                );
                              } else {
                                print('showw thiss ===');
                                await showModalBottomSheet(
                                  backgroundColor:
                                  Colors.transparent,
                                  context: context,
                                  isScrollControlled: true,
                                  builder:
                                      (_) => DraggableSheetWidget(
                                    isTapOneway: true,
                                    bookingSearchId: '',
                                  ),
                                );
                              }
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: CustomDecorations()
                                .baseBackgroundDecoration(
                              10.0,
                              1.0,
                              AppColors.secondary,
                              Colors.transparent,
                            ),
                            alignment: Alignment.center,
                            child:
                            const CustomText(
                              title: 'Search Vehicle',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  //error popup ----------------------
  showRequiredFieldDialog(context) {
    return showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowErrorRequiredFieldWidget();
      },
    );
  }
}

