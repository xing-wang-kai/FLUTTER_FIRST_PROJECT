import 'package:flutter/material.dart';

class LevelStars extends StatelessWidget {
  const LevelStars({
    super.key,
    required this.star,
  });

  final int star;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_border_purple500,
          size: 15,
          color: (star >= 1) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star_border_purple500,
          size: 15,
          color: (star >= 2) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star_border_purple500,
          size: 15,
          color: (star >= 3) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star_border_purple500,
          size: 15,
          color: (star >= 4) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star_border_purple500,
          size: 15,
          color: (star >= 5) ? Colors.blue : Colors.blue[100],
        ),

      ],
    );
  }
}
