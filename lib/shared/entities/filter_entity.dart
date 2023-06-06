import 'package:fire_base_app/shared/enums/enums.dart';
import 'package:flutter/material.dart';

class FilterEntity {
  const FilterEntity({
    required this.category,
    required this.dateTimeRange,
  });

  final Category category;
  final DateTimeRange dateTimeRange;
}
