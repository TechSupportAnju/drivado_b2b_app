import 'package:drivado_b2b_app/screens/bookings/bookings_widget/invoice_voucher_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DocumentWidget extends StatefulWidget {
  const DocumentWidget({super.key});
  @override
  State<DocumentWidget> createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentWidget> {
  SelectedOption selectedOption = SelectedOption.voucher; 
  void onSelect(SelectedOption value) {
    setState(() {
      selectedOption = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF190C0C),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset("assets/booking_detail/back_icon.svg"),
        ),
        title: CustomText(title: "Documents", color: Color(0XFFFFFFFF), fontWeight: FontWeight.w600, fontSize: 20, height: 2.4),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width,
          decoration: CustomDecorations().baseBackgroundDecoration(10.0, 1.0, Colors.white, Color(0XFFE6E8E7)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(title: "Booking ID", color: Color(0XFF606060), fontWeight: FontWeight.w500, fontSize: 12, height: 1.7),
                SizedBox(height: 4),
                CustomText(title: "D024-15784", color: Color(0XFF0D0D0D), fontWeight: FontWeight.w600, fontSize: 18, height: 1),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InvoiceVoucherWidget(
                        title: "Invoice",
                        image: "assets/booking_detail/invoice_icon.svg",
                        value: SelectedOption.invoice,
                        groupValue: selectedOption,
                        onChanged: onSelect,
                        footerText: "View Invoice",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InvoiceVoucherWidget(
                        title: "Voucher",
                        image: "assets/booking_detail/voucher_icon.svg",
                        value: SelectedOption.voucher,
                        groupValue: selectedOption,
                        onChanged: onSelect,
                        footerText: "View Voucher",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DriverDetailsWidget(
                  value: SelectedOption.driverDetails,
                  groupValue: selectedOption,
                  onChanged: onSelect,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
