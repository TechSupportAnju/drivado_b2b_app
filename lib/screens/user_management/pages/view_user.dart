import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/credit_limit_widget.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/custom_switch.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/table_data_widget.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_user_bloc.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_user_event.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewUserPage extends StatefulWidget {
  const ViewUserPage({super.key, required this.userId});

  final String userId;

  @override
  State<ViewUserPage> createState() => _ViewUserPageState();
}

class _ViewUserPageState extends State<ViewUserPage> {
  bool status = true;
  final TextEditingController search = TextEditingController();
  final TextEditingController markup = TextEditingController();
  final TextEditingController discount = TextEditingController();

  Future<void> _retryFetch() async {
    final token = await AuthService.getAccessToken() ?? '';
    if (!mounted) return;
    context.read<SingleUserBloc>().add(
          SingleUserFetchRequested(
            userId: widget.userId,
            accessToken: token,
          ),
        );
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    markup.dispose();
    discount.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xff190C0C),
            ),
            alignment: Alignment.topLeft,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 20, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                          'assets/user_management/back.svg'),
                    ),
                    const Spacer(),
                    BlocBuilder<SingleUserBloc, SingleUserState>(
                      builder: (context, state) {
                        String title = '-';
                        String subtitle = '—';
                        if (state is SingleUserLoaded) {
                          final d = state.detail;
                          title = d.firstName.isNotEmpty ? d.firstName : '-';
                          subtitle = d.dash(d.email);
                        }
                        return Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: CustomText(
                                    textAlign: TextAlign.right,
                                    title: title,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: CustomText(
                                textAlign: TextAlign.right,
                                title: subtitle,
                                color: const Color(0xFFAEB1C1),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    SvgPicture.asset(
                      'assets/user_management/userPic.svg',
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SingleUserBloc, SingleUserState>(
              builder: (context, state) {
                if (state is SingleUserLoading ||
                    state is SingleUserInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SingleUserFailure) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            title: state.message,
                            textAlign: TextAlign.center,
                            color: const Color(0xFF606060),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: _retryFetch,
                            child: const CustomText(
                              title: 'Retry',
                              color: Color(0xff190C0C),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is! SingleUserLoaded) {
                  return const SizedBox.shrink();
                }

                final d = state.detail;

                return Container(
                  height: screenSize.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 15,
                            ),
                            decoration: CustomDecorations()
                                .baseBackgroundDecoration(
                              12.0,
                              1.0,
                              const Color(0xffffffff),
                              const Color(0xFFE6E8E7),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const CustomText(
                                      title: 'User Details',
                                      color: Color(0xFF0D0D0D),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    const Spacer(),
                                    CustomSwitch(
                                      value: status,
                                      onChanged: (value) {
                                        setState(() {
                                          status = value;
                                        });
                                      },
                                      isText: true,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/user_management/userPic.png'),
                                        ),
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(
                                          color: const Color(0xFF0D0D0D),
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          title: d.dash(d.firstName),
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0D0D0D),
                                          fontSize: 16,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            CustomText(
                                              title: d.dash(d.role),
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF434557),
                                              fontSize: 12,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: screenWidth,
                                  child: Row(
                                    children: [
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          dividerTheme:
                                              const DividerThemeData(
                                            thickness: 0,
                                            space: 0,
                                          ),
                                          dataTableTheme:
                                              const DataTableThemeData(
                                            dividerThickness: 0,
                                          ),
                                        ),
                                        child: DataTable(
                                          horizontalMargin: 0.0,
                                          dividerThickness: 0.0,
                                          headingRowHeight: 25,
                                          dataRowMinHeight: 25,
                                          dataRowMaxHeight: 25,
                                          columnSpacing: 5,
                                          border: TableBorder.all(
                                            color: Colors.transparent,
                                          ),
                                          columns: [
                                            DataColumn(
                                              label: CustomDataTableRow(
                                                title: 'Email ID',
                                                color: const Color(0xFF606060),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                image:
                                                    'assets/user_management/email.svg',
                                              ),
                                            ),
                                            DataColumn(
                                              label: SizedBox(
                                                width: screenWidth * 0.42,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(width: 20),
                                                    CustomText(
                                                      title: d.dash(d.email),
                                                      color: const Color(
                                                          0xFF0D0D0D),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                          rows: [
                                            DataRow(
                                              cells: [
                                                DataCell(
                                                  CustomDataTableRow(
                                                    title: 'Mob. number',
                                                    color: const Color(
                                                        0xFF606060),
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    fontSize: 12,
                                                    image:
                                                        'assets/user_management/phone.svg',
                                                  ),
                                                ),
                                                DataCell(
                                                  SizedBox(
                                                    width: screenWidth * 0.42,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            width: 20),
                                                        CustomText(
                                                          title:
                                                              d.dash(d.phone),
                                                          color: const Color(
                                                              0xFF0D0D0D),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            DataRow(
                                              cells: [
                                                DataCell(
                                                  CustomDataTableRow(
                                                    title: 'Language',
                                                    color: const Color(
                                                        0xFF606060),
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    fontSize: 12,
                                                    image:
                                                        'assets/user_management/langAccount.svg',
                                                  ),
                                                ),
                                                DataCell(
                                                  SizedBox(
                                                    width: screenWidth * 0.42,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            width: 20),
                                                        CustomText(
                                                          title: d.dash(
                                                              d.language),
                                                          color: const Color(
                                                              0xFF0D0D0D),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            DataRow(
                                              cells: [
                                                DataCell(
                                                  CustomDataTableRow(
                                                    title: 'Currency',
                                                    color: const Color(
                                                        0xFF606060),
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    fontSize: 12,
                                                    image:
                                                        'assets/user_management/currAccount.svg',
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    width:
                                                        screenWidth * 0.42,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            width: 20),
                                                        CustomText(
                                                          title: d.dash(
                                                              d.currency),
                                                          color: const Color(
                                                              0xFF0D0D0D),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                          child: CreditLimitWidget(
                            title1: 'Total unpaid booking',
                            title2: 'Available credit limit',
                            value1: d.dash(d.totalUnpaidLabel.toString()),
                            value2: d.dash(d.availableCreditLabel.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
