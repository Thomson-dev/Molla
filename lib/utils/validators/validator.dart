class TValidator {
  static String? validateRequired(String? value, {String field = 'Field'}) {
    if (value == null || value.trim().isEmpty) return '$field is required.';
    return null;
  }

  static String? validateEmail(String? value) {
    final msg = validateRequired(value, field: 'Email');
    if (msg != null) return msg;

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value!.trim())) return 'Invalid email address.';
    return null;
  }

  static String? validatePassword(String? value, {int min = 6}) {
    final msg = validateRequired(value, field: 'Password');
    if (msg != null) return msg;

    if (value!.length < min)
      return 'Password must be at least $min characters.';
    final strong = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).+$');
    if (!strong.hasMatch(value)) {
      return 'Password must contain upper, lower, and a number.';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? original) {
    final msg = validateRequired(value, field: 'Confirm password');
    if (msg != null) return msg;

    if (value != original) return 'Passwords do not match.';
    return null;
  }

  static String? validatePhone(String? value) {
    final msg = validateRequired(value, field: 'Phone');
    if (msg != null) return msg;

    final reg = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    if (!reg.hasMatch(value!.trim())) return 'Invalid phone number.';
    return null;
  }

  static String? validateName(String? value, {String field = 'Name'}) {
    final msg = validateRequired(value, field: field);
    if (msg != null) return msg;

    if (value!.trim().length < 2) return '$field is too short.';
    return null;
  }

  static String? validateUsername(String? value) {
    final msg = validateRequired(value, field: 'Username');
    if (msg != null) return msg;

    final reg = RegExp(r'^[a-zA-Z0-9_]{3,}$');
    if (!reg.hasMatch(value!.trim())) {
      return 'Username must be 3+ chars, letters/numbers/underscore only.';
    }
    return null;
  }

  static String? validateOTP(String? value, {int length = 6}) {
    final msg = validateRequired(value, field: 'Code');
    if (msg != null) return msg;

    if (value!.length != length) return 'Code must be $length digits.';
    if (!RegExp(r'^\d+$').hasMatch(value)) return 'Code must be numeric.';
    return null;
  }

  static String? validateAddress(String? value) =>
      validateRequired(value, field: 'Address');

  // Payments
  static String? validateCardNumber(String? value) {
    final msg = validateRequired(value, field: 'Card number');
    if (msg != null) return msg;

    final digits = value!.replaceAll(RegExp(r'\s'), '');
    if (!RegExp(r'^\d{13,19}$').hasMatch(digits)) return 'Invalid card number.';
    if (!_luhnValid(digits)) return 'Invalid card number.';
    return null;
  }

  static String? validateExpiry(String? value) {
    final msg = validateRequired(value, field: 'Expiry date');
    if (msg != null) return msg;

    final reg = RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$'); // MM/YY
    final m = reg.firstMatch(value!.trim());
    if (m == null) return 'Use MM/YY format.';
    final month = int.parse(m.group(1)!);
    final year = 2000 + int.parse(m.group(2)!);
    final now = DateTime.now();
    final last = DateTime(year, month + 1, 0);
    if (last.isBefore(DateTime(now.year, now.month, 1))) return 'Card expired.';
    return null;
  }

  static String? validateCVV(String? value) {
    final msg = validateRequired(value, field: 'CVV');
    if (msg != null) return msg;

    if (!RegExp(r'^\d{3,4}$').hasMatch(value!.trim())) return 'Invalid CVV.';
    return null;
  }

  // Luhn algorithm for card numbers
  static bool _luhnValid(String number) {
    int sum = 0;
    bool alt = false;
    for (int i = number.length - 1; i >= 0; i--) {
      int n = int.parse(number[i]);
      if (alt) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      alt = !alt;
      sum += n;
    }
    return sum % 10 == 0;
  }
}
