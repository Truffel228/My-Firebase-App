import 'package:fire_base_app/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MapCommentShimmer extends StatelessWidget {
  const MapCommentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 48,
        horizontal: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppShimmer(
                    width: 100,
                  ),
                  SizedBox(height: 4),
                  AppShimmer(
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppShimmer(
                    width: 120,
                  ),
                  SizedBox(height: 4),
                  AppShimmer(
                    width: 180,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AppShimmer(width: 200),
              SizedBox(height: 4),
              AppShimmer(
                width: double.infinity,
                height: 100,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              AppShimmer(
                width: 80,
                height: 80,
              ),
              SizedBox(width: 8),
              AppShimmer(
                width: 80,
                height: 80,
              ),
              SizedBox(width: 8),
              AppShimmer(
                width: 80,
                height: 80,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
