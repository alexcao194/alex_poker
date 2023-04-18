extension StringExtension on String {
  String title() {
    String result = '';
    if(codeUnitAt(0) >= 'a'.codeUnitAt(0) && codeUnitAt(0) <= 'z'.codeUnitAt(0)) {
      result += String.fromCharCode(codeUnitAt(0) - 32);
    } else {
      result += this[0];
    }
    for(int i = 1; i < length; i++) {
      if(this[i - 1] == ' ' && (codeUnitAt(i) >= 'a'.codeUnitAt(0) && codeUnitAt(i) <= 'z'.codeUnitAt(0))) {
        result += String.fromCharCode(codeUnitAt(i) - 32);
      } else {
        result += this[i];
      }
    }
    return result;
  }

  String join(List<dynamic> list) {
    String result = '';
    for(int i = 0; i < list.length - 1; i++) {
      result += list[i].toString() + this;
    }
    return result + list.last.toString();
  }

  String caption() {
    String result = '';
    if(codeUnitAt(0) >= 'a'.codeUnitAt(0) && codeUnitAt(0) <= 'z'.codeUnitAt(0)) {
      result += String.fromCharCode(codeUnitAt(0) - 32);
    } else {
      result += this[0];
    }
    return result + substring(1);
  }
}