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

  String transformIdToRightFormat(String id) {
    if (id.length == 1) {
      return "#00$id";
    }
    if (id.length == 2) {
      return "#0$id";
    }
    if (id.length == 3) {
      return "#$id";
    }
    return "#0000";
  }
}
