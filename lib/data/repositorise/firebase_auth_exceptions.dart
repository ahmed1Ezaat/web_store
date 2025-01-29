class TfirebaseAuthException implements Exception {
  final String code;

  TfirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email is already in use by another account.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-not-found':
        return 'There is no user record corresponding to this identifier. The user may have been deleted.';
      case 'wrong-password':
        return 'The password is invalid or the user does not have a password.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      case 'too-many-requests':
        return 'We have blocked all requests from this device due to unusual activity. Try again later.';
      case 'operation-not-allowed':
        return 'Password sign-in is disabled for this project.';
      case 'network-request-failed':
        return 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.';
      default:
        return 'Something went wrong. Please try again';
      
    }
  }
}
