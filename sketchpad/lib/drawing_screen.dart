import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'clear_button.dart';
import 'colored_path.dart';
import 'drawing_area.dart';
import 'path_painter.dart';
import 'undo_button.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  var selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                WatchBoxBuilder(
                  box: Hive.box('sketch'),
                  builder: buildPathsFromBox,
                ),
                DrawingArea(selectedColorIndex),
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Text('powered by Hive'),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < ColoredPath.colors.length; i++)
                    buildColorCircle(i),
                  const ClearButton(),
                  const UndoButton(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildPathsFromBox(BuildContext context, Box box) {
    final paths = box.values.whereType<ColoredPath>();
    return Stack(
      children: <Widget>[
        for (var path in paths)
          CustomPaint(size: Size.infinite, painter: PathPainter(path)),
      ],
    );
  }

  Widget buildColorCircle(int colorIndex) {
    final selected = selectedColorIndex == colorIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColorIndex = colorIndex;
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16),
          height: selected ? 50 : 36,
          width: selected ? 50 : 36,
          color: ColoredPath.colors[colorIndex],
        ),
      ),
    );
  }
}
