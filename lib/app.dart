import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  /// Enable for Test
  static const IMAGE_BASE_URL = kReleaseMode
      ? 'https://api.ieducationbd.com/'
      : 'https://api.ieducationbd.com/';
  static const API_BASE_URL = kReleaseMode
      ? 'https://api.ieducationbd.com/'
      : 'https://api.ieducationbd.com/';
  // static const appID = 'c903ae36c3634edf94dbdd2b986f2ab9';
  static const DEVICE_TYPE_PHONE = 'phone';
  static const DEVICE_TYPE_TABLET = 'tablet';

  ///User Type
  static const USER_TYPE_STUDENT = "student";
  static const USER_TYPE_TEACHER = "teacher";
  static const USER_TYPE_MANAGER = "manager";
  static const USER_TYPE_OWNER = "owner";
  static String removeDecimalZeroFormat(double v) {
    NumberFormat formatter = NumberFormat();
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 2;
    return formatter.format(v);
  }

  static String getValueOrZero(String value) {
    return value == 'null' ? '0' : value;
  }

  static String nullString(String value) {
    return value == 'null' ? '' : value;
  }

  static String doubleToInt(String value) {
    return value == 'null' ? '0' : value;
  }

  static String getNumberWithCommaSeparator(String value) {
    return value == 'null' ? '0' : removeDecimalZeroFormat(double.parse(value));
  }

  static Future<void> launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void printLog(dynamic content) {
    print(
        '----------------------------------------------------------------------------');
    print('| $content ');
    print(
        '----------------------------------------------------------------------------');
  }
}
