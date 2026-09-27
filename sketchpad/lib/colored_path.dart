import 'package:flutter/material.dart';

class ColoredPath {
  static const colors = [
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
  ];

  final int colorIndex;
  final List<Offset> points;

  const ColoredPath({required this.colorIndex, required this.points});

  Color get color => colors[colorIndex];
}
