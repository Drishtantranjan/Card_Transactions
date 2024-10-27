import 'package:flutter/material.dart';
import 'dart:math';

class CircularSegmentWidget extends StatelessWidget {
  final double totalAmount;
  final Map<String, double> categorySpending;

  CircularSegmentWidget({
    required this.totalAmount,
    required this.categorySpending,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 250, // Set the size of the circle
            height: 250,
            child: CustomPaint(
              painter:
                  CircularSegmentPainter(categorySpending: categorySpending),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Spent this month',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircularSegmentPainter extends CustomPainter {
  final Map<String, double> categorySpending;

  CircularSegmentPainter({required this.categorySpending});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final List<Color> segmentColors = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.green,
      Colors.purple,
    ];

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;

    double totalSpending =
        categorySpending.values.fold(0.0, (sum, amount) => sum + amount);

    double startAngle = -pi / 2;
    int colorIndex = 0;

    categorySpending.forEach((category, amount) {
      double sweepAngle = (amount / totalSpending) * 2 * pi;

      paint.color = segmentColors[colorIndex % segmentColors.length];

      // Draw arc for each segment
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
      colorIndex++;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
