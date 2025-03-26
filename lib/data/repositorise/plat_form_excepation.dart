class TPlatformException implements Exception { // لاحظ الحرف الكبير P
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'network_error':
        return 'فشل الاتصال بالإنترنت.';
      case 'invalid_operation':
        return 'العملية غير مسموحة.';
      default:
        return 'خطأ في النظام: $code';
    }
  }
}