import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';

import 'colored_path.dart';
import 'path_painter.dart';

class DrawingArea extends StatefulWidget {
  final int selectedColorIndex;

  DrawingArea(this.selectedColorIndex, {super.key});

  @override
  _DrawingAreaState createState() => _DrawingAreaState();
}

class _DrawingAreaState extends State<DrawingArea> {
  var points = <Offset>[];

  ColoredPath get path =>
      ColoredPath(colorIndex: widget.selectedColorIndex, points: points);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        addPoint(details.globalPosition);
      },
      onPanStart: (details) {
        addPoint(details.globalPosition);
      },
      onPanEnd: (details) {
        Hive.box<ColoredPath>('sketch').add(path);
        setState(() {
          points = [];
        });
      },
      child: CustomPaint(size: Size.infinite, painter: PathPainter(path)),
    );
  }

  void addPoint(Offset point) {
    final renderBox = context.findRenderObject() as RenderBox;
    setState(() {
      points = [...points, renderBox.globalToLocal(point)];
    });
  }
}
