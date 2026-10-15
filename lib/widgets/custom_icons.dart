import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/neobrutalist_theme.dart';

/// Circular Neobrutalist Smiley Icon Widget
class BrutalistSmileyWidget extends StatelessWidget {
  final double size;
  final Color strokeColor;

  const BrutalistSmileyWidget({
    super.key,
    this.size = 42,
    this.strokeColor = AppColors.ink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: strokeColor, width: 2.0),
      ),
      child: CustomPaint(
        painter: _SmileyPainter(color: strokeColor),
      ),
    );
  }
}

class _SmileyPainter extends CustomPainter {
  final Color color;

  _SmileyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Left eye curve (M7 9 c.5-1 1.5-1 2 0) mapped to scale
    final leftEye = Path();
    leftEye.moveTo(w * 0.30, h * 0.40);
    leftEye.quadraticBezierTo(w * 0.35, h * 0.33, w * 0.40, h * 0.40);
    canvas.drawPath(leftEye, paint);

    // Right eye curve (M15 9 c.5-1 1.5-1 2 0)
    final rightEye = Path();
    rightEye.moveTo(w * 0.60, h * 0.40);
    rightEye.quadraticBezierTo(w * 0.65, h * 0.33, w * 0.70, h * 0.40);
    canvas.drawPath(rightEye, paint);

    // Smile curve (M8 15 c2 2.5 6 2.5 8 0)
    final mouth = Path();
    mouth.moveTo(w * 0.33, h * 0.62);
    mouth.quadraticBezierTo(w * 0.50, h * 0.78, w * 0.67, h * 0.62);
    canvas.drawPath(mouth, paint);
  }

  @override
  bool shouldRepaint(covariant _SmileyPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// 8-Point Asterisk Icon Widget for Certifications
class AsteriskIconWidget extends StatelessWidget {
  final double size;
  final Color color;

  const AsteriskIconWidget({
    super.key,
    this.size = 20,
    this.color = AppColors.ink,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AsteriskPainter(color: color),
      ),
    );
  }
}

class _AsteriskPainter extends CustomPainter {
  final Color color;

  _AsteriskPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = (size.width / 2) - 2;

    for (int i = 0; i < 4; i++) {
      final angle = i * (math.pi / 4);
      final dx = radius * math.cos(angle);
      final dy = radius * math.sin(angle);
      canvas.drawLine(
        Offset(cx - dx, cy - dy),
        Offset(cx + dx, cy + dy),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AsteriskPainter oldDelegate) =>
      oldDelegate.color != color;
}
