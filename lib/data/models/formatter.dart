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

  static String internationalForwardPhoneNumber(String phoneNumber) {
  // 1. إزالة جميع الأحرف غير الرقمية
  var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

  if (digitsOnly.isEmpty) return phoneNumber; // حماية ضد بيانات فارغة

  // 2. استخراج رمز الدولة (مثال: 20 لمصر، 1 لأمريكا)
  String countryCode = '+${digitsOnly.substring(0, 2)}'; // تغيير 2 لطول رمز الدولة
  digitsOnly = digitsOnly.substring(2);

  // 3. بناء الرقم المنسق
  final formattedNumber = StringBuffer();
  formattedNumber.write('$countryCode '); // +20 1234...

  // 4. تنسيق الأرقام المتبقية
  int groupSize = 3; // حجم المجموعة الافتراضي
  int i = 0;
  
  while (i < digitsOnly.length) {
    int end = i + groupSize;
    if (end > digitsOnly.length) end = digitsOnly.length;
    
    formattedNumber.write(digitsOnly.substring(i, end));
    
    if (end < digitsOnly.length) formattedNumber.write(' ');
    i = end;
  }

  return formattedNumber.toString();
}
}
