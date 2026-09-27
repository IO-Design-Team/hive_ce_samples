import 'package:flutter/rendering.dart';
import 'package:sketchpad/colored_path.dart';

class PathPainter extends CustomPainter {
  final ColoredPath path;

  const PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    final points = path.points;
    if (points.isEmpty) return;

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      linePath.lineTo(point.dx, point.dy);
    }

    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = path.color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawPath(linePath, paint);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;
}
