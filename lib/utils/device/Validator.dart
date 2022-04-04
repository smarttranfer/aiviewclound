class Validator {
  static bool isValidPhoneNumber(String string) {
    if (string.isEmpty) {
      return false;
    }

    const pattern = r'([0-9])+([0-9]{8,20})\b';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  static bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  static bool isValidSerialNumber(String string) {
    if (string.isEmpty) {
      return false;
    }

    const pattern =
        r'(^[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Za-z0-9]?[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9])';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
}
