import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_status_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/constant/constant.dart';
import 'package:flutter/material.dart';

class PropertyFilterWidget extends StatefulWidget {
  const PropertyFilterWidget({super.key});

  @override
  State<PropertyFilterWidget> createState() => _PropertyFilterWidgetState();
}

class _PropertyFilterWidgetState extends State<PropertyFilterWidget> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  readOnly: false,
                  title: 'Date (from)',
                  hintText: '',
                  icon:'assets/booking/date_icon.svg',
                  isPassword: false,
                  astric: false,
                  controller: fromDateController,
                  height: 52.0,
                  width:  MediaQuery.of(context).size.width * 0.42,
                  onTap: () async {},
                  onChanged: (val) {},
                  suffix: false,
                ),
                CustomTextField(
                  readOnly: false,
                  title: 'Date (to)',
                  hintText: '',
                  icon:'assets/booking/date_icon.svg',
                  isPassword: false,
                  astric: false,
                  controller: toDateController,
                  height: 52.0,
                  width:  MediaQuery.of(context).size.width * 0.42,
                  onTap: () async {},
                  onChanged: (val) {},
                  suffix: false,
                ),
              ],
            ),
            SizedBox(height: 16),
            CustomText(title: "Search by:", color: const Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 16, height: 1.06),
            SizedBox(height: 16),
            CustomTextField(
              title: 'Enter your booking ID',
              hintText: 'Enter your booking ID',
              controller: bookingIdController,
              isPassword: false,
              icon: 'null',
              height: 52,
              width: MediaQuery.of(context).size.width,
              onChanged: (val) {},
              onTap: () {},
              suffix: false,
              readOnly: false, 
              astric: false,
            ),
            SizedBox(height: 12),
            CustomTextField(
              title: 'Enter your company name',
              hintText: 'Enter your company name',
              controller: companyNameController,
              isPassword: false,
              icon: 'null',
              height: 52,
              width: MediaQuery.of(context).size.width,
              onChanged: (val) {},
              onTap: () {},
              suffix: false,
              readOnly: false, 
              astric: false,
            ),
            SizedBox(height: 12),
            CustomTextField(
              title: 'Enter your username',
              hintText: 'Enter your username',
              controller: usernameController,
              isPassword: false,
              icon: 'null',
              height: 52,
              width: MediaQuery.of(context).size.width,
              onChanged: (val) {},
              onTap: () {},
              suffix: false,
              readOnly: false, 
              astric: false,
            ),
            SizedBox(height: 16),
            CustomText(title: "Booking status", color: const Color(0xFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 16, height: 1.06),
            
            Wrap(
              spacing: 0,       
              runSpacing: 0, 
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: [
                BookingStatusWidget(
                  value: isConfirmedSelected,
                  text: "Confirmed",
                  onChanged: (val) {
                    setState(() => isConfirmedSelected = val ?? false);
                  },
                ),
                BookingStatusWidget(
                  value: isCompletedSelected,
                  text: "Completed",
                  onChanged: (val) {
                    setState(() => isCompletedSelected = val ?? false);
                  },
                ),
                BookingStatusWidget(
                  value: isCancelledSelected,
                  text: "Cancelled",
                  onChanged: (val) {
                    setState(() => isCancelledSelected = val ?? false);
                  },
                ),
                BookingStatusWidget(
                  value: isNoShowSelected,
                  text: "No show",
                  onChanged: (val) {
                    setState(() => isNoShowSelected = val ?? false);
                  },
                ),
                BookingStatusWidget(
                  value: isOnRequestSelected,
                  text: "On request",
                  onChanged: (val) {
                    setState(() => isOnRequestSelected = val ?? false);
                  },
                ),
                BookingStatusWidget(
                  value: isPobSelected,
                  text: "POB",
                  onChanged: (val) {
                    setState(() => isPobSelected = val ?? false);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}