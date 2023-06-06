import 'package:cached_network_image/cached_network_image.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required this.avatarUrl,
    this.radius,
  }) : super(key: key);
  final String? avatarUrl;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final diametr =
        radius == null ? MediaQuery.of(context).size.width * 0.4 : radius! * 2;

    if (avatarUrl?.isEmpty ?? true) {
      return Container(
        width: diametr,
        height: diametr,
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
        width: diametr,
        height: diametr,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: diametr,
        height: diametr,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/empty_profile_image.png'),
              fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
        width: diametr,
        height: diametr,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.greyColor,
        ),
      ),
    );
  }
}
