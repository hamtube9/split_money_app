
extension BuildStringExtension<T> on String? {
  String? isEmail(){
    if (this == null || this!.isEmpty) {
      return 'Please enter your email address';
    }
    // A simple regex to check for email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(this!)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(){
    if (this == null || this!.isEmpty) {
      return 'Password can not empty';
    }
    if (this!.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  // Validator for the confirm password field
  String? _validateConfirmPassword(String newPassword) {
    if (this == null || this!.isEmpty) {
      return 'Please confirm your new password.';
    }
    if (this != newPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }
}