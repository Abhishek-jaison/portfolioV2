import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'package:portfolio/widgets/animated_border.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  int _hoveredIndex = -1;
  bool _visible = false;
  final ScrollController _scrollController = ScrollController();

  static final List<Map<String, dynamic>> _experiences = [
    {
      'title': 'Flutter Developer Intern',
      'company': 'Woodesy',
      'period': '2025 - Present',
      'description': [
        'Developed a QR code scanner app to streamline in-app interactions and data retrieval.',
        'Integrated a chatbot-enabled online cab ticket booking system for enhanced user experience.',
        'Rebuilt and modernized key UI components to improve usability and visual consistency',
        'Collaborated with cross-functional teams to implement features aligning with user needs',
      ],
    },
    {
      'title': 'Flutter Developer Intern',
      'company': 'Propmile LLP',
      'period': 'Jan- Apr 2025',
      'description': [
        'Worked as a Flutter Developer intern to enhance a sales support mobile application.',
        'Implemented new features and optimized existing modules for better performance and usability.',
        'Integrated REST APIs and third-party services',
        'Collaborated with backend and UI/UX teams to ensure smooth functionality and cohesive design.',
      ],
    },
    {
      'title': 'Flutter  Developer Intern',
      'company': 'FSalon',
      'period': 'Sep - Dec 2024',
      'description': [
        'Developed and maintained a Flutter-based mobile app for salon appointment booking and consultation.',
        'Designed custom widgets and UI components to match the brands aesthetic and improve user experience.',
        'Worked with version control systems (Git)',
        'Participated in daily stand-ups and sprint planning',
      ],
    },
  ];

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 350,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 350,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        final showScrollButtons = constraints.maxWidth <
            1100; // Show buttons when width is less than 1100px

        return Container(
          key: const Key('experience-section'),
          width: double.infinity,
          constraints: BoxConstraints(minHeight: screenHeight),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          decoration: BoxDecoration(
            color: kBackgroundLight,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  const AnimatedText(
                    text: 'Work Experience',
                    isHeader: true,
                  ),
                  const SizedBox(height: 48),
                  VisibilityDetector(
                    key: const Key('experiences-section'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.2 && !_visible) {
                        setState(() {
                          _visible = true;
                        });
                      }
                    },
                    child: Center(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < _experiences.length; i++) ...[
                              if (i != 0) const SizedBox(width: 24),
                              SizedBox(
                                width: 350,
                                height: 500,
                                child: _buildExperienceCard(_experiences[i], i)
                                    .animate(target: _visible ? 1 : 0)
                                    .slideY(
                                        begin: 0.4,
                                        duration: 600.ms,
                                        curve: Curves.easeOut)
                                    .fadeIn(
                                        duration: 600.ms, delay: (i * 120).ms),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (constraints.maxWidth < 400) ...[
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: FloatingActionButton(
                      heroTag: 'experience_right',
                      onPressed: _scrollRight,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> experience, int index) {
    final isHovered = _hoveredIndex == index;

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

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(
          top: isHovered ? 0 : 10,
          bottom: isHovered ? 20 : 10,
        ),
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -10.0 : 0.0, 0.0),
        child: AnimatedBorder(
          isHovered: isHovered,
          child: Container(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
