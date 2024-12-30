import 'package:flutter/material.dart';

Color getColorForType(String type) {
  switch (type.toLowerCase()) {
    case 'fire':
      return const Color.fromARGB(200, 215, 66, 55);
    case 'water':
      return const Color.fromARGB(141, 78, 158, 224).withOpacity(0.7);
    case 'grass':
      return const Color.fromARGB(255, 44, 176, 112).withOpacity(0.7);
    case 'electric':
      return const Color.fromARGB(255, 194, 179, 49).withOpacity(0.7);
    default:
      return Colors.grey.withOpacity(0.7);
  }
}
