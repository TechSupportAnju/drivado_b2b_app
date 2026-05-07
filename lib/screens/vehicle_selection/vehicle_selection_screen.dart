import 'dart:developer';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/passenger_detail/passenger_detail_screen.dart';
import 'package:drivado_b2b_app/screens/vehicle_selection/widget/custom_slider_button_widget.dart';
import 'package:drivado_b2b_app/screens/vehicle_selection/widget/elipse_widget.dart';
import 'package:drivado_b2b_app/screens/vehicle_selection/widget/inclusion_detail_widget.dart';
import 'package:drivado_b2b_app/screens/vehicle_selection/widget/max_data.dart';
import 'package:drivado_b2b_app/utils/constant.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common_widgets/custom_decoration.dart';
import 'widget/car_card_widget.dart';

class VehicleSelectionPage extends StatefulWidget {
  final vehiclesList;
  final selectedVehicle;
  final int? index;
  final bool isTapOneway;
  final bool? isLogin;
  final String? bookingSearchId;
  final String? routeDistanceKm;
  final String? routeDuration;
  final String? bookingCurrency;
  // final SearchIdRequestModel? searchIdRequesteModel;
  // final HourlySearchIdRequestModel? hourlySearchIdRequestModel;
  const VehicleSelectionPage({
    required this.vehiclesList,
    required this.selectedVehicle,
    required this.index,
    required this.isTapOneway,
    this.isLogin,
    this.bookingSearchId,
    this.routeDistanceKm,
    this.routeDuration,
    this.bookingCurrency,
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


  String formatDuration(String rawDuration) {
    final text = rawDuration.trim();
    if (text.isEmpty) return 'No data found';
    return text;
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

  String vehicleValue(String key) {
    final value = vehicleWithPrice[key];
    final text = value?.toString().trim() ?? '';
    return text.isEmpty ? 'No data found' : text;
  }

  String routeKmValue() {
    final direct = widget.routeDistanceKm?.trim() ?? '';
    if (direct.isNotEmpty && direct != '0') return direct;
    final fromVehicle = vehicleWithPrice['distanceKm']?.toString().trim() ?? '';
    return fromVehicle;
  }

  String routeDurationValue() {
    final direct = widget.routeDuration?.trim() ?? '';
    if (direct.isNotEmpty) return direct;
    return vehicleWithPrice['duration']?.toString().trim() ?? '';
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
            fit: BoxFit.contain,
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
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: const Icon(
                  Icons.keyboard_backspace,
                  size: 24,
                  color: Color(0xFFE6E8E7),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: InkWell(
                  onTap: () {
                    log(((widget.selectedVehicle['price']).toString()));
                  },
                  child: const CustomText(
                    title:  "Choose a vehicle class",
                    fontWeight: FontWeight.w600,
                    color:Color(0xFFFFFFFF),
                    //fontSize: screenWidth * 0.05
                    fontSize: 20,
                  ),
                )
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 15),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierColor: Color(0XFF000000).withOpacity(0.5),
                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return Center(
                          child: Material(
                            elevation: 0.0,
                            type: MaterialType.transparency,
                            color: Colors.transparent,
                            child: AlertDialog(
                              backgroundColor: Colors.white,
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
                  child: SvgPicture.asset("assets/vehicle/inclusion_icon.svg"),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.loose,
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.01),
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
              top: screenHeight * 0.24,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.8,
                decoration: CustomDecorations().baseBackgroundDecoration(
                  35.0,
                  1.0,
                  Color(0xFF0D0D0D),
                  Color(0xFF0D0D0D),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomText(title: vehicleWithPrice['vehicleType'] ?? "No data found",
                              color: Colors.white,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            // height: screenHeight * 0.025,
                            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                            decoration: ShapeDecoration(
                              color: Color(0XFFFB4156).withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(title: "${oneDecimalFromString(routeKmValue())} km",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  height: 1.4,

                                ),
                                SizedBox(width: 7),
                                Icon(
                                  Icons.circle,
                                  size: screenHeight * 0.009,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 7),
                                CustomText(title: formatDuration(routeDurationValue()),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      CustomText(
                        title: vehicleValue('description'),
                        maxLine: 2,
                          color: Color(0xFFABABAB),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.4,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              maxDataTab(
                                "assets/vehicle/passenger_icon.svg",
                                'Max. ${vehicleWithPrice['passengerCount'] ?? ''}',
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
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppColors.secondary,
                                height: 1,
                              ),
                              SizedBox(width: 10,),
                              CustomText(
                                title: "${vehicleWithPrice['price'] ?? ''} ${vehicleWithPrice['unit'] ?? ''}",
                                color: const Color(0xFFE6E8E7),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                // letterSpacing: -0.3,
                                height: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: CustomSliderButton(onActionCompleted: navigateToPassengerDetails),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.46,
              minChildSize: 0.46,
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
          routeDistanceKm: routeKmValue(),
          routeDuration: routeDurationValue(),
          bookingCurrency: widget.bookingCurrency,
        ),
      ),
    );
  }
}


