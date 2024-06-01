import 'package:logger/logger.dart';
class DLoggerHelper{
  static final Logger _logger  = Logger(
    printer: PrettyPrinter(),
    level: Level.debug
  );
  static void debug(String message){
    _logger.d(message);
  }
  static void info(String message){
    _logger.i(message);
  }
  static void warning(String message){
    _logger.w(message);
  }
  static void error(String message, [dynamic errors] ){
    _logger.e(message,error: errors,stackTrace: StackTrace.current);
  }
}
