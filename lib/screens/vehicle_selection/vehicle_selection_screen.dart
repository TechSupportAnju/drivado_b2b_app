import 'dart:developer';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/passenger_detail/passenger_detail_screen.dart';
import 'package:drivado_b2b_app/screens/vehicle_selection/widget/custom_slider_button_widget.dart';
import 'package:drivado_b2b_app/screens/vehicle_selection/widget/elipse_widget.dart';
import 'package:drivado_b2b_app/screens/vehicle_selection/widget/inclusion_detail_widget.dart';
import 'package:drivado_b2b_app/screens/vehicle_selection/widget/max_data.dart';
import 'package:drivado_b2b_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common_widgets/custom_decoration.dart';
import '../create_booking/widgets/car_card_widget.dart';

class VehicleSelectionPage extends StatefulWidget {
  final vehiclesList;
  final selectedVehicle;
  final int? index;
  final bool isTapOneway;
  final bool? isLogin;
  final String? bookingSearchId;
  // final SearchIdRequestModel? searchIdRequesteModel;
  // final HourlySearchIdRequestModel? hourlySearchIdRequestModel;
  const VehicleSelectionPage({
    required this.vehiclesList,
    required this.selectedVehicle,
    required this.index,
    required this.isTapOneway,
    this.isLogin,
    this.bookingSearchId,
    // this.searchIdRequesteModel,
    // this.hourlySearchIdRequestModel,
    super.key,
  });

  @override
  State<VehicleSelectionPage> createState() => _VehicleSelectionPageState();
}

class _VehicleSelectionPageState extends State<VehicleSelectionPage> with TickerProviderStateMixin{

  final DraggableScrollableController draggableSheetController = DraggableScrollableController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  BuildContext? draggableSheetContext;
  static const double minExtent = 0.4;
  bool isExpanded = false;
  late var vehicleWithPrice;
  double initialExtent = minExtent;


  final double initialChildSize = 0.4;
  final double minChildSize = 0.4;
  final double maxChildSize = 1.0;


  bool isList = true;
  //List<NewOnewayVehicleWithPrice> carsData = [];

  void _swapItemToEnd(int index) {
    final removedItem = widget.vehiclesList[index];
    widget.vehiclesList.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => _buildAnimatedCard(removedItem, animation),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        widget.vehiclesList.add(removedItem);
        _listKey.currentState?.insertItem(widget.vehiclesList.length - 1);

        // Update selectedCarIndex to point to the last item
        selectedCarIndex = widget.vehiclesList.length - 1;
      });
    });
  }


  String formatDuration(String durationInSeconds) {
    double? seconds = double.tryParse(durationInSeconds);

    if (seconds == null || seconds < 0) {
      return 'Invalid Duration';
    }
    Duration duration = Duration(seconds: seconds.floor());

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);

    if (hours > 0 && minutes > 0) {
      return '$hours hr $minutes min';
    } else if (hours > 0 && minutes == 0){
      return '$hours hr';
    }
    else if (hours > 0 && minutes == 0) {
      return '$hours hr';
    } else if (hours == 0 && minutes > 0) {
      return '$minutes min';
    } else {
      return '0 min';
    }
  }



  Widget _buildAnimatedCard(carDetailData, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).chain(CurveTween(curve: Curves.easeInOut)),
      ),
      child: FadeTransition(
        opacity: animation,
        child: CarDetail(
          carDetailData: carDetailData,
          isSelected: false,
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    //widget.vehiclesList ?? [];
    vehicleWithPrice = widget.selectedVehicle;
    _swapItemToEnd(widget.index ?? 0);
    //searchId = widget.data.searchId.toString();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _animateToMinSize();
    // });
  }

  String oneDecimalFromString(String km) {
    final v = double.tryParse(km);
    return v?.toStringAsFixed(1) ?? km;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //To make the screen responsive
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/vehicle/mask.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xFF311213),
            Color(0xFF8B363D),
            Color(0xFFBD3A46),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1,0.7,1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.055),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
              child: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Color(0xFFE6E8E7),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: FittedBox(
                fit: BoxFit.scaleDown,
                child: InkWell(
                  onTap: () {
                    log(((widget.selectedVehicle['price']).toString()));
                  },
                  child: const CustomText(
                    title:  "Choose a vehicle",
                    fontWeight: FontWeight.w500,
                    color:Color(0xFFFFFFFF),
                    //fontSize: screenWidth * 0.05
                    fontSize: 20,
                  ),
                )
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.loose,
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Center(
                  heightFactor: screenHeight * 0.001,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween(begin: 0.95, end: 1.0).animate(animation),
                        child: child,
                      ),
                    ),
                    child: EllipseWidget(
                      key: ValueKey(vehicleWithPrice['image'] ?? 'no-image'),
                      imagePath: vehicleWithPrice['image'] ?? "No Image found",
                      onTap: () => setState(() {}),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: screenWidth * 0.38,
              right: screenWidth * 0.38,
              top: screenHeight * 0.24,
              child:
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return Center(
                        child: Material(
                          elevation: 0.0,
                          type: MaterialType.transparency,
                          child: AlertDialog(
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            insetPadding: const EdgeInsets.symmetric(horizontal: 17.0),
                            content: const InclusionDetailWidget(),
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
                child: Container(
                  height: screenHeight * 0.5,
                  width: screenWidth * 0.09,
                  decoration: CustomDecorations().baseBackgroundDecoration(
                    14.0,
                    1.0,
                    Colors.white,
                    Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: CustomText(title: "Inclusion",
                      textAlign: TextAlign.center,
                      fontSize: screenHeight * 0.015,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF190C0C),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.27,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.8,
                decoration: CustomDecorations().baseBackgroundDecoration(
                  35.0,
                  1.0,
                  Color(0xFF190C0C),
                  Colors.transparent,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomText(title: vehicleWithPrice['vehicleType'] ?? "No data found",
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: screenHeight * 0.02,
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.025,
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.005),
                            decoration: ShapeDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(title: "30 km",
                                  //"${newOnewayVehicleKm ?? "No data found"} km",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenHeight * 0.014,
                                ),

                                SizedBox(width: screenWidth * 0.015),
                                Icon(
                                  Icons.circle,
                                  size: screenHeight * 0.009,
                                  color: Colors.white,
                                ),
                                SizedBox(width: screenWidth * 0.015),
                                CustomText(title: "2 hr",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize:  screenHeight * 0.014,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.0015),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: SizedBox(
                          width: screenWidth,
                          height: screenHeight * 0.06,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicleWithPrice['description'] ?? "No data found",
                                style: GoogleFonts.plusJakartaSans(
                                  color: Color(0xFFABABAB),
                                  fontWeight: FontWeight.w500,
                                  fontSize:  screenHeight * 0.018,
                                  height: 1.4,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              maxDataTab(
                                "assets/vehicle/passenger_icon.svg",
                                'Max. ${vehicleWithPrice['passengerCount']}',
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              maxDataTab(
                                "assets/vehicle/luggage_icon.svg",
                                'Max. ${vehicleWithPrice['luggageCount']}',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomText(
                                title: "Price: ",
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight * 0.02,
                                color: Color(0xFF9C7171),
                                letterSpacing: -0.60,
                              ),
                              InkWell(
                                onTap: () {
                                },
                                child: CustomText(
                                  title: "${vehicleWithPrice['price']} ${vehicleWithPrice['unit']}",
                                  color: const Color(0xFFE6E8E7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight * 0.024,
                                  letterSpacing: -0.60,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: CustomSliderButton(onActionCompleted: navigateToPassengerDetails),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                    ],
                  ),
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.4,
              maxChildSize: 1.0,
              snap: true,
              controller: draggableSheetController,
              builder: (BuildContext ct, ScrollController scrollController) {
                return Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: CustomDecorations().draggableSheetDecoration(30.0, 30.0, 0.0, 0.0, 1.0, Colors.white, Colors.white),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 5),
                          child: Container(
                            width: screenWidth * 0.2 ,
                            height: 5,
                            decoration: BoxDecoration(
                              color: const Color(0xFF818181).withOpacity(0.25),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AnimatedList(
                            key: _listKey,
                            controller: scrollController,
                            initialItemCount: widget.vehiclesList?.length ?? 0,
                            itemBuilder: (ct, index, animation) {
                              final list = (widget.vehiclesList ?? const []);

                              if (index < 0 || index >= list.length) {
                                // Extra safety: AnimatedList shouldn't call us with bad indices,
                                // but bail out if it does.
                                return const SizedBox.shrink();
                              }

                              //final car = list[index];
                              return InkWell(
                                onTap:index == selectedCarIndex ? (){} : (){
                                  vehicleWithPrice = widget.isTapOneway? list[index] : list[index];
                                  setState(() {});
                                  _swapItemToEnd(index);
                                  _buildAnimatedCard(widget.vehiclesList![index], animation);
                                  draggableSheetController.animateTo(minChildSize, duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,);
                                },
                                child: CarDetail(carDetailData: widget.isTapOneway? widget.vehiclesList[index] : widget.vehiclesList![index],
                                    isSelected: index == selectedCarIndex),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  void navigateToPassengerDetails() {
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => PassengerDetailsPage(
          selectedVehicle: vehicleWithPrice,
          isTapOneway: widget.isTapOneway,
          bookingSearchId: widget.bookingSearchId,
        ),
      ),
    );
  }
}


