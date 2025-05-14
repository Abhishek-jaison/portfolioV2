import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final bool isHeader;
  final bool isGradient;

  const AnimatedText({
    super.key,
    required this.text,
    this.isHeader = false,
    this.isGradient = false,
  });

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.isGradient
            ? ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: kGradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    fontSize: widget.isHeader ? 48 : 24,
                    fontWeight:
                        widget.isHeader ? FontWeight.bold : FontWeight.w500,
                    color: Colors.white,
                    height: 1.2,
                    letterSpacing: widget.isHeader ? -0.5 : 0,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : Text(
                widget.text,
                style: GoogleFonts.poppins(
                  fontSize: widget.isHeader ? 48 : 24,
                  fontWeight:
                      widget.isHeader ? FontWeight.bold : FontWeight.w500,
                  height: 1.2,
                  letterSpacing: widget.isHeader ? -0.5 : 0,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
