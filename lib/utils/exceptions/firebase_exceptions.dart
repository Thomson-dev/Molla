class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred.';
      case 'object-not-found':
        return 'The requested object was not found.';
      case 'bucket-not-found':
        return 'The specified storage bucket was not found.';
      case 'project-not-found':
        return 'The specified Firebase project was not found.';
      case 'quota-exceeded':
        return 'Quota for this Firebase project has been exceeded.';
      case 'unauthenticated':
        return 'User is not authenticated.';
      case 'unauthorized':
        return 'The user is not authorized to perform this operation.';
      case 'retry-limit-exceeded':
        return 'The operation has failed due to too many attempts.';
      case 'invalid-checksum':
        return 'The file checksum does not match.';
      case 'canceled':
        return 'The operation was canceled.';
      case 'invalid-event-name':
        return 'The event name is invalid.';
      case 'invalid-url':
        return 'The URL is invalid.';
      case 'invalid-argument':
        return 'An invalid argument was provided.';
      case 'no-default-bucket':
        return 'No default bucket has been set.';
      case 'cannot-slice-blob':
        return 'The blob cannot be sliced.';
      case 'server-file-wrong-size':
        return 'The uploaded file size does not match the expected file size.';
      default:
        return 'A Firebase error occurred. Please try again.';
    }
  }
}

class TFormatException implements Exception {
  const TFormatException();

  String get message => 'The provided data is in an invalid format.';
}

class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'network_error':
        return 'Network error occurred. Please check your connection.';
      case 'sign_in_failed':
        return 'Sign in failed. Please try again.';
      case 'sign_in_canceled':
        return 'Sign in was canceled.';
      default:
        return 'A platform error occurred. Please try again.';
    }
  }
}
