import 'package:drivado_b2b_app/models/booking_detail_model.dart';
import 'package:drivado_b2b_app/models/booking_document_mail_kind.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/common_button.dart';
import 'package:drivado_b2b_app/screens/bookings/bookings_widget/invoice_voucher_widget.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_toaster.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_document_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_document_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_document_state.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DocumentWidget extends StatefulWidget {
  final String bookingId;
  final BookingDetailData detail;

  const DocumentWidget({
    super.key,
    required this.bookingId,
    required this.detail,
  });

  @override
  State<DocumentWidget> createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentWidget> {
  SelectedOption? selectedOption;
  bool _emailFieldError = false;
  String? _emailErrorText;
  String? _selectionErrorText;

  final TextEditingController _emailAddress = TextEditingController();

  @override
  void dispose() {
    _emailAddress.dispose();
    super.dispose();
  }

  void _onSelect(SelectedOption value) {
    setState(() {
      selectedOption = value;
      _selectionErrorText = null;
    });
  }

  static BookingDocumentMailKind _kindFor(SelectedOption o) {
    switch (o) {
      case SelectedOption.invoice:
        return BookingDocumentMailKind.invoice;
      case SelectedOption.voucher:
        return BookingDocumentMailKind.voucher;
      case SelectedOption.driverDetails:
        return BookingDocumentMailKind.driverDetails;
    }
  }

  String _successTitle(SelectedOption o) {
    switch (o) {
      case SelectedOption.invoice:
        return 'Invoice sent';
      case SelectedOption.voucher:
        return 'Voucher sent';
      case SelectedOption.driverDetails:
        return 'Driver details sent';
    }
  }

  String _successSubtitle(SelectedOption o) {
    switch (o) {
      case SelectedOption.invoice:
        return 'Your invoice has been emailed.';
      case SelectedOption.voucher:
        return 'Your voucher has been emailed.';
      case SelectedOption.driverDetails:
        return 'Driver details have been emailed.';
    }
  }

  void _validateAndSend() {
    setState(() {
      _emailErrorText = null;
      _emailFieldError = false;
      _selectionErrorText = null;
    });

    if (selectedOption == null) {
      setState(() {
        _selectionErrorText =
            'Please select invoice, voucher, or driver details.';
      });
      return;
    }

    final email = _emailAddress.text.trim();
    if (email.isEmpty) {
      setState(() {
        _emailFieldError = true;
        _emailErrorText = 'Please enter your email address.';
      });
      return;
    }

    if (!EmailValidator.validate(email)) {
      setState(() {
        _emailFieldError = true;
        _emailErrorText = 'Please enter a valid email address.';
      });
      return;
    }

    final profile = context.read<UserInformationBloc>().state;
    final companyName =
        profile is UserInformationLoaded
            ? (profile.userData.company?.companyName ?? '').trim()
            : '';

    context.read<BookingDocumentBloc>().add(
      BookingDocumentSendRequested(
        kind: _kindFor(selectedOption!),
        email: email,
        detail: widget.detail,
        companyName: companyName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingDocumentBloc, BookingDocumentState>(
      listener: (context, state) {
        if (state is BookingDocumentSuccess) {
          final opt = selectedOption;
          context.read<BookingDocumentBloc>().add(const BookingDocumentReset());
          if (opt != null) {
            AppToast.show(
              context: context,
              title: _successTitle(opt),
              subtitle: _successSubtitle(opt),
              leadingIcon: 'assets/booking_detail/toaster_icon.svg',
            );
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) Navigator.pop(context);
          });
        } else if (state is BookingDocumentFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xFF190C0C),
          toolbarHeight: 75,
          leadingWidth: 60,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SvgPicture.asset('assets/booking_detail/back_icon.svg'),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CustomText(
              title: 'Documents',
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 2.4,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: CustomDecorations().baseBackgroundDecoration(
                10.0,
                1.0,
                Colors.white,
                const Color(0xFFE6E8E7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      title: 'Booking ID',
                      color: Color(0xFF606060),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1.7,
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      title: widget.bookingId,
                      color: const Color(0xFF0D0D0D),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      height: 1,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InvoiceVoucherWidget(
                            title: 'Invoice',
                            image: 'assets/booking_detail/invoice_icon.svg',
                            value: SelectedOption.invoice,
                            groupValue: selectedOption,
                            onChanged: _onSelect,
                            footerText: 'View Invoice',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InvoiceVoucherWidget(
                            title: 'Voucher',
                            image: 'assets/booking_detail/voucher_icon.svg',
                            value: SelectedOption.voucher,
                            groupValue: selectedOption,
                            onChanged: _onSelect,
                            footerText: 'View Voucher',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DriverDetailsWidget(
                      value: SelectedOption.driverDetails,
                      groupValue: selectedOption,
                      onChanged: _onSelect,
                    ),
                    if (_selectionErrorText != null) ...[
                      const SizedBox(height: 8),
                      CustomText(
                        title: _selectionErrorText!,
                        color: const Color(0xFFFB4156),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ],
                    const SizedBox(height: 16),
                    const CustomText(
                      title: 'Send Email To:',
                      color: Color(0xFF0D0D0D),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      title: 'Email ID',
                      hintText: 'Enter your email ID',
                      controller: _emailAddress,
                      isPassword: false,
                      autofocus: false,
                      icon: 'null',
                      height: 52,
                      width: MediaQuery.of(context).size.width,
                      onChanged: (val) {
                        setState(() {
                          if (_emailFieldError) {
                            _emailFieldError = false;
                            _emailErrorText = null;
                          }
                        });
                      },
                      onTap: () {},
                      suffix: false,
                      readOnly: false,
                      astric: true,
                      error: _emailFieldError,
                    ),
                    if (_emailErrorText != null) ...[
                      const SizedBox(height: 6),
                      CustomText(
                        title: _emailErrorText!,
                        color: const Color(0xFFFB4156),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ],
                    const SizedBox(height: 32),
                    BlocBuilder<BookingDocumentBloc, BookingDocumentState>(
                      builder: (context, state) {
                        final sending = state is BookingDocumentSending;
                        final canTap = !sending;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap:
                                  sending ? null : () => Navigator.pop(context),
                              child: const CommonButtonWidget(
                                backgroundColor: Color(0xFFFFFFFF),
                                borderColor: Color(0xFF606060),
                                text: 'Cancel',
                                textColor: Color(0xFF606060),
                              ),
                            ),
                            InkWell(
                              onTap: canTap ? _validateAndSend : null,
                              child: CommonButtonWidget(
                                backgroundColor:
                                    sending
                                        ? const Color(
                                          0xFFFB4156,
                                        ).withOpacity(0.5)
                                        : const Color(0xFFFB4156),
                                borderColor: Colors.transparent,
                                text: sending ? 'Sending…' : 'Send',
                                textColor: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
