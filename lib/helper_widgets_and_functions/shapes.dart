import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // Set color for Circle 1
    paint.color = Colors.teal[400] as Color;
    // Set center of circle 1 => (0, size.height)
    var center = Offset(0, size.height);
    // Draw circle 1
    canvas.drawCircle(center, 100, paint);

    // Set color for Circle 2
    paint.color = Colors.teal[900] as Color;
    // Set center of circle 2 => (size.width-290, size.height+40)
    center = Offset(size.width-290, size.height+40);
    // Draw Circle 2
    canvas.drawCircle(center, 100, paint);

    // Set color for Circle 5 which is reverse of Circle 1
    paint.color = Colors.teal[400] as Color;
    // Set center of circle 5 => (size.width, size.height)
    center = Offset(size.width, size.height);
    // Draw circle 5
    canvas.drawCircle(center, 100, paint);

    // Set color for Circle 4 which is reverse of Circle 2
    paint.color = Colors.teal[900] as Color;
    // Set center of circle 4 => (size.width-10, size.height+40)
    center = Offset(size.width-100, size.height+40);
    // Draw Circle 2
    canvas.drawCircle(center, 100, paint);

    // Set color for Circle 3 the middle circle
    paint.color = Colors.teal[600] as Color;
    // Set center of circle 4 => (size.width-10, size.height+40)
    center = Offset(size.width/2, size.height+74);
    // Draw Circle 2
    canvas.drawCircle(center, 100, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}