import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'package:portfolio/widgets/glowing_border.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static final List<Map<String, dynamic>> _testimonials = [
    {
      'name': 'John Smith',
      'position': 'CEO, Tech Company',
      'image': 'assets/images/testimonial1.jpg',
      'text':
          'Working with Abhishek was an absolute pleasure. His expertise in Flutter development and attention to detail resulted in a beautiful and highly functional mobile app that exceeded our expectations.',
      'rating': 5,
    },
    {
      'name': 'Sarah Johnson',
      'position': 'Product Manager, Startup Inc.',
      'image': 'assets/images/testimonial2.jpg',
      'text':
          'Abhishek\'s technical skills and problem-solving abilities are exceptional. He delivered our project on time and was always available to help with any questions or concerns.',
      'rating': 5,
    },
    {
      'name': 'Michael Brown',
      'position': 'Founder, Digital Agency',
      'image': 'assets/images/testimonial3.jpg',
      'text':
          'I\'ve worked with many developers, but Abhishek stands out for his professionalism and dedication. His Flutter expertise helped us create a stunning web application that our clients love.',
      'rating': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        color: kBackgroundLight,
      ),
      child: Column(
        children: [
          const AnimatedText(
            text: 'Client Testimonials',
            isHeader: true,
          ),
          const SizedBox(height: 48),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _testimonials.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, index) =>
                _buildTestimonialCard(_testimonials[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> testimonial) {
    return GlowingBorder(
      glowColor: kGlowColor3,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: kCardLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kGlowColor3.withOpacity(0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kGlowColor3.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(testimonial['image'] as String),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        testimonial['name'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kTextLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        testimonial['position'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: kTextLight.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    testimonial['rating'] as int,
                    (index) => Icon(
                      Icons.star,
                      color: kGlowColor3,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kGlowColor3.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: kGlowColor3.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                testimonial['text'] as String,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: kTextLight.withOpacity(0.8),
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
