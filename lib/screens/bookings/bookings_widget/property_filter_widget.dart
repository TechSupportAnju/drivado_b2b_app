import 'package:drivado_b2b_app/models/booking_search_filter_payload.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/booking_status_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_buttons.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/constant/constant.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_list_event.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PropertyFilterWidget extends StatefulWidget {
  final BookingFilterDateRangeKind dateRangeKind;
  final VoidCallback? onFilterChanged;

  const PropertyFilterWidget({
    super.key,
    required this.dateRangeKind,
    this.onFilterChanged,
  });

  @override
  State<PropertyFilterWidget> createState() => _PropertyFilterWidgetState();
}

class _PropertyFilterWidgetState extends State<PropertyFilterWidget> {
  String? _trimOrNull(String value) {
    final t = value.trim();
    return t.isEmpty ? null : t;
  }

  List<String> _selectedBookingStatuses() {
    final out = <String>[];
    if (isConfirmedSelected) out.add('CONFIRMED');
    if (isCompletedSelected) out.add('COMPLETED');
    if (isCancelledSelected) out.add('CANCELLED');
    if (isNoShowSelected) out.add('NO_SHOW');
    if (isOnRequestSelected) out.add('ON_REQUEST');
    if (isPobSelected) out.add('POB');
    return out;
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final now = DateTime.now();
    DateTime initial = now;
    final current = controller.text.trim();
    if (current.isNotEmpty) {
      final parsed = DateTime.tryParse(current);
      if (parsed != null) initial = parsed;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
      widget.onFilterChanged?.call();
      setState(() {});
    }
  }

  void _onSearch() {
    FocusScope.of(context).unfocus();
    final u = context.read<UserInformationBloc>().state;
    if (u is! UserInformationLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile not loaded. Please wait and try again.'),
        ),
      );
      return;
    }

    context.read<BookingListBloc>().add(
      BookingListSearchRequested(
        userData: u.userData,
        filter: BookingSearchFilterPayload(
          dateRangeKind: widget.dateRangeKind,
          dateFrom: _trimOrNull(fromDateController.text),
          dateTo: _trimOrNull(toDateController.text),
          bookingId: _trimOrNull(bookingIdController.text),
          companyName: _trimOrNull(companyNameController.text),
          userNameQuery: _trimOrNull(usernameController.text),
          customerName: _trimOrNull(passengerNameController.text),
          passengerNumber: _trimOrNull(passengerNumberController.text),
          driverName: _trimOrNull(driverNameController.text),
          driverNumber: _trimOrNull(driverNumberController.text),
          quoteBy: _trimOrNull(quoteByController.text),
          bookingStatuses: _selectedBookingStatuses(),
        ),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextField(
                readOnly: true,
                title: 'Date (from)',
                hintText: 'yyyy-MM-dd',
                icon: 'assets/booking/date_icon.svg',
                isPassword: false,
                astric: false,
                controller: fromDateController,
                height: 52.0,
                width: MediaQuery.of(context).size.width * 0.42,
                onTap: () => _pickDate(fromDateController),
                onChanged: (val) => widget.onFilterChanged?.call(),
                suffix: false,
                autofocus: false,
              ),
              CustomTextField(
                readOnly: true,
                title: 'Date (to)',
                hintText: 'yyyy-MM-dd',
                icon: 'assets/booking/date_icon.svg',
                isPassword: false,
                astric: false,
                controller: toDateController,
                height: 52.0,
                width: MediaQuery.of(context).size.width * 0.42,
                onTap: () => _pickDate(toDateController),
                onChanged: (val) => widget.onFilterChanged?.call(),
                suffix: false,
                autofocus: false,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const CustomText(
            title: 'Search by:',
            color: Color(0xFF0D0D0D),
            fontWeight: FontWeight.w600,
            fontSize: 16,
            height: 1.06,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            title: 'Enter your booking ID',
            hintText: 'Enter your booking ID',
            controller: bookingIdController,
            isPassword: false,
            icon: 'null',
            height: 52,
            width: MediaQuery.of(context).size.width,
            onChanged: (val) => widget.onFilterChanged?.call(),
            onTap: () {},
            suffix: false,
            readOnly: false,
            astric: false,
            autofocus: false,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            title: 'Enter your company name',
            hintText: 'Enter your company name',
            controller: companyNameController,
            isPassword: false,
            icon: 'null',
            height: 52,
            width: MediaQuery.of(context).size.width,
            onChanged: (val) => widget.onFilterChanged?.call(),
            onTap: () {},
            suffix: false,
            readOnly: false,
            astric: false,
            autofocus: false,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            title: 'Enter your username',
            hintText: 'Enter your username',
            controller: usernameController,
            isPassword: false,
            icon: 'null',
            height: 52,
            width: MediaQuery.of(context).size.width,
            onChanged: (val) => widget.onFilterChanged?.call(),
            onTap: () {},
            suffix: false,
            readOnly: false,
            astric: false,
            autofocus: false,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            title: 'Quote by',
            hintText: 'Quote by',
            controller: quoteByController,
            isPassword: false,
            icon: 'null',
            height: 52,
            width: MediaQuery.of(context).size.width,
            onChanged: (val) => widget.onFilterChanged?.call(),
            onTap: () {},
            suffix: false,
            readOnly: false,
            astric: false,
            autofocus: false,
          ),
          const SizedBox(height: 16),
          const CustomText(
            title: 'Passenger details',
            color: Color(0xFF0D0D0D),
            fontWeight: FontWeight.w600,
            fontSize: 16,
            height: 1.06,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            title: 'Enter passenger name',
            hintText: 'Enter passenger name',
            controller: passengerNameController,
            isPassword: false,
            icon: 'null',
            height: 52,
            width: MediaQuery.of(context).size.width,
            onChanged: (val) => widget.onFilterChanged?.call(),
            onTap: () {},
            suffix: false,
            readOnly: false,
            astric: false,
            autofocus: false,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            title: 'Enter passenger number',
            hintText: 'Enter passenger number',
            controller: passengerNumberController,
            isPassword: false,
            icon: 'null',
            height: 52,
            width: MediaQuery.of(context).size.width,
            onChanged: (val) => widget.onFilterChanged?.call(),
            onTap: () {},
            suffix: false,
            readOnly: false,
            astric: false,
            autofocus: false,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            title: 'Driver name',
            hintText: 'Driver name',
            controller: driverNameController,
            isPassword: false,
            icon: 'null',
            height: 52,
            width: MediaQuery.of(context).size.width,
            onChanged: (val) => widget.onFilterChanged?.call(),
            onTap: () {},
            suffix: false,
            readOnly: false,
            astric: false,
            autofocus: false,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            title: 'Driver number',
            hintText: 'Driver number',
            controller: driverNumberController,
            isPassword: false,
            icon: 'null',
            height: 52,
            width: MediaQuery.of(context).size.width,
            keyboardType: TextInputType.phone,
            onChanged: (val) {},
            onTap: () {},
            suffix: false,
            readOnly: false,
            astric: false,
            autofocus: false,
          ),
          const SizedBox(height: 16),
          const CustomText(
            title: 'Booking status',
            color: Color(0xFF0D0D0D),
            fontWeight: FontWeight.w600,
            fontSize: 16,
            height: 1.06,
          ),
          Wrap(
            spacing: 0,
            runSpacing: 0,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: [
              BookingStatusWidget(
                value: isConfirmedSelected,
                text: 'Confirmed',
                onChanged: (val) {
                  setState(() => isConfirmedSelected = val ?? false);
                  widget.onFilterChanged?.call();
                },
              ),
              BookingStatusWidget(
                value: isCompletedSelected,
                text: 'Completed',
                onChanged: (val) {
                  setState(() => isCompletedSelected = val ?? false);
                  widget.onFilterChanged?.call();
                },
              ),
              BookingStatusWidget(
                value: isCancelledSelected,
                text: 'Cancelled',
                onChanged: (val) {
                  setState(() => isCancelledSelected = val ?? false);
                  widget.onFilterChanged?.call();
                },
              ),
              BookingStatusWidget(
                value: isNoShowSelected,
                text: 'No show',
                onChanged: (val) {
                  setState(() => isNoShowSelected = val ?? false);
                  widget.onFilterChanged?.call();
                },
              ),
              BookingStatusWidget(
                value: isOnRequestSelected,
                text: 'On request',
                onChanged: (val) {
                  setState(() => isOnRequestSelected = val ?? false);
                  widget.onFilterChanged?.call();
                },
              ),
              BookingStatusWidget(
                value: isPobSelected,
                text: 'POB',
                onChanged: (val) {
                  setState(() => isPobSelected = val ?? false);
                  widget.onFilterChanged?.call();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomButtons(
                isIcon: false,
                title: 'Search',
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                onTap: _onSearch,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
