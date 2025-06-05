import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/contact_section.dart';
import 'sections/skills_section.dart';
import 'sections/education_section.dart';
import 'sections/testimonial_section.dart';
import 'sections/mobile_mockup_section.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({Key? key}) : super(key: key);

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _scrollToSection(int index) {
    final double screenHeight = MediaQuery.of(context).size.height;
    _scrollController.animateTo(
      index * screenHeight,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abhishek'),
        actions: isMobile
            ? null
            : [
                TextButton(
                  onPressed: () => _scrollToSection(0),
                  child:
                      const Text('Home', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(1),
                  child: const Text('About',
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(2),
                  child: const Text('Skills',
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(3),
                  child: const Text('Projects',
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(4),
                  child: const Text('Experience',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
      ),
      drawer: isMobile
          ? Drawer(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Home'),
                    onTap: () => _scrollToSection(0),
                  ),
                  ListTile(
                    title: const Text('About'),
                    onTap: () => _scrollToSection(1),
                  ),
                  ListTile(
                    title: const Text('Skills'),
                    onTap: () => _scrollToSection(2),
                  ),
                  ListTile(
                    title: const Text('Projects'),
                    onTap: () => _scrollToSection(3),
                  ),
                  ListTile(
                    title: const Text('Experience'),
                    onTap: () => _scrollToSection(4),
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const HomeSection(),
            const AboutSection(),
            const SkillsSection(),
            const MobileMockupSection(),
            const ProjectsSection(),
            const ExperienceSection(),
            const EducationSection(),
            const TestimonialSection(),
            const ContactSection(),
          ],
        ),
      ),
    );
  }
}
