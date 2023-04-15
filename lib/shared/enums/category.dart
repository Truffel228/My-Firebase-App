import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum Category {
  @JsonValue('criminal')
  criminal,
  @JsonValue('accident')
  accident,
  @JsonValue('entertainment')
  entertainment,
  @JsonValue('transport')
  transport,
  @JsonValue('help')
  help,
  @JsonValue('other')
  other,
}

extension ExtCategory on Category {
  String getTitle(BuildContext context) {
    switch (this) {
      case Category.criminal:
        return 'criminal';

      case Category.accident:
        return 'accident';

      case Category.entertainment:
        return 'entertainment';

      case Category.transport:
        return 'transport';

      case Category.help:
        return 'help';

      case Category.other:
        return 'other';
    }
  }
}
