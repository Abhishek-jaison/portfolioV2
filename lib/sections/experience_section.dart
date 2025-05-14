import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static final List<Map<String, dynamic>> _experiences = [
    {
      'title': 'Flutter Developer',
      'company': 'Fresher',
      'period': '2024 - Present',
      'description': [
        'Passionate about creating beautiful and functional mobile applications',
        'Strong foundation in Flutter and Dart programming',
        'Eager to learn and grow in the field of mobile development',
        'Focused on delivering high-quality user experiences',
      ],
    },
    {
      'title': 'Flutter Developer',
      'company': 'Startup Inc.',
      'period': '2020 - 2022',
      'description': [
        'Developed and maintained 5+ Flutter applications',
        'Collaborated with designers to implement pixel-perfect UIs',
        'Integrated REST APIs and third-party services',
        'Implemented state management using Provider and BLoC',
      ],
    },
    {
      'title': 'Junior Mobile Developer',
      'company': 'Digital Agency',
      'period': '2019 - 2020',
      'description': [
        'Assisted in developing Flutter applications',
        'Fixed bugs and implemented new features',
        'Worked with version control systems (Git)',
        'Participated in daily stand-ups and sprint planning',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Container(
          constraints: BoxConstraints(minHeight: screenHeight),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          decoration: BoxDecoration(
            color: kBackgroundLight,
          ),
          child: Column(
            children: [
              const AnimatedText(
                text: 'Work Experience',
                isHeader: true,
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _experiences.length; i++) ...[
                    if (i != 0) const SizedBox(width: 24),
                    SizedBox(
                        width: 350,
                        height: 430,
                        child: _buildExperienceCard(_experiences[i])),
                  ]
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> experience) {
    TextStyle safeGoogleFont(TextStyle style) {
      try {
        return style;
      } catch (e) {
        return TextStyle(
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          color: style.color,
          fontFamily: 'Arial',
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: kCardLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience['title'] as String,
                      style: safeGoogleFont(GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTextLight,
                      )),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      experience['company'] as String,
                      style: safeGoogleFont(GoogleFonts.poppins(
                        fontSize: 16,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  experience['period'] as String,
                  style: safeGoogleFont(GoogleFonts.poppins(
                    fontSize: 14,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          ...(experience['description'] as List<String>).map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_right,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: safeGoogleFont(GoogleFonts.poppins(
                        fontSize: 14,
                        color: kTextLight.withOpacity(0.8),
                        height: 1.5,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
