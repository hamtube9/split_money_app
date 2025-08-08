import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogUtils {
  static final _logger = Logger(
    level: logLevel(),
    printer: PrettyPrinter(
      methodCount: 0,
      lineLength: 150,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      printEmojis: true,
    ),
  );

  static Level logLevel() {
    if (kReleaseMode) {
      return Level.off;
    }
    return Level.trace;
  }

  void info(dynamic message) => _logger.i('[INFO] $message');

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e('[ERROR] $message', error: error, stackTrace: stackTrace);

  String i(String msg) {
    debugPrint('[LOG INFO] - $msg');
    return msg;
  }
}
