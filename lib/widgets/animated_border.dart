import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';

class AnimatedBorder extends StatefulWidget {
  final Widget child;
  final bool isHovered;

  const AnimatedBorder({
    super.key,
    required this.child,
    required this.isHovered,
  });

  @override
  State<AnimatedBorder> createState() => _AnimatedBorderState();
}

class _AnimatedBorderState extends State<AnimatedBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: BorderPainter(
            animation: _animation.value,
            isHovered: widget.isHovered,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class BorderPainter extends CustomPainter {
  final double animation;
  final bool isHovered;

  BorderPainter({
    required this.animation,
    required this.isHovered,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!isHovered) return;

    final totalLength = 2 * (size.width + size.height);
    final segmentLength = totalLength / 4;
    final currentPosition = animation * totalLength;

    // Draw each side with its own gradient
    _drawSide(
      canvas,
      size,
      currentPosition,
      segmentLength,
      totalLength,
      Side.top,
    );
    _drawSide(
      canvas,
      size,
      currentPosition,
      segmentLength,
      totalLength,
      Side.right,
    );
    _drawSide(
      canvas,
      size,
      currentPosition,
      segmentLength,
      totalLength,
      Side.bottom,
    );
    _drawSide(
      canvas,
      size,
      currentPosition,
      segmentLength,
      totalLength,
      Side.left,
    );
  }

  void _drawSide(
    Canvas canvas,
    Size size,
    double currentPosition,
    double segmentLength,
    double totalLength,
    Side side,
  ) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    switch (side) {
      case Side.top:
        final startX =
            (currentPosition % totalLength).clamp(0, size.width).toDouble();
        final endX = ((currentPosition + segmentLength) % totalLength)
            .clamp(0, size.width)
            .toDouble();
        final gradient = LinearGradient(
          colors: [
            kPrimaryColor.withOpacity(0),
            kPrimaryColor,
            kPrimaryColor.withOpacity(0),
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
        paint.shader =
            gradient.createShader(Rect.fromLTWH(startX, 0, endX - startX, 2));
        canvas.drawLine(Offset(startX, 0), Offset(endX, 0), paint);
        break;

      case Side.right:
        final startY = ((currentPosition - size.width) % totalLength)
            .clamp(0, size.height)
            .toDouble();
        final endY =
            ((currentPosition + segmentLength - size.width) % totalLength)
                .clamp(0, size.height)
                .toDouble();
        final gradient = LinearGradient(
          colors: [
            kPrimaryColor.withOpacity(0),
            kPrimaryColor,
            kPrimaryColor.withOpacity(0),
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
        paint.shader = gradient.createShader(
            Rect.fromLTWH(size.width - 2, startY, 2, endY - startY));
        canvas.drawLine(
            Offset(size.width, startY), Offset(size.width, endY), paint);
        break;

      case Side.bottom:
        final startX = size.width -
            ((currentPosition - (size.width + size.height)) % totalLength)
                .clamp(0, size.width)
                .toDouble();
        final endX = size.width -
            ((currentPosition + segmentLength - (size.width + size.height)) %
                    totalLength)
                .clamp(0, size.width)
                .toDouble();
        final gradient = LinearGradient(
          colors: [
            kPrimaryColor.withOpacity(0),
            kPrimaryColor,
            kPrimaryColor.withOpacity(0),
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        );
        paint.shader = gradient.createShader(
            Rect.fromLTWH(endX, size.height - 2, startX - endX, 2));
        canvas.drawLine(
            Offset(startX, size.height), Offset(endX, size.height), paint);
        break;

      case Side.left:
        final startY = size.height -
            ((currentPosition - (2 * size.width + size.height)) % totalLength)
                .clamp(0, size.height)
                .toDouble();
        final endY = size.height -
            ((currentPosition +
                        segmentLength -
                        (2 * size.width + size.height)) %
                    totalLength)
                .clamp(0, size.height)
                .toDouble();
        final gradient = LinearGradient(
          colors: [
            kPrimaryColor.withOpacity(0),
            kPrimaryColor,
            kPrimaryColor.withOpacity(0),
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        );
        paint.shader =
            gradient.createShader(Rect.fromLTWH(0, endY, 2, startY - endY));
        canvas.drawLine(Offset(0, startY), Offset(0, endY), paint);
        break;
    }
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.isHovered != isHovered;
  }
}

enum Side { top, right, bottom, left }
