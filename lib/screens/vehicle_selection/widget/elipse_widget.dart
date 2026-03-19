import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EllipseWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const EllipseWidget({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    final double containerHeight = screenHeight * 0.1;
    final double carWidth = screenWidth * 0.8;
    final double carHeight = screenHeight * 0.22;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset("assets/vehicle/ellipse.svg",  fit: BoxFit.contain, width: carWidth,),
          Positioned(
            top: containerHeight * 0.2,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: containerHeight * 2,
                color: Colors.transparent,
                child: Image.network(
                  imagePath,
                  width: carWidth,
                  height: carHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}