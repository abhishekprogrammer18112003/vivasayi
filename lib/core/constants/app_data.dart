import 'dart:ui';

import 'package:intl/intl.dart';

class AppData {
  static String lang = "en";

  static Color hexToColor(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  //Convert to Argb
  static List<int> hexToRgba(String hexColor) {
    Color color = hexToColor(hexColor);
    return [color.red, color.green, color.blue, (color.alpha * 255).toInt()];
  }

  //Format Date and Time
  static String FormatDate(String a) {
    DateTime dateTime = DateTime.parse(a);

    String formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);

    return formattedDate;
  }

  static String FormatTime(String a) {
    DateTime dateTime = DateTime.parse(a);

    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  static List<String> homeHeaderData = [
    "Modern\nAgri",
    "Natural\nAgri",
    "Agri\nMedicines",
    "Terrace\nGarden",
    "Articles"
  ];

  static List<String> homeHeader = [
    "Modern Agriculture",
    "Natural Agriculture",
    "Agri Medicines",
    "Terrace Garden",
    "Articles"
  ];
}
