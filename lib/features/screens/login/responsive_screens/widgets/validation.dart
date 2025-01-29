class TValidator {
  static String? validateEmptyText(String? filedName, String? value) {
    if (value == null || value.isEmpty) {
      return '$filedName is required';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }

    const pattern = r'^[a-zA-Z0-9_-]{3,20}$';

    final regex = RegExp(pattern);

    bool isValid = regex.hasMatch(username);

    if (!isValid) {
      isValid = !username.startsWith('_') &&
          !username.startsWith('-') &&
          !username.endsWith('_') &&
          !username.endsWith('-');
    }
    if (!isValid) {
      return 'Username is not invalid';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return null;
    }
  }

}
