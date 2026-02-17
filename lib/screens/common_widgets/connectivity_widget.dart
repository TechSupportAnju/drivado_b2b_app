import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_buttons.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConnectivityWidget extends StatefulWidget {
  const ConnectivityWidget({super.key});

  @override
  State<ConnectivityWidget> createState() => _ConnectivityWidgetState();
}

class _ConnectivityWidgetState extends State<ConnectivityWidget> {
  bool isConnectivity = false;

  final Connectivity _connectivity = Connectivity();
  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  Future<List<ConnectivityResult>> checkConnectivity() async {
    return _connectivity.checkConnectivity();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active || isConnectivity) {
          final results = snapshot.data ?? [];
          final hasConnection = results.isNotEmpty && !results.contains(ConnectivityResult.none);

          if (!hasConnection) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F6FA),
                          borderRadius: BorderRadius.circular(60)
                      ),
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.wifi_off, color: Colors.black),),
                    SizedBox(height: 12),
                    CustomText(title: "No Internet Connection",
                      textDecoration: TextDecoration.none,
                      fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black,
                    ),
                    SizedBox(height: 12),
                    CustomText(
                      title: "It looks like you're not connected to the internet. Please check your connection and try again.",
                      textAlign: TextAlign.center,
                      height: 1.4,
                      textDecoration: TextDecoration.none,
                      fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF606060),
                    ),
                    SizedBox(height: 32),
                    CustomButtons(
                        onTap: () {},
                        title: 'RETRY',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      isIcon: true,
                    ),
                    Spacer(),
                    Container(
                      height: 40,
                      decoration: CustomDecorationsCards().baseBackgroundShadow(smooth: 1.0,radius: 8.0, borderColor: Colors.black.withOpacity(0.1)),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/globe.svg'),
                          SizedBox(width: 12,),
                          CustomText(
                            title: "Network status",
                            textDecoration: TextDecoration.none,
                            textAlign: TextAlign.center,
                            fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF0D0D0D),
                          ),
                          Spacer(),
                          CustomText(
                            textDecoration: TextDecoration.none,
                            title: "•  Disconnected",
                            textAlign: TextAlign.center,
                            fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.secondary,
                          ),
                          SizedBox(width: 8,),
                          SvgPicture.asset('assets/close-circle.svg'),

                        ],
                      ),
                    ),
                    SizedBox(height: 58,)
                  ],
                ),
              ),
            );
          }
          else {
            return const SizedBox.shrink();
          }
        }
        return const SizedBox.shrink();
      },
    );

  }
}
