import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        color: kBackgroundLight.withOpacity(0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AnimatedText(
            text: 'Education',
            isHeader: true,
          ),
          const SizedBox(height: 48),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEducationCard(
                  title: 'B.Tech',
                  institution: 'Christ College of Engineering',
                  year: '2022 - 2026',
                  details: 'Current CGPA: 8.7',
                  isCurrent: true,
                ),
                const SizedBox(width: 24),
                _buildEducationCard(
                  title: 'Higher Secondary Education',
                  institution: 'Nirmala Matha \nCentral School',
                  year: '2020 - 2022',
                  details: 'Percentage: 93.4% in Computer Science',
                  isCurrent: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard({
    required String title,
    required String institution,
    required String year,
    required String details,
    required bool isCurrent,
  }) {
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
      width: 350,
      height: 280,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: safeGoogleFont(GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTextLight,
                      )),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      institution,
                      style: safeGoogleFont(GoogleFonts.poppins(
                        fontSize: 16,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                  ],
                ),
              ),
              if (isCurrent)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Current',
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              year,
              style: safeGoogleFont(GoogleFonts.poppins(
                fontSize: 14,
                color: kPrimaryColor,
                fontWeight: FontWeight.w500,
              )),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
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
                    details,
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
        ],
      ),
    );
  }
}
