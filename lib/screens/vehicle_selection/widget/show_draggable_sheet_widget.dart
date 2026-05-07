import 'dart:developer';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/vehicle_selection/vehicle_selection_screen.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/search_vehicle_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/search_vehicle_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/search_vehicle_state.dart';
import 'package:drivado_b2b_app/services/bookings/search_vehicle_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'car_card_widget.dart';

class DraggableSheetWidget extends StatefulWidget {
  final bool isTapOneway;
  final bool? isLogin;
  final String? bookingSearchId;
  final SearchVehicleRequest searchRequest;
  final String routeDistanceKm;
  final String routeDuration;
  final String bookingCurrency;
  const DraggableSheetWidget({
    required this.isTapOneway,
    required this.searchRequest,
    required this.routeDistanceKm,
    required this.routeDuration,
    required this.bookingCurrency,
    this.isLogin,
    this.bookingSearchId,
    super.key,
  });
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
        return BlocProvider(
          create:
              (_) => SearchVehicleBloc(
                repository: SearchVehicleRepository(),
              )..add(SearchVehicleRequested(widget.searchRequest)),
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: CustomDecorations().draggableSheetDecoration(
                30.0,
                30.0,
                0.0,
                0.0,
                1.0,
                Color(0xffffffff),
                Color(0xffffffff),
              ),
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
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  SearchVehicleList(
                    isTapOneway: widget.isTapOneway,
                    isLogin: widget.isLogin,
                    bookingSearchId: widget.bookingSearchId ?? '',
                    routeDistanceKm: widget.routeDistanceKm,
                    routeDuration: widget.routeDuration,
                    bookingCurrency: widget.bookingCurrency,
                  ),
                ],
              ),
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
  final String routeDistanceKm;
  final String routeDuration;
  final String bookingCurrency;
  const SearchVehicleList({
    super.key,
    required this.isTapOneway,
    required this.routeDistanceKm,
    required this.routeDuration,
    required this.bookingCurrency,
    this.isLogin,
    this.bookingSearchId
  });

  @override
  State<SearchVehicleList> createState() => _SearchVehicleListState();
}

class _SearchVehicleListState extends State<SearchVehicleList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchVehicleBloc, SearchVehicleState>(
        builder: (context, state) {
          if (state is SearchVehicleLoading || state is SearchVehicleInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SearchVehicleFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        final parent = context.findAncestorWidgetOfExactType<DraggableSheetWidget>();
                        if (parent == null) return;
                        context.read<SearchVehicleBloc>().add(
                          SearchVehicleRequested(parent.searchRequest),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is! SearchVehicleLoaded || state.vehicles.isEmpty) {
            return const Center(child: Text('No vehicles found.'));
          }

          final List activeList = state.vehicles;
          final effectiveSearchId =
              state.bookingSearchId.isNotEmpty
                  ? state.bookingSearchId
                  : (widget.bookingSearchId ?? '');
          final vehiclesWithRoute =
              activeList
                  .map<Map<String, dynamic>>(
                    (vehicle) => {
                      ...Map<String, dynamic>.from(vehicle as Map),
                      'distanceKm':
                          widget.routeDistanceKm.isNotEmpty
                              ? widget.routeDistanceKm
                              : vehicle['distanceKm'],
                      'duration':
                          widget.routeDuration.isNotEmpty
                              ? widget.routeDuration
                              : vehicle['duration'],
                    },
                  )
                  .toList();

          return ListView.builder(
            itemCount: vehiclesWithRoute.length,
            itemBuilder: (context, index) {
              final car = vehiclesWithRoute[index];
              return InkWell(
                child: CarDetail(carDetailData: car, isSelected: false),
                onTap: () async {
                  if (index < 0 || index >= vehiclesWithRoute.length) return;
                  final bool isOneway = widget.isTapOneway;
                  await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              VehicleSelectionPage(
                                vehiclesList: List<Map<String, dynamic>>.from(vehiclesWithRoute),
                                selectedVehicle: vehiclesWithRoute[index],
                                index: index,
                                isTapOneway: isOneway,
                                isLogin: widget.isLogin ?? true,
                                bookingSearchId: effectiveSearchId,
                                routeDistanceKm: widget.routeDistanceKm,
                                routeDuration: widget.routeDuration,
                                bookingCurrency: widget.bookingCurrency,
                              ),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;
                        final tween = Tween(
                          begin: begin,
                          end: end,
                        ).chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  ).whenComplete(() {
                    if (mounted) setState(() {});
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}

