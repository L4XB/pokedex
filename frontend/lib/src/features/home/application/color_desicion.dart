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
    case 'bug':
      return const Color.fromARGB(255, 122, 194, 74).withOpacity(0.7);
    case 'ground':
      return const Color.fromARGB(255, 149, 119, 63).withOpacity(0.7);
    case 'poison':
      return const Color.fromARGB(255, 161, 103, 197).withOpacity(0.7);
    case 'fairy':
      return const Color.fromARGB(255, 236, 158, 239).withOpacity(0.7);
    case 'fighting':
      return const Color.fromARGB(255, 227, 159, 71).withOpacity(0.7);
    case 'psychic':
      return const Color.fromARGB(255, 168, 88, 224).withOpacity(0.7);
    case 'ghost':
      return const Color.fromARGB(109, 122, 100, 232).withOpacity(0.7);
    case 'ice':
      return const Color.fromARGB(255, 65, 234, 229).withOpacity(0.7);
    case 'dark':
      return const Color.fromARGB(198, 24, 30, 30).withOpacity(0.7);
    default:
      return Colors.grey.withOpacity(0.7);
  }
}
