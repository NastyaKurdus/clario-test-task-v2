final regExpDigit = RegExp(r'[0-9]');
final regExpEmail = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

bool isUpperCase(String ch) {
  return ch == ch.toUpperCase() && ch != ch.toLowerCase();
}

bool strSatisfies(bool Function(String) pred, String str) {
  for (var i = 0; i < str.length; i++) {
    if (pred(str[i])) return true;
  }
  return false;
}

bool strHasUpperCase(String str) => strSatisfies(isUpperCase, str);

bool strHasDigit(String str) => regExpDigit.hasMatch(str);