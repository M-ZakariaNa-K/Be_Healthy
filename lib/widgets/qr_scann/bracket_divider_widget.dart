import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';

class BracketDividerWidget extends StatelessWidget {
  final bool isLeftBracket; // Parameter to determine bracket type

  const BracketDividerWidget({super.key, required this.isLeftBracket});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(10, 40), // Width and height of the bracket
      painter: BracketPainter(isLeftBracket: isLeftBracket),
    );
  }
}

class BracketPainter extends CustomPainter {
  final bool isLeftBracket; // Store the parameter

  BracketPainter({required this.isLeftBracket});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppVar.textColor // Color of the bracket
      ..strokeWidth = 1.0 // Thickness of the bracket line
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Smooth rounded edges

    Path path = Path();

    if (isLeftBracket) {
      // Draw left bracket
      path.moveTo(size.width + 7, -1); // Start at the top right
      path.quadraticBezierTo(
          0, size.height * 0.08, 3, size.height * 0.5); // Top curve
      path.quadraticBezierTo(0, size.height * 0.94, size.width + 7,
          size.height + 1); // Bottom curve
    } else {
      // Draw right bracket
      path.moveTo(-7, -1); // Start at the top left
      path.quadraticBezierTo(size.width, size.height * 0.02, size.width - 1,
          size.height * 0.5); // Top curve
      path.quadraticBezierTo(
          size.width, size.height * 0.94, -7, size.height + 2); // Bottom curve
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
