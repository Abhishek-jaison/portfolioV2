import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'package:portfolio/widgets/custom_button.dart';
import 'dart:html' as html;

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Container(
          constraints: BoxConstraints(minHeight: screenHeight),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          decoration: BoxDecoration(
            color: kBackgroundLight.withOpacity(0.5),
          ),
          child: Column(
            children: [
              const AnimatedText(
                text: 'About Me',
                isHeader: true,
              ),
              const SizedBox(height: 48),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 800) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildAboutContent(context),
                            const SizedBox(height: 48),
                            _buildInfoCard(),
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildAboutContent(context),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            child: _buildInfoCard(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who am I?',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I am a passionate Flutter developer with a strong focus on creating beautiful and functional mobile applications. With expertise in UI/UX design and a keen eye for detail, I strive to deliver exceptional user experiences.',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: kTextLight,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'What I do?',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I specialize in developing cross-platform mobile applications using Flutter. My work includes creating intuitive user interfaces, implementing complex features, and ensuring optimal performance across different devices.',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: kTextLight,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        Center(
          child: CustomButton(
            text: 'View My Work',
            onPressed: () {
              final experienceSection =
                  html.document.querySelector('[key="experience-section"]');
              if (experienceSection != null) {
                final yOffset = experienceSection.getBoundingClientRect().top +
                    html.window.scrollY;
                html.window.scrollTo(0, yOffset);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
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
        children: [
          _buildInfoItem(
            icon: Icons.person,
            title: 'Name',
            value: 'Abhishek Jaison N',
          ),
          const Divider(height: 32),
          _buildInfoItem(
            icon: Icons.email,
            title: 'Email',
            value: 'abhisehkjaison04@gmail.com',
          ),
          const Divider(height: 32),
          _buildInfoItem(
            icon: Icons.location_on,
            title: 'Location',
            value: 'Thrissur, Kerala',
          ),
          const Divider(height: 32),
          _buildInfoItem(
            icon: Icons.work,
            title: 'Experience',
            value: 'Fresher',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: kPrimaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: kTextLight.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kTextLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
