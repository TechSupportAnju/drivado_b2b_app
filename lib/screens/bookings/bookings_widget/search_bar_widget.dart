import 'package:drivado_b2b_app/screens/bookings/search_filter_page.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
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
        readOnly: true,
        enableInteractiveSelection: false,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const SearchFilterPage(),
            ),
          );
        },
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: 'Search & filter',
          prefixIcon: const Icon(Icons.search, color: Color(0XFF606060)),
          fillColor: const Color(0XFFF5F6FA),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}

class FilterBooking extends StatelessWidget {
  final int activeFilterCount;

  const FilterBooking({super.key, this.activeFilterCount = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: CustomDecorations().baseBackgroundDecoration(
        8.0,
        1.0,
        Color(0XFFF5F6FA),
        activeFilterCount > 0 ? AppColors.secondary : Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: SvgPicture.asset("assets/booking/filter_icon.svg"),
          ),
          if (activeFilterCount > 0) ...[
            const SizedBox(width: 6),
            Container(
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                '${activeFilterCount}x',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}