import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'package:portfolio/widgets/custom_button.dart';
import 'package:portfolio/widgets/animated_border.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int _hoveredIndex = -1;
  bool _visible = false;

  static final List<Map<String, dynamic>> _projects = [
    {
      'title': 'E-Commerce App',
      'description':
          'A full-featured e-commerce application with real-time inventory management.',
      'image': 'https://picsum.photos/400/300?random=1',
      'technologies': ['Flutter', 'Firebase', 'Provider', 'Stripe'],
      'github': 'https://github.com/yourusername/project1',
      'demo': 'https://project1-demo.com',
    },
    {
      'title': 'Fitness Tracker',
      'description':
          'A comprehensive fitness tracking app with workout plans and progress monitoring.',
      'image': 'https://picsum.photos/400/300?random=2',
      'technologies': ['Flutter', 'GetX', 'SQLite', 'Google Fit API'],
      'github': 'https://github.com/yourusername/project2',
      'demo': 'https://project2-demo.com',
    },
    {
      'title': 'Task Management',
      'description':
          'A collaborative task management tool with real-time updates and team features.',
      'image': 'https://picsum.photos/400/300?random=3',
      'technologies': ['Flutter', 'Bloc', 'Firebase', 'WebRTC'],
      'github': 'https://github.com/yourusername/project3',
      'demo': 'https://project3-demo.com',
    },
  ];

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
            text: 'My Projects',
            isHeader: true,
          ),
          const SizedBox(height: 64),
          VisibilityDetector(
            key: const Key('projects-section'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction > 0.2 && !_visible) {
                setState(() {
                  _visible = true;
                });
              }
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _projects.length; i++) ...[
                    if (i != 0) const SizedBox(width: 24),
                    SizedBox(
                      width: 350,
                      child: _buildProjectCard(_projects[i], i)
                          .animate(target: _visible ? 1 : 0)
                          .slideY(
                              begin: 0.4,
                              duration: 600.ms,
                              curve: Curves.easeOut)
                          .fadeIn(duration: 600.ms, delay: (i * 120).ms),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project, int index) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 400,
        margin: EdgeInsets.only(
          top: isHovered ? 0 : 10,
          bottom: isHovered ? 20 : 10,
        ),
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -10.0 : 0.0, 0.0),
        child: AnimatedBorder(
          isHovered: isHovered,
          child: Container(
            decoration: BoxDecoration(
              color: kCardLight,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    project['image'] as String,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: kPrimaryColor.withOpacity(0.1),
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 48,
                          color: kPrimaryColor,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 400,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['title'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: kTextLight,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            project['description'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: kTextLight.withOpacity(0.8),
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: (project['technologies'] as List<String>)
                                .map(
                                  (tech) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      tech,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  text: 'View Code',
                                  onPressed: () {
                                    // TODO: Implement GitHub link
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomButton(
                                  text: 'Live Demo',
                                  onPressed: () {
                                    // TODO: Implement demo link
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
