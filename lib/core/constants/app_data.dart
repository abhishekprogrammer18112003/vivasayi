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

  static List<dynamic> homeHeaderData = [
    {'title' : "Modern\nAgri" , 'image' : 'assets/drone 1.png'},
    {'title' : "Natural\nAgri" , 'image' : 'assets/planting 1.png'},
    {'title' : "Agri\nMedicines" , 'image' : 'assets/medicine 1.png'},
    {'title' : "Terrace\nGarden" , 'image' : 'assets/terrace 1.png'},
    {'title' : "Articles" , 'image' : 'assets/newspaper 1.png'}
  ];

  static List<String> homeHeader = [
    "Modern Agriculture",
    "Natural Agriculture",
    "Agri Medicines",
    "Terrace Garden",
    "Articles"
  ];


    static List<dynamic> ShopCategory = [
    {'shopCategory'  : "Irrigation" , 'image_url'  : 'assets/nuts.png'},
    {'shopCategory'  : "Nursery" , 'image_url' : 'assets/nuts.png' , },
    {'shopCategory'  : "Manure" , 'image_url' : 'assets/nuts.png'},
    {'shopCategory'  : "Machines" , 'image_url' : 'assets/nuts.png'},
    {'shopCategory'  : "Equips" , 'image_url' :'assets/nuts.png' },
    {'shopCategory'  : "Agri Products" , 'image_url' :'assets/nuts.png' }
  ];
}
