class TFirebaseException implements Exception { // <-- لاحظ الحرف الكبير (F)
  final String code;

  TFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'permission-denied':
        return "ليس لديك الإذن اللازم للوصول إلى هذه البيانات.";
      case 'not-found':
        return "المستند المطلوب غير موجود.";
      case 'invalid-argument':
        return "البيانات المُدخلة غير صالحة.";
      case 'already-exists':
        return "هذا العنصر موجود مسبقًا.";
      case 'unavailable':
        return "الخدمة غير متاحة حاليًا، حاول مرة أخرى لاحقًا.";
      case 'unauthenticated':
        return "يجب تسجيل الدخول أولاً.";
      case 'resource-exhausted':
        return "تم تجاوز حد الاستخدام، حاول لاحقًا.";
      case 'cancelled':
        return "تم إلغاء العملية.";
      case 'aborted':
        return "تم إحباط العملية.";
      case 'failed-precondition':
        return "لم يتم استيفاء الشروط المطلوبة.";
      default:
        return "حدث خطأ غير معروف في Firebase: $code";
    }
  }
      
    }
  
class TPlatformException implements Exception { // <-- لاحظ الحرف الكبير (P)
  final String code;

  TPlatformException(this.code);

  String get message {
    return 'Platform Error: $code';
  }
}