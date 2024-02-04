bool isValidPasswords(password) {
  return password.isNotEmpty &&
      password.length >= 7 &&
      isValidPasswordPattern(password);
}

bool isValidEmails(email) {
  return email.isNotEmpty && isValidEmailPattern(email);
}

bool isValidPasswordPattern(password) {
  Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
  RegExp regex = RegExp(pattern.toString());
  return regex.hasMatch(password);
}

bool isValidEmailPattern(email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  return regex.hasMatch(email);
}

bool passwordHasMinLength(String password) {
  return password.length >= 8;
}

bool passwordHasSpecialCharacter(String password) {
  return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
}