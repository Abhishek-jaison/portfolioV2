import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'package:portfolio/widgets/custom_button.dart';
import 'package:portfolio/widgets/animated_border.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:html' as html;

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int _hoveredIndex = -1;
  bool _visible = false;
  final ScrollController _scrollController = ScrollController();

  static final List<Map<String, dynamic>> _projects = [
    {
      'title': 'Distractino Free Instagram',
      'description':
          'A distraction-free Instagram web app that hides Reels to help users focus on meaningful content.',
      'image': 'assets/insta.jpg',
      'technologies': ['Flutter', 'WebView', 'JavaScript'],
      'github': 'https://github.com/Abhishek-jaison/insta-without-reels',
      'demo':
          'https://www.linkedin.com/posts/abhishek-jaison_flutter-android-webview-activity-7315242185631715328-6JBN?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEIghjsBrNQUCM_HfrLLu4NYXkPcMZCRxKI',
    },
    {
      'title': 'Chat Bot\n',
      'description':
          'An AI-powered chatbot app that answers user queries in real time\n',
      'image': 'assets/chatBot.png',
      'technologies': ['Flutter', 'Gemini'],
      'github': 'https://github.com/Abhishek-jaison/chatbot',
      'demo':
          'https://www.linkedin.com/posts/abhishek-jaison_ai-techinnovation-chatbot-activity-7215075656617877504-ehiI?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEIghjsBrNQUCM_HfrLLu4NYXkPcMZCRxKI',
    },
    {
      'title': 'Social Media App\n',
      'description':
          'A social media app enabling users to connect, share posts, and interact in real time.',
      'image': 'assets/socialMedia.jpeg',
      'technologies': ['Flutter', 'Firebase'],
      'github': 'https://github.com/Abhishek-jaison/login-page-with-firebase',
      'demo':
          'https://www.linkedin.com/posts/abhishek-jaison_flutter-firebase-mobileappdevelopment-activity-7215418092795879424-bdns?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEIghjsBrNQUCM_HfrLLu4NYXkPcMZCRxKI',
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
        final showScrollButtons = constraints.maxWidth <
            1100; // Show buttons when width is less than 1100px

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          decoration: BoxDecoration(
            color: kBackgroundLight.withOpacity(0.5),
          ),
          child: Stack(
            children: [
              Column(
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
                    child: Center(
                      child: SingleChildScrollView(
                        controller: _scrollController,
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
                      heroTag: 'projects_right',
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
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: project['image'].toString().startsWith('http')
                            ? NetworkImage(project['image'] as String)
                                as ImageProvider
                            : AssetImage(project['image'] as String),
                        fit: BoxFit.cover,
                      ),
                    ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                text: 'View Code',
                                onPressed: () {
                                  html.window.open(
                                    project['github'] as String,
                                    '_blank',
                                  );
                                },
                              ),
                              CustomButton(
                                text: 'Live Demo',
                                onPressed: () {
                                  html.window.open(
                                    project['demo'] as String,
                                    '_blank',
                                  );
                                },
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
