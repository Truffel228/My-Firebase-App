import 'package:cached_network_image/cached_network_image.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key, required this.avatarUrl}) : super(key: key);
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width * 0.4;
    if (avatarUrl?.isEmpty ?? true) {
      return Container(
        width: radius,
        height: radius,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/empty_profile_image.png'),
              fit: BoxFit.cover),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: avatarUrl!,
      imageBuilder: (context, imageProvider) => Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: radius,
        height: radius,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/empty_profile_image.png'),
              fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
        width: radius,
        height: radius,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.greyColor,
        ),
      ),
    );
  }
}
