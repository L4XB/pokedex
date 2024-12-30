class Utils {
  String transformTextToRightShape(String text) {
    String reshapedText = "";
    for (int i = 0; i < text.length; i++) {
      if (i == 0) {
        reshapedText = reshapedText + text[i].toUpperCase();
      } else {
        reshapedText = reshapedText + text[i].toLowerCase();
      }
    }
    return reshapedText;
  }
}
