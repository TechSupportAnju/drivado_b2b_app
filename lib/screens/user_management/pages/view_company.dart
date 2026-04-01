import 'package:drivado_b2b_app/models/single_company_management_models.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/credit_limit_widget.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/custom_booking_summary_row.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/custom_switch.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/user_company_add_button_widget.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/user_company_list_tile_widget.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/view_company_side_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewCompanyPage extends StatefulWidget {
  const ViewCompanyPage({super.key, required this.company});

  final ManagedChildCompany company;

  @override
  State<ViewCompanyPage> createState() => _ViewCompanyPageState();
}

class _ViewCompanyPageState extends State<ViewCompanyPage> {
  bool status = true;
  int isSelect = 0;
  final TextEditingController search = TextEditingController();
  List<CompanyLinkedUser> _filteredUsers = [];
  List<ManagedChildCompany> _filteredCompanies = [];

  String _dash(String? s) {
    if (s == null || s.trim().isEmpty) return '—';
    return s;
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
    _filteredUsers = List.from(widget.company.users);
    _filteredCompanies = List.from(widget.company.childCompanies);
  }

  void _applySearch() {
    final q = search.text.toLowerCase().trim();
    setState(() {
      if (q.isEmpty) {
        _filteredUsers = List.from(widget.company.users);
        _filteredCompanies = List.from(widget.company.childCompanies);
      } else {
        _filteredUsers = widget.company.users
            .where((u) => u.userName.toLowerCase().contains(q))
            .toList();
        _filteredCompanies = widget.company.childCompanies
            .where((c) => c.companyName.toLowerCase().contains(q))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    search.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final c = widget.company;

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
                      child: SvgPicture.asset('assets/user_management/back.svg'),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: CustomText(
                                textAlign: TextAlign.right,
                                title: c.companyName,
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
                            title: _dash(c.email),
                            color: const Color(0xFFAEB1C1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Image.asset(
                      'assets/user_management/userPic.png',
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: screenSize.height,
                    decoration: CustomDecorations().baseBackgroundDecoration(
                      10.0,
                      1.0,
                      const Color(0xffffffff),
                      const Color(0xFFEDF1F3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          CustomViewCompanyWidget(
                            title: 'Profile',
                            icon: 'assets/user_management/profileUnsel.svg',
                            onPress: () {
                              setState(() {
                                isSelect = 0;
                              });
                            },
                            isSelect: isSelect,
                            index: 0,
                          ),
                          const SizedBox(height: 25),
                          CustomViewCompanyWidget(
                            title: 'Users',
                            icon: 'assets/user_management/userSel.svg',
                            onPress: () {
                              setState(() {
                                isSelect = 1;
                              });
                              _applySearch();
                            },
                            isSelect: isSelect,
                            index: 1,
                          ),
                          const SizedBox(height: 25),
                          CustomViewCompanyWidget(
                            title: 'Companies',
                            icon: 'assets/user_management/companyUnsel.svg',
                            onPress: () {
                              setState(() {
                                isSelect = 2;
                              });
                              _applySearch();
                            },
                            isSelect: isSelect,
                            index: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: screenSize.width - 67,
                    height: screenSize.height,
                    child: isSelect == 0
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15),
                                  decoration: CustomDecorations()
                                      .draggableSheetDecoration(
                                    12.0,
                                    0.0,
                                    12.0,
                                    0.0,
                                    1.0,
                                    const Color(0xffffffff),
                                    const Color(0xFFE6E8E7),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(
                                            title: 'Company Details',
                                            color: const Color(0xFF0D0D0D),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                          const Spacer(),
                                          CustomSwitch(
                                            isText: true,
                                            value: status,
                                            onChanged: (value) {
                                              setState(() {
                                                status = value;
                                              });
                                            },
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
                                                image:
                                                    AssetImage('assets/logo.png'),
                                                fit: BoxFit.contain,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                color: const Color(0xFFE6E8E7),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                title: c.companyName,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF0D0D0D),
                                                fontSize: 16,
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  CustomText(
                                                    title: _dash(c.email),
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(0xFF606060),
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Column(
                                        children: [
                                          CustomBookingSummaryDataRowWithIcon(
                                            title: 'Website',
                                            desc: _dash(c.website),
                                            image:
                                                'assets/user_management/website.svg',
                                          ),
                                          const SizedBox(height: 12),
                                          CustomBookingSummaryDataRowWithIcon(
                                            title: 'Mob. number',
                                            desc: '—',
                                            image:
                                                'assets/user_management/phone.svg',
                                          ),
                                          const SizedBox(height: 12),
                                          CustomBookingSummaryDataRowWithIcon(
                                            title: 'GST/VAT',
                                            desc: _dash(c.gstVat),
                                            image:
                                                'assets/user_management/gst.svg',
                                          ),
                                          const SizedBox(height: 12),
                                          CustomBookingSummaryDataRowWithIcon(
                                            title: 'Address',
                                            desc: _dash(c.address),
                                            image:
                                                'assets/user_management/address.svg',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const CreditLimitWidget(
                                  title1: 'Total unpaid booking',
                                  title2: 'Available credit limit',
                                  value1: '—',
                                  value2: '—',
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                decoration: CustomDecorations()
                                    .draggableSheetDecoration(
                                  10.0,
                                  0.0,
                                  10.0,
                                  0.0,
                                  1.0,
                                  Colors.white,
                                  const Color(0xFFEDF1F3),
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/user_management/userPic.png'),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1.5,
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
                                              title: c.companyName,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF0D0D0D),
                                              fontSize: 16,
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                CustomText(
                                                  title: _dash(c.email),
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xFF3A434C),
                                                  fontSize: 12,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      height: 52,
                                      width: screenWidth,
                                      decoration: CustomDecorations()
                                          .draggableSheetDecoration(
                                        10.0,
                                        0.0,
                                        10.0,
                                        0.0,
                                        1.0,
                                        const Color(0xFFF5F6FA),
                                        const Color(0xFFF5F6FA),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          search.text.isEmpty
                                              ? SvgPicture.asset(
                                                  'assets/user_management/search.svg',
                                                  height: 18,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                    Color(0xFF606060),
                                                    BlendMode.srcIn,
                                                  ),
                                                )
                                              : Container(),
                                          SizedBox(
                                            width: search.text.isEmpty ? 10 : 0,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              controller: search,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: const Color(0xFF0D0D0D),
                                              ),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: InputBorder.none,
                                                hintStyle:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: const Color(0xFF606060),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                ),
                                                hintText: 'Search',
                                                suffixIconConstraints:
                                                    const BoxConstraints(),
                                                suffixIcon: search.text.isNotEmpty
                                                    ? GestureDetector(
                                                        behavior: HitTestBehavior
                                                            .translucent,
                                                        onTap: () {
                                                          search.clear();
                                                          _applySearch();
                                                        },
                                                        child: const Icon(
                                                          Icons.clear,
                                                          color: Color(
                                                              0xFF0D0D0D),
                                                          size: 20,
                                                        ),
                                                      )
                                                    : null,
                                              ),
                                              onChanged: (_) {
                                                if (isSelect == 1 ||
                                                    isSelect == 2) {
                                                  _applySearch();
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: CustomDecorations()
                                          .draggableSheetDecoration(
                                        10.0,
                                        0.0,
                                        10.0,
                                        0.0,
                                        1.0,
                                        Colors.white,
                                        const Color(0xFFEDF1F3),
                                      ),
                                      child: ListView.separated(
                                        separatorBuilder: (context, pos) =>
                                            const Divider(
                                          color: Color(0xFFEFF0F6),
                                        ),
                                        itemCount: isSelect == 1
                                            ? _filteredUsers.length
                                            : _filteredCompanies.length,
                                        padding: const EdgeInsets.only(top: 0),
                                        itemBuilder: (context, index) {
                                          if (isSelect == 1) {
                                            return userCompanyListTileWidget(
                                              context,
                                              _filteredUsers[index].userName,
                                              1,
                                              userId: _filteredUsers[index].id,
                                            );
                                          }
                                          final child =
                                              _filteredCompanies[index];
                                          return userCompanyListTileWidget(
                                            context,
                                            child.companyName,
                                            2,
                                            company: child,
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      bottom: 65,
                                      child: userCompanyAddButtonWidget(
                                        context,
                                        isSelect,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
