import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    Key? key,
    required this.width,
    this.height = 20,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.greyColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
