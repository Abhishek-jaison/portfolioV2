import 'package:flutter/material.dart';

// Primary colors
const Color kPrimaryColor = Color(0xFF6C63FF);
const Color kPrimaryLight = Color(0xFF8F88FF);
const Color kPrimaryDark = Color(0xFF4A44B3);

// Accent colors
const Color kAccentColor = Color(0xFFFF6B6B);
const Color kAccentLight = Color(0xFFFF8E8E);
const Color kAccentDark = Color(0xFFE64A4A);

// Glow colors
const Color kGlowColor1 = Color(0xFFFF3D00);
const Color kGlowColor2 = Color(0xFFFF1744);
const Color kGlowColor3 = Color(0xFFD500F9);

// Background colors
const Color kBackgroundColor = Color(0xFF1A1C2E);
const Color kBackgroundLight = Color(0xFF2A2D3E);
const Color kBackgroundDark = Color(0xFF0F1117);

// Text colors
const Color kTextColor = Color(0xFFFFFFFF);
const Color kTextLight = Color(0xFFE0E0E0);
const Color kTextDark = Color(0xFFBDBDBD);

// Gradient colors
const List<Color> kGradientColors = [
  Color(0xFF6C63FF),
  Color(0xFFFF6B6B),
];

// Card colors
const Color kCardColor = Color(0xFF2A2D3E);
const Color kCardLight = Color(0xFF3A3D4E);
const Color kCardDark = Color(0xFF1A1D2E);

// Glow effects
List<BoxShadow> kGlowEffect1 = [
  BoxShadow(
    color: kGlowColor1.withOpacity(0.3),
    blurRadius: 20,
    spreadRadius: 2,
  ),
  BoxShadow(
    color: kGlowColor1.withOpacity(0.2),
    blurRadius: 10,
    spreadRadius: 1,
  ),
];

List<BoxShadow> kGlowEffect2 = [
  BoxShadow(
    color: kGlowColor2.withOpacity(0.3),
    blurRadius: 20,
    spreadRadius: 2,
  ),
  BoxShadow(
    color: kGlowColor2.withOpacity(0.2),
    blurRadius: 10,
    spreadRadius: 1,
  ),
];

List<BoxShadow> kGlowEffect3 = [
  BoxShadow(
    color: kGlowColor3.withOpacity(0.3),
    blurRadius: 20,
    spreadRadius: 2,
  ),
  BoxShadow(
    color: kGlowColor3.withOpacity(0.2),
    blurRadius: 10,
    spreadRadius: 1,
  ),
];
