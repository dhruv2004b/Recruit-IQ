class Validators {
  static String? email(String? val) {
    if (val == null || val.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!emailRegex.hasMatch(val.trim())) return 'Enter a valid email';
    return null;
  }

  static String? password(String? val) {
    if (val == null || val.isEmpty) return 'Password is required';
    if (val.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? required(String? val, [String fieldName = 'This field']) {
    if (val == null || val.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  static String? name(String? val) {
    if (val == null || val.trim().isEmpty) return 'Name is required';
    if (val.trim().length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  static String? positiveNumber(String? val, [String fieldName = 'Value']) {
    if (val == null || val.isEmpty) return null; // optional
    final n = double.tryParse(val);
    if (n == null) return '$fieldName must be a number';
    if (n < 0) return '$fieldName must be positive';
    return null;
  }

  static String? minLength(String? val, int min, [String fieldName = 'Field']) {
    if (val == null || val.trim().isEmpty) return '$fieldName is required';
    if (val.trim().length < min)
      return '$fieldName must be at least $min characters';
    return null;
  }
}
