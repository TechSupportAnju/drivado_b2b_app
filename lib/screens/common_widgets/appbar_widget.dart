import 'package:drivado_b2b_app/models/user_data_extensions.dart';
import 'package:drivado_b2b_app/screens/common_widgets/custom_text.dart';
import 'package:drivado_b2b_app/screens/common_widgets/notification_widget.dart';
import 'package:drivado_b2b_app/screens/more/widgets/profile_user_avatar.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_bloc.dart';
import 'package:drivado_b2b_app/services/user_info_service/bloc/user_information_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? bottomWidget;
  final double bottomHeight;

  const CommonAppBar({
    super.key,
    this.bottomWidget,
    this.bottomHeight = 0,
  });
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + bottomHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF190C0C),
      elevation: 0.0,
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight, 
      title: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: BlocBuilder<UserInformationBloc, UserInformationState>(
              builder: (context, state) {
                if (state is UserInformationLoaded) {
                  return ProfileUserAvatar(
                    user: state.userData,
                    size: 40,
                  );
                }
                return SvgPicture.asset('assets/home/profile_icon.svg');
              },
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: BlocBuilder<UserInformationBloc, UserInformationState>(
              builder: (context, state) {
                final String line1;
                final String line2;
                if (state is UserInformationLoaded) {
                  final u = state.userData;
                  line1 = 'Hello, ${u.shortGreetingName}';
                  line2 = u.email ?? '—';
                } else if (state is UserInformationLoading) {
                  line1 = 'Hello';
                  line2 = 'Loading…';
                } else if (state is UserInformationError) {
                  line1 = 'Hello';
                  line2 = '—';
                } else {
                  line1 = 'Hello';
                  line2 = '—';
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: line1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.4,
                    ),
                    const SizedBox(height: 2),
                    CustomText(
                      title: line2,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ],
                );
              },
            ),
          ),
          const NotificationIconButton(),
        ],
      ),
      bottom: bottomWidget != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomHeight),
              child: bottomWidget!,
            )
          : null,
    );
  }
}