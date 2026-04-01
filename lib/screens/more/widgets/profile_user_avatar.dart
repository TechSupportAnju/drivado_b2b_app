import 'package:drivado_b2b_app/models/user_data_extensions.dart';
import 'package:drivado_b2b_app/models/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Avatar from [UserData.profilePicture] when URL is present; else default SVG.
class ProfileUserAvatar extends StatelessWidget {
  final UserData? user;
  final double size;

  const ProfileUserAvatar({
    super.key,
    required this.user,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final u = user;
    if (u != null && u.hasProfilePhotoUrl) {
      return ClipOval(
        child: Image.network(
          u.profilePicture!.trim(),
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _fallback(),
        ),
      );
    }
    return _fallback();
  }

  Widget _fallback() {
    return SvgPicture.asset(
      'assets/more/profile.svg',
      width: size,
      height: size,
    );
  }
}
