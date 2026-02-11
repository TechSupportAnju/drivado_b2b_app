
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSliderButton extends StatefulWidget {
  final VoidCallback onActionCompleted;
  const CustomSliderButton({required this.onActionCompleted, super.key});

  @override
  _CustomSliderButtonState createState() => _CustomSliderButtonState();
}

class _CustomSliderButtonState extends State<CustomSliderButton> {
  double _dragPosition = 0.0;
  bool _actionCompleted = false;
  double _maxDragDistance = 0.0;
  double _buttonWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    // Obtain screen size
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double containerWidth = screenWidth * 0.9;
        final double containerHeight = screenHeight * 0.065;

        // Define button size relative to container height for consistency
        _buttonWidth = containerHeight * 0.8; // Adjust as needed
        final double buttonHeight = containerHeight * 0.8;

        // Calculate maximum drag distance
        _maxDragDistance = containerWidth - _buttonWidth - 4.0; // 4.0 for padding

        return Stack(
          children: [
            Center(
              child: Container(
                width: containerWidth,
                height: containerHeight,
                decoration: BoxDecoration(
                  color: Color(0XFFFB4156).withOpacity(0.2), // Replace with AppColors.sliderButtonColor
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Center(
                      child: CustomText( title:
                        _actionCompleted ? '' : 'Book Now   >>>>',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: screenHeight * 0.02,
                        ),
                      ),
                    Positioned(
                      left: _dragPosition,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            _dragPosition += details.delta.dx;
                            if (_dragPosition < 0) _dragPosition = 0;
                            if (_dragPosition > _maxDragDistance) {
                              _dragPosition = _maxDragDistance;
                            }
                          });
                        },
                        onPanEnd: (details) async {
                          if (_dragPosition >= _maxDragDistance * 0.95) {
                            // Consider action completed if dragged to 95% to account for slight overshoot
                            setState(() {
                              _actionCompleted = true;
                              _dragPosition = _maxDragDistance;
                            });
                            await Future.delayed(const Duration(milliseconds: 300));
                            // Navigate to the next page
                            // Navigator.push(context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const PassengerDetailsPage(),
                            //   ),
                            // );
                            widget.onActionCompleted();
                            setState(() {
                              _dragPosition = 0.0;
                              _actionCompleted = false;
                            });
                          } else {
                            // Animate back to start
                            setState(() {
                              _dragPosition = 0.0;
                              _actionCompleted = false;
                            });
                          }
                        },
                        child: Container(
                          width: _buttonWidth,
                          height: buttonHeight,
                          decoration: BoxDecoration(
                            color: _actionCompleted
                                ? Colors.green
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: SvgPicture.asset(
                              _actionCompleted?
                              'assets/vehicle/green_check.svg' : 'assets/vehicle/booknow_button.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}