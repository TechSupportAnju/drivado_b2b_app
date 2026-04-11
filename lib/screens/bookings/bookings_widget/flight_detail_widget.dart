import 'package:dotted_line/dotted_line.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/flight_data_bloc.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/flight_data_event.dart';
import 'package:drivado_b2b_app/services/bookings/bloc/flight_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class _FlightPanelView {
  final String etaLine;
  final String staLine;
  final String statusLabel;
  final Color statusColor;
  final String terminalLine;
  final String depCode;
  final String arrCode;

  _FlightPanelView({
    required this.etaLine,
    required this.staLine,
    required this.statusLabel,
    required this.statusColor,
    required this.terminalLine,
    required this.depCode,
    required this.arrCode,
  });

  factory _FlightPanelView.fromResponse(Map<String, dynamic> map) {
    Map<String, dynamic>? st;
    final fs = map['flightStatuses'];
    if (fs is List && fs.isNotEmpty && fs.first is Map) {
      st = Map<String, dynamic>.from(fs.first as Map);
    }

    String fmt(DateTime? t) {
      if (t == null) return '—';
      return DateFormat('dd-MM-yyyy h:mm a').format(t);
    }

    DateTime? opTime(dynamic v) {
      if (v is Map) {
        final s = v['dateLocal'] ?? v['local'] ?? v['dateUtc'];
        if (s != null) {
          final d = DateTime.tryParse(s.toString());
          return d?.toLocal();
        }
      }
      return null;
    }

    var dep = '—';
    var arr = '—';
    var terminal = '—';
    var statusText = '—';
    var statusColor = const Color(0xFF606060);
    DateTime? eta;
    DateTime? sta;

    if (st != null) {
      dep = st['departureAirportFsCode']?.toString() ?? '—';
      arr = st['arrivalAirportFsCode']?.toString() ?? '—';
      final ot = st['operationalTimes'];
      if (ot is Map) {
        final om = Map<String, dynamic>.from(ot);
        eta = opTime(om['publishedArrival']);
        sta = opTime(om['publishedDeparture']);
        eta ??= opTime(om['estimatedArrival']);
        sta ??= opTime(om['estimatedDeparture']);
      }
      final res = st['airportResources'];
      if (res is Map) {
        final t = res['arrivalTerminal'] ?? res['departureTerminal'];
        if (t != null && t.toString().trim().isNotEmpty) {
          terminal = 'Terminal ${t.toString().trim()}';
        }
      }
      final s = st['status']?.toString();
      if (s != null && s.isNotEmpty) {
        statusText = s;
        final u = s.toUpperCase();
        if (u.contains('DELAY') || u.contains('CANCEL')) {
          statusColor = const Color(0xFFFF9800);
        } else if (u.contains('TIME') ||
            u.contains('SCHEDULE') ||
            u.contains('LANDED') ||
            u.contains('ARRIVED')) {
          statusColor = const Color(0xFF16A329);
        }
      }
    }

    return _FlightPanelView(
      etaLine: fmt(eta),
      staLine: fmt(sta),
      terminalLine: terminal,
      statusLabel: statusText,
      statusColor: statusColor,
      depCode: dep,
      arrCode: arr,
    );
  }
}

class FlightDetailWidget extends StatefulWidget {
  final String flightNumber;
  final DateTime lookupDate;

  const FlightDetailWidget({
    super.key,
    required this.flightNumber,
    required this.lookupDate,
  });

  @override
  State<FlightDetailWidget> createState() => _FlightDetailWidgetState();
}

class _FlightDetailWidgetState extends State<FlightDetailWidget> {
  bool _expanded = false;

  void _onTap() {
    if (_expanded) {
      setState(() => _expanded = false);
      context.read<FlightDataBloc>().add(const FlightDataReset());
      return;
    }

    final state = context.read<FlightDataBloc>().state;
    if (state is FlightDataLoading) return;

    context.read<FlightDataBloc>().add(
          FlightDataRequested(
            flightNumber: widget.flightNumber,
            lookupDateLocal: widget.lookupDate,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlightDataBloc, FlightDataState>(
      listener: (context, state) {
        if (state is FlightDataLoaded) {
          setState(() => _expanded = true);
        }
        if (state is FlightDataFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final loading = state is FlightDataLoading;
        final panelData = state is FlightDataLoaded
            ? _FlightPanelView.fromResponse(state.data)
            : null;

        final w = MediaQuery.of(context).size.width * 0.38;

        return Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: loading ? null : _onTap,
              child: _expanded && panelData != null
                  ? SizedBox(
                      height: 110,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: w,
                                child: Row(
                                  children: [
                                    const CustomText(
                                      title: 'ETA',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0XFF606060),
                                      height: 1,
                                      letterSpacing: 1,
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                      'assets/booking_detail/arrival_icon.svg',
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: w,
                                child: Row(
                                  children: [
                                    CustomText(
                                      title: panelData.etaLine,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0XFF606060),
                                      height: 1,
                                      letterSpacing: 1,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  CustomText(
                                    title: panelData.statusLabel,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: panelData.statusColor,
                                    height: 1,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Container(
                                height: 3,
                                width: w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: panelData.statusColor,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  CustomText(
                                    title: panelData.terminalLine,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0XFF606060),
                                    height: 1,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: w,
                                child: const Row(
                                  children: [
                                    CustomText(
                                      title: 'STA',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0XFF606060),
                                      height: 1,
                                      letterSpacing: 1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: w,
                                child: Row(
                                  children: [
                                    CustomText(
                                      title: panelData.staLine,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0XFF606060),
                                      height: 1,
                                      letterSpacing: 1,
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                      'assets/booking_detail/departure_icon.svg',
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          Column(
                            children: [
                              CustomText(
                                title: panelData.depCode,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0XFF606060),
                                height: 1,
                              ),
                              const DottedLine(
                                direction: Axis.vertical,
                                lineLength: 75,
                                lineThickness: 1.5,
                                dashLength: 3.0,
                                dashColor: Colors.transparent,
                                dashRadius: 0.0,
                                dashGapLength: 3.0,
                                dashGapColor: Colors.black,
                                dashGapRadius: 0.0,
                              ),
                              CustomText(
                                title: panelData.arrCode,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0XFF606060),
                                height: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10),
                      height: 38,
                      alignment: Alignment.center,
                      decoration: CustomDecorations().baseBackgroundDecoration(
                        10.0,
                        1.0,
                        Colors.white,
                        const Color(0XFFFB4156),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (loading)
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0XFFFB4156),
                              ),
                            )
                          else ...[
                            SvgPicture.asset('assets/booking_detail/flight_icon.svg'),
                            const SizedBox(width: 5),
                            const CustomText(
                              title: 'Flight Status',
                              color: Color(0XFFFB4156),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              height: 1,
                            ),
                          ],
                        ],
                      ),
                    ),
            ),
            _expanded ? Container() : const SizedBox(height: 45),
          ],
        );
      },
    );
  }
}
