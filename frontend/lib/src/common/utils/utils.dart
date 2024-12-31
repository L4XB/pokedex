import 'dart:io';

import 'package:image_picker/image_picker.dart';

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
      return "#000$id";
    }
    if (id.length == 2) {
      return "#00$id";
    }
    if (id.length == 3) {
      return "#0$id";
    }
    if (id.length == 4) {
      return "#$id";
    }
    return "#0000";
  }

  Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }

    return null;
  }
}
