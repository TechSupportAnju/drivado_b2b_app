import 'dart:async';
import 'package:drivado_b2b_app/models/place_suggestion/place_suggestion.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/create_booking/repositotry/select_location_place_api.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_booking_page.dart';

class SelectLocationPage extends StatefulWidget {
  final bool isOneway;
  const SelectLocationPage({super.key, required this.isOneway});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  Timer? _debounce;
  Position? currentPosition;
  String? currentAddress;
  List state = [];

  @override
  void initState() {
    super.initState();
    if (widget.isOneway) {
      if (isSelectPickup) {
        _searchController = TextEditingController(text: fromController.text);
      } else {
        _searchController = TextEditingController(text: toController.text);
      }
    } else {
      _searchController =
          TextEditingController(text: hourlyFromController.text);
    }
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(microseconds: 300), () async {
      if (query.isNotEmpty && query.length > 2) {
        state = await fetchPlaces(query);
        setState(() {});
      } else {
       state = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Color(0xffffffff),
      elevation: 0.0,
      shadowColor: Color(0xFFD9D9D9),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Icon(
            Icons.keyboard_backspace,
            color: Color(0xFF555555),
          ),
        )
      ),
      title: CustomText(
        title: isSelectPickup ? 'Pickup Location' : 'Drop Location',
        color: Color(0xFF101010),
        fontWeight: FontWeight.w500,
        fontSize: 16
      ),
    ),
    body: searchLocation()
    );
  }

  Widget searchLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 1),
      child: Column(
        children: [
          Container(
            height: 48,
            decoration: ShapeDecoration(
              color: Color(0xFFF9F9F9),
              shape: SmoothRectangleBorder(
                side: const BorderSide(color: Color(0xFFEAEAEA)),
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 12,
                  cornerSmoothing: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SvgPicture.asset('assets/create_booking/search.svg',
                    colorFilter: const ColorFilter.mode(
                        Color(0xFFB2B2B2), BlendMode.srcIn
                    )
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (query) {
                      _onSearchChanged(query);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.plusJakartaSans(
                        color: Color(0xFFB2B2B2),
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                      ),
                      hintText: 'Enter ${isSelectPickup ? 'pickup' : 'drop off'} location',
                    ),
                  ),
                ),
                _searchController.text != ''?
                GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SvgPicture.asset('assets/create_booking/wrong.svg'),
                  )
                ) : Container(),
              ],
            ),
          ),
          _searchController.text.isEmpty
          ? Container()
          : Expanded(
            child: ListView.separated(
              itemCount: state.length,
              separatorBuilder: (context, pos) => const Padding(
                padding: EdgeInsets.only(left: 45),
                child: Divider(
                  color: Color(0xffE6E8E7),
                ),
              ),
              itemBuilder: (context, index) {
                final PlaceSuggestion place = state[index];
                return InkWell(
                  onTap: () async {
                    if (widget.isOneway) {
                      if (isSelectPickup) {
                        fromController.text = '${place.description}';
                      } else {
                        toController.text = '${place.description}';
                      }
                    } else {
                      hourlyFromController.text = '${place.description}';
                    }
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/create_booking/locate.svg'),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place.mainText ?? place.secondaryText ?? "No main text found",
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                place.description ?? "",
                                style: GoogleFonts.plusJakartaSans(
                                  color: Color(0XFF080808),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
