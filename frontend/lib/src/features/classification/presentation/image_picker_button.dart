import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokedex/src/common/utils/utils.dart';
import 'package:pokedex/src/features/classification/data/repositories/classification_repository.dart';

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        File? image = await Utils().pickImageFromGallery();
        if (image != null) {
          String classification =
              await ClassificationRepository().classifiyImage(image);
          print(classification);
        }
      },
      icon: const Icon(Icons.send),
    );
  }
}
