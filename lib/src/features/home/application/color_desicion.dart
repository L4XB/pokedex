import 'package:flutter/material.dart';

Color getColorForType(String type) {
  switch (type.toLowerCase()) {
    case 'fire':
      return const Color.fromARGB(149, 205, 61, 51);
    case 'water':
      return const Color.fromARGB(141, 78, 158, 224).withOpacity(0.7);
    case 'grass':
      return Colors.green.withOpacity(0.7);
    case 'electric':
      return Colors.yellow.withOpacity(0.7);
    default:
      return Colors.grey.withOpacity(0.7);
  }
}
