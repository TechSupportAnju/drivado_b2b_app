
import 'package:flutter/material.dart';

class RadioGroup<T> extends StatefulWidget {
  final List<T> items;
  final ValueChanged onChanged;
  final T? selectedItem;
  final bool disabled;
  final bool isSpace;
  final Axis scrollDirection;
  final Widget? Function(BuildContext, int) labelBuilder;
  final Color? activeColor;
  final Color? fillColor;
  final ScrollPhysics? scrollPhysics;
  final bool shrinkWrap;
  const RadioGroup({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.disabled = false,
    this.isSpace = true,
    this.scrollDirection = Axis.vertical,
    required this.labelBuilder,
    this.scrollPhysics,
    this.shrinkWrap = false,
    this.activeColor,
    this.fillColor,
  });
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class RadioGroupWidget extends State<RadioGroup> {
  dynamic selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              width: widget.scrollDirection == Axis.horizontal ? widget.isSpace ? 43 : 0 : 0,
              height: widget.scrollDirection == Axis.horizontal ? 8 : 10,
            );
          },
          physics: widget.scrollPhysics,
          scrollDirection: widget.scrollDirection,
          shrinkWrap: widget.shrinkWrap,
          itemCount: widget.items.length,
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: widget.disabled == true
                  ? null
                  : () {
                widget.onChanged(widget.items[index]);
                setState(() {
                  selectedItem = widget.items[index];
                });
              },
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      scale: 0.9,
                      child: Radio<dynamic>(
                        splashRadius: 1,
                        groupValue: selectedItem,
                        value: widget.items[index],
                        activeColor: widget.activeColor,
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: widget.disabled == true
                            ? null
                            : (val) {
                          widget.onChanged(val);

                          setState(() {
                            selectedItem = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    widget.labelBuilder(ctx, index) ?? const SizedBox.shrink(),
                  ]),
            );
          }),
    );
  }
}