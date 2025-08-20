import 'package:flutter/material.dart';

class CustomThumbShape extends SliderComponentShape {
  final double thumbWidth;
  final double thumbHeight;

  CustomThumbShape({
    this.thumbWidth = 20,
    this.thumbHeight = 20,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbWidth, thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    // 흰색 배경 사각형
    final bgRect = Rect.fromCenter(
      center: center,
      width: thumbWidth,
      height: thumbHeight,
    );

    final bgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(bgRect, bgPaint);

    // 검정 테두리
    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    canvas.drawRect(bgRect, borderPaint);

    // 안쪽 빨간 직사각형 (테두리 안쪽 60%)
    final innerRect = Rect.fromCenter(
      center: center,
      width: thumbWidth * 0.3,
      height: thumbHeight * 0.5,
    );

    final innerPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawRect(innerRect, innerPaint);
  }
}