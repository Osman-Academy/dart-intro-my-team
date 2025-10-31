class Validators {
  static String? validateUsername(String username) {
    if (username.isEmpty) return 'Username cannot be empty';
    if (username.length < 3) return 'Username must be at least 3 characters';
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) return 'Password cannot be empty';
    if (password.length < 4) return 'Password must be at least 4 characters';
    return null;
  }

  static String? validatePrice(double? price) {
    if (price == null || price <= 0) return 'Price must be greater than zero';
    return null;
  }
}
