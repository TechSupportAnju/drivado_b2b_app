import 'dart:async';
import 'package:drivado_b2b_app/models/country_code/country_code_model.dart';
import 'package:drivado_b2b_app/screens/booking_summary/booking_summary_page.dart';
import 'package:drivado_b2b_app/screens/common_widgets/country_code_widget/contact_text_field.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_textfield.dart';
import 'package:drivado_b2b_app/screens/create_booking/create_booking_page.dart';
import 'package:drivado_b2b_app/screens/passenger_detail/widget/custom_top_progress_bar.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_with_vechile_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_with_vechile_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/booking_with_vechile_state.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/passenger_create_and_booking_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/passenger_create_and_booking_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/passenger_create_and_booking_state.dart';
import 'package:drivado_b2b_app/services/bookings/booking_with_vechile_repository.dart';
import 'package:drivado_b2b_app/services/bookings/passenger_create_and_booking_repository.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_event.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:drivado_b2b_app/utils/constant.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class PassengerDetailsPage extends StatefulWidget {
  final selectedVehicle;
  final bool isTapOneway;
  final bool? isLogin;
  final String? bookingSearchId;
  final String? routeDistanceKm;
  final String? routeDuration;
  final String? bookingCurrency;

  const PassengerDetailsPage({
    required this.selectedVehicle,
    required this.isTapOneway,
    this.isLogin,
    this.bookingSearchId,
    this.routeDistanceKm,
    this.routeDuration,
    this.bookingCurrency,
    super.key}
      );

  @override
  State<PassengerDetailsPage> createState() => _PassengerDetailsPageState();
}

class _PassengerDetailsPageState extends State<PassengerDetailsPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController flightNo = TextEditingController();
  TextEditingController specialReq = TextEditingController();
  bool isButtonActive = false;
  String countryCode = '+91';

  TextEditingController country = TextEditingController();
  bool isFirstNameValidator = false;
  bool isLastNameValidator = false;
  bool isContactValidator = false;
  bool isEmailIdValidator = false;

  bool isTapFirstName = false;
  bool isTapLastName = false;
  bool isTapEmailName = false;
  bool isTapContactName = false;

  bool isEmailValid = true;
  bool isEmailValidShow = true;
  List countrtyList = [];
  List<CountryCodeModel> countrylisttt = [];

  List<CountryCodeModel> filterList = [];
  bool isAgree = false;
  String onewayDate = "";
  String onewayDay = "";
  String onewayMonth = "";
  String onewayYear = "";
  String hourlyDate = "";
  String hourlyDay = "";
  String hourlyMonth = "";
  String hourlyYear = "";
  String flightStatus = '';
  bool isFlightStatus = false;
  Timer? debounce;
  int toggleValue = 0;
  late final BookingWithVechileBloc _bookingWithVechileBloc;
  late final PassengerCreateAndBookingBloc _passengerCreateAndBookingBloc;

  @override
  void initState() {
    super.initState();
    _bookingWithVechileBloc = BookingWithVechileBloc(
      repository: BookingWithVechileRepository(),
    );
    _passengerCreateAndBookingBloc = PassengerCreateAndBookingBloc(
      repository: PassengerCreateAndBookingRepository(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureUserProfileLoaded());
  }

  String? flightNumber;


  @override
  void dispose() {
    super.dispose();
    debounce?.cancel();
    _bookingWithVechileBloc.close();
    _passengerCreateAndBookingBloc.close();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _bookingWithVechileBloc),
        BlocProvider.value(value: _passengerCreateAndBookingBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<BookingWithVechileBloc, BookingWithVechileState>(
            listener: (context, state) async {
              if (state is BookingWithVechileFailure) {
                _showError(state.message);
              }
              if (state is BookingWithVechileSuccess) {
                final bookingId = _extractBookingId(state.response);
                if (bookingId.isEmpty) {
                  _showError('Booking created but booking id not found.');
                  return;
                }
                final token = await AuthService.getAccessToken();
                if (!mounted) return;
                context.read<PassengerCreateAndBookingBloc>().add(
                  PassengerCreateAndBookingSubmitRequested(
                    payload: _buildPassengerPayload(bookingId),
                    accessToken: token,
                  ),
                );
              }
            },
          ),
          BlocListener<PassengerCreateAndBookingBloc, PassengerCreateAndBookingState>(
            listener: (context, state) {
              if (state is PassengerCreateAndBookingFailure) {
                _showError(state.message);
              }
              if (state is PassengerCreateAndBookingSuccess) {
                if (!mounted) return;
                topProgressBarIndex = 2;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BookingSummaryPage(
                          isTapOneway: widget.isTapOneway,
                          vehicleWithPrice: widget.selectedVehicle,
                          countryCode: countryCode,
                          name:
                              '${firstName.text.trim()} ${lastName.text.trim()}'
                                  .trim(),
                          phoneNumber: contactNumber.text.trim(),
                          email: emailId.text.trim(),
                          flightNo: flightNo.text.trim(),
                          splReq: specialReq.text.trim(),
                          travelDate: bookingDateController.text.trim(),
                          travelTime: bookingTimeController.text.trim(),
                          source:
                              widget.isTapOneway
                                  ? fromController.text.trim()
                                  : hourlyFromController.text.trim(),
                          destination:
                              widget.isTapOneway
                                  ? toController.text.trim()
                                  : hourlyFromController.text.trim(),
                          passengerLabel: '1 Pax',
                          distance:
                              (widget.routeDistanceKm?.trim().isNotEmpty == true)
                                  ? '${widget.routeDistanceKm!.trim()} km'
                                  : '—',
                          duration:
                              (widget.routeDuration?.trim().isNotEmpty == true)
                                  ? widget.routeDuration!.trim()
                                  : '—',
                          amount:
                              widget.selectedVehicle['price']?.toString() ?? '0',
                          currency:
                              (widget.bookingCurrency?.trim().isNotEmpty == true)
                                  ? widget.bookingCurrency!.trim()
                                  : (widget.selectedVehicle['unit']?.toString() ??
                                      'USD'),
                        ),
                  ),
                );
              }
            },
          ),
        ],
        child: Builder(
          builder: (innerContext) {
            return PopScope(
          canPop: false,
          child: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
              flexibleSpace: Container(
                height: 70,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              shadowColor: Color(0xFFD9D9D9),
              centerTitle: true,
              leading: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.keyboard_backspace,
                    color: Color(0xFF555555),
                  )),
              title: const CustomText(
                  title: 'Passenger Details',
                  color: Color(0xFF101010),
                  fontWeight: FontWeight.w600,
                  fontSize: 20)),
          body:  Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomTopProgressBar(
                  tabCount: topProgressBarIndex,
                  isActive: isButtonActive,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        CustomTextField(
                          title: 'First name',
                          hintText: 'Enter your first name',
                          controller: firstName,
                          isPassword: false,
                          icon: 'null',
                          height: 52,
                          width: MediaQuery.of(context).size.width,
                          onChanged: (val) {
                            if(firstName.text != '') {
                              isFirstNameValidator = false;
                            }else {
                              isFirstNameValidator = true;
                            }
                            setState(() {
                            });
                          },
                          onTap: () {
                          },
                          suffix: false,
                          readOnly: false,
                          astric: true,
                          error: isFirstNameValidator,),
                        const SizedBox(height: 12),
                        CustomTextField(
                          title: 'Last Name',
                          hintText: 'Enter your last name',
                          controller: lastName,
                          isPassword: false,
                          icon: 'null',
                          height: 52,
                          width: MediaQuery.of(context).size.width,
                          onChanged: (val) {
                            if(lastName.text != '') {
                              isLastNameValidator = false;
                            }else {
                              isLastNameValidator = true;
                            }
                            setState(() {
                            });
                          },
                          onTap: () {
                          },
                          suffix: false,
                          readOnly: false,
                          astric: true,
                          error: isLastNameValidator,),
                        const SizedBox(height: 12),
                        ContactTextField(
                          isContactValidator: isContactValidator,
                          isTapContactName: isTapContactName,
                          controller: contactNumber,
                          onTap: () {},
                          onChanged: () {},
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          title: 'Email ID',
                          hintText: 'Enter your email id',
                          controller: emailId,
                          isPassword: false,
                          icon: 'null',
                          height: 52,
                          width: MediaQuery.of(context).size.width,
                          onChanged: (val) {
                            if(emailId.text != '') {
                              isEmailIdValidator = false;
                            }else {
                              isEmailIdValidator = true;
                            }
                            setState(() {
                            });
                          },
                          onTap: () {
                          },
                          suffix: false,
                          readOnly: false,
                          astric: true,
                          error: isEmailIdValidator,),
                        const SizedBox(height: 12),
                        CustomTextField(
                          title: 'Flight number (Optional)',
                          hintText: 'Enter your flight number',
                          controller: flightNo,
                          isPassword: false,
                          icon: 'null',
                          height: 52,
                          width: MediaQuery.of(context).size.width,
                          onChanged: (val) {
                          },
                          onTap: () {},
                          suffix: false,
                          readOnly: false,
                          astric: false,
                          error: false,),
                        const SizedBox(height: 12),
                        CustomTextField(
                          title: 'Any special request (Optional)',
                          hintText: 'Enter any special request',
                          controller: specialReq,
                          isPassword: false,
                          icon: 'null',
                          height: 52,
                          width: MediaQuery.of(context).size.width,
                          onChanged: (val) {
                          },
                          onTap: () {
                          },
                          suffix: false,
                          readOnly: false,
                          astric: false,
                          error: false,),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            const SizedBox(width: 1),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                isAgree = !isAgree;
                                setState(() {
                                });
                                print('isAgree===');
                                print(isAgree);
                                if(isAgree) {
                                  isButtonActive = true;
                                } else {
                                  isButtonActive = false;
                                }
                                setState(() {
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MediaQuery.of(context).size.width >= 500?
                                  const SizedBox(height: 3)  : Container(),
                                  Icon(
                                    isAgree
                                        ? Icons.check_box : Icons.check_box_outline_blank_rounded,
                                    color: isAgree
                                        ? AppColors.secondary : Color(0xFF8E8E93),
                                    size: 18,
                                  ),
                                  MediaQuery.of(context).size.width >= 500
                                      ? Container() : const SizedBox(height: 11)
                                ],
                              ),
                            ),
                            GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  isAgree = !isAgree;
                                  setState(() {
                                  });
                                  print('isAgree===');
                                  print(isAgree);
                                  if(isAgree) {
                                    isButtonActive = true;
                                  } else {
                                    isButtonActive = false;
                                  }
                                  setState(() {
                                  });
                                },
                                child: const SizedBox(width: 10)
                            ),
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: 'I agree to ',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.black,
                                      height: 1.4
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Terms & Conditions, Booking Conditions ',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColors.secondary
                                        )
                                    ),
                                    TextSpan(
                                        text: 'and ',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Colors.black
                                        )
                                    ),
                                    TextSpan(
                                        text: 'Privacy Policy',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColors.secondary
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        BlocBuilder<BookingWithVechileBloc, BookingWithVechileState>(
                          builder: (context, bookingState) {
                            final passengerState =
                                context.watch<PassengerCreateAndBookingBloc>().state;
                            final isLoading =
                                bookingState is BookingWithVechileLoading ||
                                passengerState is PassengerCreateAndBookingLoading;
                            return GestureDetector(
                          onTap: (isAgree)
                              ? () {
                            _submitBooking();
                          }
                          : () {
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                color: isButtonActive && isAgree && !isLoading
                                    ? AppColors.secondary
                                    : AppColors.secondary
                                    .withOpacity(0.44),
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const CustomText(
                                    title: 'Confirm Booking',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                          ),
                        );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
          },
        ),
      ),
    );
  }

  Future<void> _submitBooking() async {
    if (!isAgree) return;
    if (!_validateRequiredPassengerFields()) return;

    final userState = context.read<UserInformationBloc>().state;
    String userId = '';
    String userName = '';
    if (userState is UserInformationLoaded) {
      userId = userState.userData.id?.trim() ?? '';
      userName = userState.userData.userName?.trim() ?? '';
      if (userName.isEmpty) {
        userName = userState.userData.email?.trim() ?? '';
      }
    }

    if (userId.isEmpty || userName.isEmpty) {
      _showError('User information not loaded. Please try again.');
      return;
    }

    final parsedDate = _parseSelectedDate();
    final travelDate =
        parsedDate != null ? DateFormat('yyyy-MM-dd').format(parsedDate) : '';
    final travelTime = bookingTimeController.text.trim();
    if (travelDate.isEmpty || travelTime.isEmpty) {
      _showError('Invalid booking date/time.');
      return;
    }

    final travelStamp = _travelTimestamp(travelDate, travelTime);
    final nowInIndia = DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));

    final source = _placeObject(
      placeName: widget.isTapOneway ? fromController.text.trim() : hourlyFromController.text.trim(),
      placeId: widget.isTapOneway ? fromPlaceId : hourlyFromPlaceId,
      coordinate: widget.isTapOneway ? fromCoordinate : hourlyFromCoordinate,
    );
    final destination = _placeObject(
      placeName: widget.isTapOneway ? toController.text.trim() : hourlyFromController.text.trim(),
      placeId: widget.isTapOneway ? toPlaceId : hourlyFromPlaceId,
      coordinate: widget.isTapOneway ? toCoordinate : hourlyFromCoordinate,
    );

    final selectedVehicle = Map<String, dynamic>.from(widget.selectedVehicle as Map);
    final currency =
        widget.bookingCurrency?.trim().isNotEmpty == true
            ? widget.bookingCurrency!.trim()
            : (selectedVehicle['unit']?.toString().trim() ?? 'USD');
    final amount = double.tryParse(selectedVehicle['price']?.toString() ?? '') ?? 0;
    final distance =
        (widget.routeDistanceKm?.trim().isNotEmpty == true)
            ? widget.routeDistanceKm!.trim()
            : (selectedVehicle['distanceKm']?.toString().trim() ?? '');
    final duration =
        (widget.routeDuration?.trim().isNotEmpty == true)
            ? widget.routeDuration!.trim()
            : (selectedVehicle['duration']?.toString().trim() ?? '');

    final payload = <String, dynamic>{
      'source': source,
      'destination': destination,
      'travelDate': travelDate,
      'travelTime': travelTime,
      'travelTimeStamp': travelStamp,
      'passenger': '1 Passenger',
      'bookingType': widget.isTapOneway ? 'ONEWAY' : 'HOURLY',
      'travelDistance': distance,
      'priceDetails': {'amount': amount, 'currency': currency},
      'bookingPriceInUsd': amount,
      'duration': duration,
      'vehicle': {
        'vehicleName':
            selectedVehicle['vehicleName']?.toString().trim().isNotEmpty == true
                ? selectedVehicle['vehicleName']
                : selectedVehicle['vehicleType'],
      },
      'userName': userName,
      'user': userId,
      'indianTravelDate': _isoWithOffset(nowInIndia, const Duration(hours: 5, minutes: 30)),
      'indianTravelTime': DateFormat('HH:mm').format(nowInIndia),
    };

    final token = await AuthService.getAccessToken();
    // if (!mounted) return;
    _bookingWithVechileBloc.add(
      BookingWithVechileSubmitRequested(
        payload: payload,
        accessToken: token,
      ),
    );
  }

  bool _validateRequiredPassengerFields() {
    final first = firstName.text.trim();
    final last = lastName.text.trim();
    final phone = contactNumber.text.trim();
    final email = emailId.text.trim();

    setState(() {
      isFirstNameValidator = first.isEmpty;
      isLastNameValidator = last.isEmpty;
      isContactValidator = phone.isEmpty;
      isEmailIdValidator = email.isEmpty;
    });

    if (first.isEmpty || last.isEmpty || phone.isEmpty || email.isEmpty) {
      _showError('Please fill all required passenger details.');
      return false;
    }
    return true;
  }

  Map<String, dynamic> _buildPassengerPayload(String bookingId) {
    return {
      'firstname': firstName.text.trim(),
      'lastname': lastName.text.trim(),
      'email': emailId.text.trim(),
      'country': country.text.trim().isEmpty ? 'India' : country.text.trim(),
      'dial_code': countryCode,
      'phone': contactNumber.text.trim(),
      'flightOrTrain': flightNo.text.trim(),
      'reference': '',
      'specialRequest': specialReq.text.trim(),
      'bookingId': bookingId,
    };
  }

  String _extractBookingId(Map<String, dynamic> response) {
    const keys = ['bookingId', 'bookingID', 'booking_id', 'id'];
    final stack = <dynamic>[response];
    while (stack.isNotEmpty) {
      final current = stack.removeLast();
      if (current is Map) {
        final m = Map<String, dynamic>.from(current);
        for (final key in keys) {
          final value = m[key];
          if (value != null && value.toString().trim().isNotEmpty) {
            return value.toString().trim();
          }
        }
        stack.addAll(m.values);
      } else if (current is List) {
        stack.addAll(current);
      }
    }
    return '';
  }

  Map<String, String> _placeObject({
    required String placeName,
    required String placeId,
    required String coordinate,
  }) {
    final parts = coordinate.split(',');
    final lat = parts.isNotEmpty ? parts.first.trim() : '';
    final lng = parts.length > 1 ? parts[1].trim() : '';
    return {
      'placename': placeName,
      'placeid': placeId.trim(),
      'lat': lat,
      'lng': lng,
    };
  }

  DateTime? _parseSelectedDate() {
    final text = bookingDateController.text.trim();
    if (text.isEmpty) return null;
    try {
      return DateFormat('dd-MMM-yyyy').parseStrict(text);
    } catch (_) {
      return null;
    }
  }

  String _travelTimestamp(String travelDate, String travelTime) {
    try {
      final dt = DateFormat('yyyy-MM-dd HH:mm').parseStrict('$travelDate $travelTime');
      final offset = dt.timeZoneOffset;
      return _isoWithOffset(dt, offset);
    } catch (_) {
      return '${travelDate}T${travelTime}:00';
    }
  }

  String _isoWithOffset(DateTime dt, Duration offset) {
    final sign = offset.isNegative ? '-' : '+';
    final abs = offset.abs();
    final hh = abs.inHours.toString().padLeft(2, '0');
    final mm = (abs.inMinutes % 60).toString().padLeft(2, '0');
    return '${DateFormat('yyyy-MM-ddTHH:mm:ss').format(dt)}$sign$hh:$mm';
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _ensureUserProfileLoaded() async {
    if (!mounted) return;
    final bloc = context.read<UserInformationBloc>();
    final s = bloc.state;
    if (s is UserInformationLoaded || s is UserInformationLoading) return;
    final token = await AuthService.getAccessToken();
    if (!mounted || token == null || token.isEmpty) return;
    bloc.add(UserInformationLoadDetails(accessToken: token));
  }



}
