import 'package:drivado_b2b_app/models/vehicle_model.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CarDetail extends StatefulWidget {
  final NewOnewayVehicleWithPrice? carDetailData;
  final bool isSelected;
  const CarDetail({super.key, required this.carDetailData, required this.isSelected});
  @override
  State<CarDetail> createState() => _CarDetailState();
}
class _CarDetailState extends State<CarDetail> {

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Padding(
      padding: const EdgeInsets.only(top:8, left: 12, right: 12, bottom: 8),
      child: Container(
        decoration: CustomCardDecorations().baseBackgroundCardDecoration(
          radius: 16.0,
          smooth: 1.0,
          isSelected: widget.isSelected,
          selectedGradientStart: const Color(0xFF190C0C),
          selectedGradientEnd: const Color(0xFF85252F),
          unselectedColor: const Color(0xFFF7F7F7),
          borderColor: const Color(0xFFD3D3D3),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 12, bottom: 12, right: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: widget.carDetailData?.vehicleType ?? 'Data not found',
                      fontSize: screenHeight * 0.025,
                      fontWeight: FontWeight.bold,
                      color: widget.isSelected? Color(0xffffffff) : const Color(0xFF002A48),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    CustomText(
                        title: widget.carDetailData?.description ?? 'Data not found',
                        color: widget.isSelected? Color(0xffffffff) : const Color(0xFF6A6A6A),
                        fontSize: screenHeight * 0.016,
                        fontWeight: FontWeight.w500,
                        height: 1.4
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      children: [
                        _maxData(
                            ("assets/cars/passenger_icon.svg"),
                            'Max. ${widget.carDetailData?.passengerCount ?? ''}', widget.isSelected ? Color(0xffffffff) : const Color(0xFF3A434C),
                            widget.isSelected? const Color(0xFF1A2126) : Color(0xffffffff),
                            fontWeight : FontWeight.w500
                        ),
                        SizedBox(width: screenWidth * 0.015),
                        _maxData(
                            ("assets/cars/luggage_icon.svg"),
                            'Max. ${widget.carDetailData?.luggageCount ?? ''}', widget.isSelected? Color(0xffffffff) : const Color(0xFF3A434C),
                            widget.isSelected? const Color(0xFF1A2126) : Color(0xffffffff),
                            fontWeight : FontWeight.w500
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.network(
                        widget.carDetailData?.image ?? 'assets/images/default_car_image.png',
                        alignment: Alignment.centerRight,
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.3,
                        fit: BoxFit.contain,
                        // loadingBuilder: (context, child, loadingProgress) {
                        //   if (loadingProgress == null) {
                        //     return child;
                        //   }
                        //   return CustomSingleLineShimmer(
                        //     width: screenWidth * 0.3,
                        //     height: screenHeight * 0.07,
                        //   );
                        // },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported, size: 80, color: Colors.grey);
                        },
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      CustomText(
                        title: "${widget.carDetailData?.unit ?? ""} ${widget.carDetailData?.price.ceil() ?? ""}",
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.bold,
                        color: widget.isSelected? Color(0xffffffff) : const Color(0xFFFB4156),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _maxData(String imageIcon, String label, Color color, Color textColor,{required FontWeight fontWeight}) {
    return Container(
      padding: const EdgeInsets.only(top: 2,left: 2,right: 5, bottom: 2),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imageIcon,
            height: 18,
            width: 18,
            fit: BoxFit.fill,
            placeholderBuilder: (BuildContext context) => const Icon(
              Icons.error_outline,
              size: 16,
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Text(label,
              style: GoogleFonts.plusJakartaSans(
                color: textColor,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
