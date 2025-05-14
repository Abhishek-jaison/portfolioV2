import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/social_links.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          const SocialLinks(),
          const SizedBox(height: 20),
          Text(
            '© 2024 Your Name. All rights reserved.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Made with ❤️ using Flutter',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
