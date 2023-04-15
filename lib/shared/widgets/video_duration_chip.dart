import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';

class VideoDurationChip extends StatelessWidget {
  const VideoDurationChip({
    Key? key,
    required this.durationSec,
  }) : super(key: key);

  final int durationSec;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.blackColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _formatTime(durationSec),
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: AppColors.whiteColor),
      ),
    );
  }

  String _formatTime(int seconds) {
    if (seconds >= 60) {
      final min = (seconds / 60).floor();
      final sec = seconds.remainder(60).toString().padLeft(2, '0');
      return '$min:$sec';
    }
    final sec = seconds.toString().padLeft(2, '0');
    return '0:$sec';
  }
}
