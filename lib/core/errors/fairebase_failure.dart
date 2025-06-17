class FirebaseFailure {
  final String message;

  FirebaseFailure({required this.message});

  factory FirebaseFailure.fromCode(String code) {

    switch (code) {
      
      case 'invalid-email':
        return FirebaseFailure(message: 'Email address is not valid.');
      case 'user-disabled':
        return FirebaseFailure(message: 'This user has been disabled.');
      case 'user-not-found':
        return FirebaseFailure(
            message: 'No user found with this email.');
      case 'wrong-password':
        return FirebaseFailure(message: 'Wrong password provided.');
      case 'email-already-in-use':
        return FirebaseFailure(
            message: 'This email is already in use.');
      case 'operation-not-allowed':
        return FirebaseFailure(message: 'Operation not allowed.');
      case 'weak-password':
        return FirebaseFailure(message: 'Password is too weak.');
      case 'user-mismatch':
        return FirebaseFailure(message: 'User Mismatch.');
      case 'invalid-credential':
        return FirebaseFailure(message: 'Incorrect Email or Password.');
      case 'network-request-failed':
        return FirebaseFailure(message: 'No Internet Connection.');
      case 'permission-denied':
        return FirebaseFailure(
            message: 'You don’t have permission to perform this action.');
      case 'not-found':
        return FirebaseFailure(message: 'Requested data not found.');
      case 'already-exists':
        return FirebaseFailure(message: 'This item already exists.');
      case 'cancelled':
        return FirebaseFailure(message: 'Operation was cancelled.');
      case 'deadline-exceeded':
        return FirebaseFailure(
            message: 'Request took too long. Try again.');
      case 'resource-exhausted':
        return FirebaseFailure(
            message: 'Quota exceeded. Try again later.');
      case 'unavailable':
        return FirebaseFailure(
            message: 'Service is currently unavailable.');
      case 'data-loss':
        return FirebaseFailure(message: 'Data loss occurred.');
      case 'unauthenticated':
        return FirebaseFailure(message: 'User is not authenticated.');
      default:
        return FirebaseFailure(
            message: 'An unknown error occurred: $code');
    }
  }
}
