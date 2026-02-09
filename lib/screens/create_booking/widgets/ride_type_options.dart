import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum RideType { oneway, hourly }

class RideTypeSelector extends StatefulWidget {
  const RideTypeSelector({
    super.key,
    this.initial = RideType.oneway,
    this.onChanged,
  });

  final RideType initial;
  final ValueChanged<RideType>? onChanged;

  @override
  State<RideTypeSelector> createState() => _RideTypeSelectorState();
}

class _RideTypeSelectorState extends State<RideTypeSelector> {
  late RideType selected = widget.initial;

  // COLORS
  static const _kBg = Color(0xFFF2F3F5);
  static const _kRed = Color(0xFF0D0D0D);
  static const _kGrey = Color(0xFF606060);

  // SIZING
  static const double _iconSize = 18.0;
  static const double _height = 59.0;

  final _labels = const {
    RideType.oneway: 'Oneway',
    RideType.hourly: 'Hourly',
  };

  final _subLabels = const {
    RideType.oneway: 'Airport · City · Intercity',
    RideType.hourly: 'Chauffeur by the hour',
  };

  final _iconInactive = const {
    RideType.oneway: 'assets/create_booking/oneway_icon.svg',
    RideType.hourly: 'assets/create_booking/hourly_icon.svg',
  };

  final _iconActive = const {
    RideType.oneway: 'assets/create_booking/oneway_icon.svg',
    RideType.hourly: 'assets/create_booking/hourly_icon.svg',
  };

  Widget _svg(String path) => SvgPicture.asset(
    path,
    width: _iconSize,
    height: _iconSize,
  );

  @override
  Widget build(BuildContext context) {
    final tabs = RideType.values;
    final width = MediaQuery.of(context).size.width;
    final itemW = (width - 25) / tabs.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: _height,
        decoration: BoxDecoration(
          color: _kBg,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.04),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(_alignmentFor(selected), 0),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: Container( 
                width: itemW,
                height: 47,
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            Row(
              children: tabs.map((t) {
                final isActive = t == selected;
                final label = _labels[t]!;
                final iconPath = isActive ? _iconActive[t]! : _iconInactive[t]!;

                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      if (selected == t) return;
                      setState(() => selected = t);
                      widget.onChanged?.call(t);
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _svg(iconPath),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  title: label,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isActive ? _kRed : _kGrey,
                                ),
                                SizedBox(height: 4),
                                CustomText(
                                  title: _subLabels[t]!,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isActive ? _kRed : _kGrey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // maps selected tab to AnimatedAlign’s -1, 0, 1 positions
  double _alignmentFor(RideType t) {
    switch (t) {
      case RideType.oneway:
        return -1.0;
      // case RideType.oneway:
      //   return 0.0;
      case RideType.hourly:
        return 1.0;
    }
  }
}
