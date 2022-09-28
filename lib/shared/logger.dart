import 'package:logger/logger.dart';

final logger = Logger();

class CustomPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final message = event.message;

    return [color!('$message')];
  }
}
