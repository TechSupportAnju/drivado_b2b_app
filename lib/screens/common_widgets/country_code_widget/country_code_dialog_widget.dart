import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:drivado_b2b_app/models/country_code/country_code_data.dart';
import 'package:drivado_b2b_app/models/country_code/country_code_model.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


class CountryCodeDialogWidget extends StatefulWidget {
  const CountryCodeDialogWidget({super.key,});
  @override
  _CountryCodeDialogWidgetM createState() => _CountryCodeDialogWidgetM();
}

class _CountryCodeDialogWidgetM extends State<CountryCodeDialogWidget> {
  bool initialPosition = true;
  List countrtyList = [];
  List<CountryCodeModel> countrylisttt = [];
  TextEditingController country = TextEditingController();
  List<CountryCodeModel> filterList = [];

  Future<void> fetchCountryCode() async {
    countrtyList.clear();
    countrylisttt.clear();
    countrylisttt = countryCodeData;
    filterList = List.from(countrylisttt);
    if (countrylisttt.isNotEmpty) {
      for (var element in countrylisttt) {
        countrtyList.add(element.dialCode);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCountryCode();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter newState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: CustomDecorations().baseBackgroundDecoration(
                  5.0, 1.0, const Color(0xFFFBFBFB), Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _countrySearchField(context, newState),
                    _countryList(context, newState),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container _countrySearchField(BuildContext context, StateSetter newState) {
    return Container(
      decoration: CustomDecorations().baseBackgroundDecoration(
          5.0, 1.0, const Color(0xFFFBFBFB), Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/user_management/search.svg',
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: country,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for countries',
                  hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 14, color: const Color(0xFF828282)),
                ),
                onChanged: (val) async {
                  filterList.clear();
                  if (val.isNotEmpty) {
                    filterList = countrylisttt
                        .where((element) =>
                    element.dialCode.contains(val) ||
                        element.name
                            .toLowerCase()
                            .contains(val.toLowerCase()) ||
                        element.code.contains(val))
                        .toList();
                  } else {
                    filterList = List.from(countrylisttt);
                  }
                  newState(() {
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _countryList(BuildContext context, StateSetter newState) {
    return Container(
      height: 250,
      color: const Color(0xFFFBFBFB),
      child: ListView.builder(
        itemCount: filterList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              Navigator.pop(context);
              setState(() {
                countryCode = filterList[index].dialCode;
              });
              country.clear();
              filterList = List.from(countrylisttt);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 1),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: CachedNetworkSVGImage(
                            'https://country-code-au6g.vercel.app/${filterList[index].image}',
                            errorWidget: const Icon(Icons.error, color: Colors.red),
                            width: 20.0,
                            height: 20.0,
                            fit: BoxFit.cover,
                            fadeDuration: const Duration(milliseconds: 500),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          filterList[index].name,
                          overflow: TextOverflow.ellipsis,
                          style:
                          GoogleFonts.plusJakartaSans(color: Colors.black),
                        ),
                      ),
                      const Spacer(),
                      CustomText(title: filterList[index].dialCode,
                          fontWeight: FontWeight.w500, fontSize: 12,
                          color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
