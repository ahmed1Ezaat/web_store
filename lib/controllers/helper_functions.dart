import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/emums.dart';

class THelperFunctions {
  static DateTime getStartOfWeek(DateTime date) {
    final int daysUntilMonday = date.weekday - 1;
    final DateTime startOfWeek = date.subtract(Duration(days: daysUntilMonday));
    return DateTime(
        startOfWeek.year, startOfWeek.month, startOfWeek.day, 0, 0, 0, 0, 0);
  }

  static Color getOrderStatusColor(OrderStatus value) {
    if (OrderStatus.pending == value) {
      return Colors.blue;
    } else if (OrderStatus.processing == value) {
      return Colors.orange;
    } else if (OrderStatus.shipped == value) {
      return Colors.purple;
    } else if (OrderStatus.delivered == value) {
      return Colors.green;
    } else if (OrderStatus.cancelled == value) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  static Color? getColor(String value) {
    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else {
      return null;
    }
  }

  // Removed duplicate getColor function

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLines) {
    if (text.length <= maxLines) {
      return text;
    } else {
      return '${text.substring(0, maxLines)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getformattedOrederDate(DateTime date,
      {String format = 'dd-MMM-YYYY'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }
}
