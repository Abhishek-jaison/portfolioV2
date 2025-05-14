import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';

class GlowingBorder extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double borderWidth;
  final Duration duration;

  const GlowingBorder({
    super.key,
    required this.child,
    required this.glowColor,
    this.borderWidth = 1.5,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<GlowingBorder> createState() => _GlowingBorderState();
}

class _GlowingBorderState extends State<GlowingBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
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
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: SweepGradient(
              colors: [
                widget.glowColor.withOpacity(0),
                widget.glowColor.withOpacity(0.8),
                widget.glowColor.withOpacity(0.8),
                widget.glowColor.withOpacity(0),
                widget.glowColor.withOpacity(0),
              ],
              stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
              startAngle: _animation.value * 2 * 3.14159,
              endAngle: (_animation.value * 2 * 3.14159) + 2 * 3.14159,
              transform: GradientRotation(_animation.value * 2 * 3.14159),
            ),
          ),
          padding: EdgeInsets.all(widget.borderWidth),
          child: Container(
            decoration: BoxDecoration(
              color: kCardLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
