import 'dart:developer';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/vehicle_selection/vehicle_selection_screen.dart';
import 'package:flutter/material.dart';

import 'car_card_widget.dart';

class DraggableSheetWidget extends StatefulWidget {
  final bool isTapOneway;
  final bool? isLogin;
  final String? bookingSearchId;
  const DraggableSheetWidget({required this.isTapOneway, this.isLogin, this.bookingSearchId, super.key});
  @override
  State<DraggableSheetWidget> createState() => _DraggableSheetWidgetState();
}

class _DraggableSheetWidgetState extends State<DraggableSheetWidget> with TickerProviderStateMixin{
  final DraggableScrollableController draggableSheetController = DraggableScrollableController();
  BuildContext? draggableSheetContext;
  static const double minExtent = 0.6;
  bool isExpanded = true;
  double initialExtent = minExtent;
  int selectedCarIndex = -1;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.9,
      maxChildSize: 0.9,
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return Material(
          color: Colors.transparent,
          child: Container(
            decoration: CustomDecorations().draggableSheetDecoration(
                30.0, 30.0, 0.0, 0.0, 1.0, Color(0xffffffff), Color(0xffffffff)),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    log(widget.bookingSearchId.toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF818181).withOpacity(0.25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      //child: CustomText(title: "hello", color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                if(widget.isTapOneway == true)
                  SearchVehicleList(isTapOneway: widget.isTapOneway, bookingSearchId: widget.bookingSearchId),
                if(widget.isTapOneway == false)
                  SearchVehicleList(isTapOneway: widget.isTapOneway, bookingSearchId: widget.bookingSearchId ?? "")
              ],
            ),
          ),
        );
      },
    );
  }
}

class SearchVehicleList extends StatefulWidget {
  final bool isTapOneway;
  final bool? isLogin;
  final String? bookingSearchId;
  const SearchVehicleList({
    super.key,
    required this.isTapOneway,
    this.isLogin,
    this.bookingSearchId
  });

  @override
  State<SearchVehicleList> createState() => _SearchVehicleListState();
}

class _SearchVehicleListState extends State<SearchVehicleList> {
  @override
  Widget build(BuildContext context) {
   var data =
     [
         {
       'id': '6426d46c7cfcc6b82fc1c23f',
         'vehicleName': 'Corolla',
         'vehicleType': 'STANDARD SEDAN',
         'description': 'Corolla, Toyota Prius,'' Camry, Ford Taurus, Maruti Dzire or similar',
         'price': '1436.16',
         'image': 'https://res.cloudinary.com/dspmukglv/image/upload/v1768486297/vehicleImages/oaecqxcvp4usgwcekkok.png',
         'vehicleId': '3d8e08cd-6ffc-457b-a59b-e99206e3f7e5', 'unit': 'INR',
         'passengeCount': '3', 'luggageCount': '2', 'priceInUSD': '16.8', 'currencyInUSD': 'USD'},
         {
       'id': '6426d46c7cfcc6b82fc1c23f',
         'vehicleName': 'Corolla',
         'vehicleType': 'STANDARD SEDAN',
         'description': 'Corolla, Toyota Prius,'' Camry, Ford Taurus, Maruti Dzire or similar',
         'price': '1436.16',
         'image': 'https://res.cloudinary.com/dspmukglv/image/upload/v1768486297/vehicleImages/oaecqxcvp4usgwcekkok.png',
         'vehicleId': '3d8e08cd-6ffc-457b-a59b-e99206e3f7e5', 'unit': 'INR',
         'passengeCount': '3', 'luggageCount': '2', 'priceInUSD': '16.8', 'currencyInUSD': 'USD'},
   ];
   final List activeList = data;

    return Expanded(
      child: ListView.builder(
        itemCount: activeList.length,
        itemBuilder: (context, index) {
          final car = activeList[index];
          return InkWell(
            child: CarDetail(carDetailData: car, isSelected: false),
            onTap: () async {
              if (index < 0 || index >= activeList.length) return;
              final bool isOneway = widget.isTapOneway;
              await Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => VehicleSelectionPage(
                    vehiclesList: activeList,
                    selectedVehicle: activeList[index],
                    index: index,
                    isTapOneway: isOneway,
                    isLogin: widget.isLogin ?? true,
                    bookingSearchId: widget.bookingSearchId,
                  ),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    return SlideTransition(position: animation.drive(tween), child: child);
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              ).whenComplete(() {
                if (mounted) setState(() {});
              });
            },
          );
        },
      ),
    );
  }
}

