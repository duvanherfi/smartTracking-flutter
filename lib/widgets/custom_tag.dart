import 'package:flutter/material.dart';

class BubbleTag extends StatelessWidget {
  String? text = "";

  BubbleTag({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: -18,
          left: 40,
          child: CustomPaint(
            size: const Size(50, 20),
            painter: PointerPainter(),
          ),
        ),
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0x7A1942DB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text!,
            style: const TextStyle(color: Colors.white),
            softWrap: true
          ),
        ),
      ],
    );
  }
}

class PointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x7A1942DB)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(15, 15)
      ..lineTo(size.width + 120, 15)
      ..lineTo(size.width + 140, 30);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
