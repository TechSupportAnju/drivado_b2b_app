import 'package:drivado_b2b_app/models/single_company_management_models.dart';
import 'package:drivado_b2b_app/models/user_data_extensions.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_decoration.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/animated_toggle.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/user_company_add_button_widget.dart';
import 'package:drivado_b2b_app/screens/user_management/widget/user_company_list_tile_widget.dart';
import 'package:drivado_b2b_app/services/auth_service.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_company_bloc.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_company_event.dart';
import 'package:drivado_b2b_app/services/user_management/bloc/single_company_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_widgets/appbar_widget.dart';

class UserMangementPage extends StatefulWidget {
  const UserMangementPage({super.key});

  @override
  State<UserMangementPage> createState() => _UserMangementPageState();
}

class _UserMangementPageState extends State<UserMangementPage> {
  /// 1 = Users, 2 = Companies ([AnimatedToggleManagement] callback indices).
  int toggleValue = 1;
  final TextEditingController search = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final u = context.read<UserInformationBloc>().state;
      if (u is UserInformationLoaded) {
        _fetchSingleCompany(u);
      }
    });
  }

  Future<void> _fetchSingleCompany(UserInformationLoaded profile) async {
    if (!mounted) return;
    final token = await AuthService.getAccessToken();
    if (!mounted || token == null || token.isEmpty) return;
    final id = profile.userData.singleCompanyQueryId;
    context.read<SingleCompanyBloc>().add(
          SingleCompanyFetchRequested(id: id, accessToken: token),
        );
  }

  List<CompanyLinkedUser> _filterUsers(SingleCompanyManagementPayload m) {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return List<CompanyLinkedUser>.from(m.users);
    return m.users
        .where((u) => u.userName.toLowerCase().contains(q))
        .toList();
  }

  List<ManagedChildCompany> _filterCompanies(
    SingleCompanyManagementPayload m,
  ) {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return List<ManagedChildCompany>.from(m.childCompanies);
    return m.childCompanies
        .where((c) => c.companyName.toLowerCase().contains(q))
        .toList();
  }

  void _onSearchChanged(String value) {
    setState(() => _searchQuery = value);
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return BlocListener<UserInformationBloc, UserInformationState>(
      listenWhen: (prev, curr) =>
          curr is UserInformationLoaded &&
          (prev is UserInformationLoading ||
              prev is UserInformationInitial ||
              prev is UserInformationError),
      listener: (context, state) {
        if (state is UserInformationLoaded) {
          _fetchSingleCompany(state);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF5F6FA),
        appBar: const CommonAppBar(
          bottomHeight: 10,
        ),
        body: Column(
          children: [
            Container(
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Color(0xff190C0C),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      Container(
                        height: 52,
                        width: screenWidth,
                        decoration: CustomDecorations().baseBackgroundDecoration(
                          10.0,
                          1.0,
                          Colors.white,
                          Colors.transparent,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            search.text.isEmpty
                                ? SvgPicture.asset(
                                    'assets/user_management/search.svg',
                                    height: 18,
                                    colorFilter: const ColorFilter.mode(
                                      Color(0xFF606060),
                                      BlendMode.srcIn,
                                    ),
                                  )
                                : Container(),
                            SizedBox(width: search.text.isEmpty ? 10 : 0),
                            Expanded(
                              child: TextField(
                                controller: search,
                                textAlignVertical: TextAlignVertical.center,
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: const Color(0xFF0D0D0D),
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.plusJakartaSans(
                                    color: const Color(0xFF606060),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  hintText: 'Search',
                                  suffixIconConstraints: const BoxConstraints(),
                                  suffixIcon: search.text.isNotEmpty
                                      ? GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            search.clear();
                                            _onSearchChanged('');
                                          },
                                          child: const Icon(
                                            Icons.clear,
                                            color: Color(0xFF0D0D0D),
                                            size: 20,
                                          ),
                                        )
                                      : null,
                                ),
                                onChanged: _onSearchChanged,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 11.5),
                child: AnimatedToggleManagement(
                  values: const ['Users', 'Companies'],
                  onToggleCallback: (value) {
                    setState(() {
                      toggleValue = value;
                      search.clear();
                      _searchQuery = '';
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SingleCompanyBloc, SingleCompanyState>(
                builder: (context, companyState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (companyState is SingleCompanyLoading)
                        const LinearProgressIndicator(
                          minHeight: 2,
                          color: Color(0xFFFB4156),
                          backgroundColor: Color(0xFFEFF0F6),
                        ),
                      if (companyState is SingleCompanyFailure)
                        Material(
                          color: const Color(0xFFFFF3CD),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: CustomText(
                              title: companyState.message,
                              color: const Color(0xFF856404),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              maxLine: 4,
                            ),
                          ),
                        ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Stack(
                            children: [
                              _buildManagementList(companyState),
                              Positioned(
                                right: 10,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: userCompanyAddButtonWidget(
                                  context,
                                  toggleValue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementList(SingleCompanyState companyState) {
    if (companyState is SingleCompanyInitial) {
      return const Center(
        child: CustomText(
          title: 'Company data loads when your profile is ready.',
          color: Color(0xFF606060),
          fontWeight: FontWeight.w400,
          fontSize: 13,
        ),
      );
    }
    if (companyState is SingleCompanyLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFFB4156)),
      );
    }
    if (companyState is SingleCompanyFailure) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomText(
            title: companyState.message,
            color: const Color(0xFF606060),
            fontWeight: FontWeight.w400,
            fontSize: 13,
            maxLine: 6,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (companyState is! SingleCompanyLoaded) {
      return const SizedBox.shrink();
    }

    final m = companyState.management;
    if (toggleValue == 1) {
      final users = _filterUsers(m);
      if (users.isEmpty) {
        return const Center(
          child: CustomText(
            title: 'No users match your search.',
            color: Color(0xFF606060),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        );
      }
      return ListView.separated(
        separatorBuilder: (_, __) =>
            const Divider(color: Color(0xFFEFF0F6)),
        itemCount: users.length,
        padding: const EdgeInsets.only(top: 10, bottom: 45),
        itemBuilder: (context, index) {
          return userCompanyListTileWidget(
            context,
            users[index].displayTitle,
            1,
          );
        },
      );
    }

    final companies = _filterCompanies(m);
    if (companies.isEmpty) {
      return const Center(
        child: CustomText(
          title: 'No companies match your search.',
          color: Color(0xFF606060),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      );
    }
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(color: Color(0xFFEFF0F6)),
      itemCount: companies.length,
      padding: const EdgeInsets.only(top: 10, bottom: 45),
      itemBuilder: (context, index) {
        return userCompanyListTileWidget(
          context,
          companies[index].displayTitle,
          2,
          company: companies[index],
        );
      },
    );
  }
}
