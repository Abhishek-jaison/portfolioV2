import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.padding,
    this.textStyle,
    this.borderColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: widget.isOutlined
              ? null
              : LinearGradient(
                  colors: kGradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(30),
          border: widget.isOutlined
              ? Border.all(
                  color: widget.borderColor ?? kPrimaryColor,
                  width: 2,
                )
              : null,
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color:
                        (widget.borderColor ?? kPrimaryColor).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Text(
                widget.text,
                style: widget.textStyle ??
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.isOutlined
                          ? (widget.borderColor ?? kPrimaryColor)
                          : Colors.white,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
