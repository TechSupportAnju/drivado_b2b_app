import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search, color: Color(0XFF606060)),
          fillColor: Color(0XFFF5F6FA),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 14, 
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (value) {
          print("Search query: $value");
        },
      ),
    );
  }
}

class FilterBooking extends StatelessWidget {
  const FilterBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 52,
      decoration: CustomDecorations().baseBackgroundDecoration(
        8.0,
        1.0,
        Color(0XFFF5F6FA),
        Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
        child: SvgPicture.asset("assets/booking/filter_icon.svg"),
      ),
    );
  }
}