import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipSpec {
  final String label;
  final Widget? leading;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;

  const ChipSpec({
    required this.label,
    this.leading,
    this.bgColor = Colors.white,
    this.borderColor = const Color(0xFFE6E8E7),
    this.textColor = const Color(0xFF606060),
  });

  factory ChipSpec.text(String label) => ChipSpec(label: label);

  factory ChipSpec.icon(String label) => ChipSpec(
    label: label,
  );
}

/// Single oval chip (pill)
class OvalChip extends StatelessWidget {
  final ChipSpec spec;
  final EdgeInsets padding;
  final double radius;
  final TextStyle? textStyle;

  const OvalChip({
    super.key,
    required this.spec,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.radius = 16,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: ShapeDecoration(
        color: spec.bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: spec.borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (spec.leading != null) ...[
            spec.leading!,
            const SizedBox(width: 6),
          ],
          Text(
            spec.label,
            style: (textStyle ??
                GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                ))
                .copyWith(color: spec.textColor),
          ),
        ],
      ),
    );
  }
}

/// Group that lays chips horizontally and wraps if needed
class OvalChipGroup extends StatefulWidget {
  final List<ChipSpec> items;
  final double spacing;
  final double runSpacing;
  final EdgeInsets padding;

  const OvalChipGroup({
    super.key,
    required this.items,
    this.spacing = 8,
    this.runSpacing = 8,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<OvalChipGroup> createState() => _OvalChipGroupState();
}

class _OvalChipGroupState extends State<OvalChipGroup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Wrap(
        spacing: widget.spacing,
        runSpacing: widget.runSpacing,
        children: widget.items.map((e) => OvalChip(spec: e)).toList(),
      ),
    );
  }
}
