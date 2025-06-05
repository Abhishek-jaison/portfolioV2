import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'package:portfolio/widgets/glowing_border.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static final List<Map<String, dynamic>> _services = [
    {
      'title': 'Mobile App Development',
      'description':
          'Creating beautiful and functional mobile applications using Flutter for both iOS and Android platforms.',
      'icon': Icons.phone_android,
      'features': [
        'Cross-platform development',
        'Native performance',
        'Custom UI/UX design',
        'App store deployment',
      ],
    },
    {
      'title': 'Web Development',
      'description':
          'Building responsive and modern web applications using Flutter Web and other cutting-edge technologies.',
      'icon': Icons.web,
      'features': [
        'Responsive design',
        'Progressive web apps',
        'SEO optimization',
        'Performance optimization',
      ],
    },
    {
      'title': 'UI/UX Design',
      'description':
          'Designing intuitive and engaging user interfaces that provide exceptional user experiences.',
      'icon': Icons.design_services,
      'features': [
        'User research',
        'Wireframing',
        'Prototyping',
        'Visual design',
      ],
    },
    {
      'title': 'Consulting',
      'description':
          'Providing expert guidance on mobile and web development strategies, architecture, and best practices.',
      'icon': Icons.business,
      'features': [
        'Technical consulting',
        'Code review',
        'Performance optimization',
        'Best practices',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        color: kBackgroundLight.withOpacity(0.5),
      ),
      child: Column(
        children: [
          const AnimatedText(
            text: 'My Services',
            isHeader: true,
          ),
          const SizedBox(height: 48),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < _services.length; i++) ...[
                  if (i != 0) const SizedBox(width: 24),
                  SizedBox(
                    width: 350,
                    child: _buildServiceCard(_services[i]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return GlowingBorder(
      glowColor: kGlowColor2,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: kCardLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kGlowColor2.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: kGlowColor2.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: kGlowColor2.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                service['icon'] as IconData,
                color: kGlowColor2,
                size: 32,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              service['title'] as String,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kTextLight,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              service['description'] as String,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: kTextLight.withOpacity(0.8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: kGlowColor2,
              thickness: 1,
            ),
            const SizedBox(height: 16),
            ...(service['features'] as List<String>).map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: kGlowColor2,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: kTextLight.withOpacity(0.8),
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
    );
  }
}
