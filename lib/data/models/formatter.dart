import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    final onlyDate = DateFormat('dd/MM/yyyy').format(date);
    final onlyTime = DateFormat('hh:mm ').format(date);
    return '$onlyDate at $onlyTime';

  }

  static String formatCurrency(double amount) {
     
      return NumberFormat.currency(locale: 'en_EG', symbol: '\$').format(amount);
  
  }

  static String formatPhonenumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7)}';
    }
    return phoneNumber;
  }
}
