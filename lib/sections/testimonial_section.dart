import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/widgets/custom_button.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  bool _isPageViewAttached = false;

  final List<Map<String, dynamic>> _testimonials = [
    {
      'name': 'Vikas Bansal',
      'position':
          'Serial Entrepreneur | Franchisee Influencer | Climate Change Top Voice',
      'testimonial':
          'He was a fantastic resource, full of creativity and man of discipline',
      'linkedinUrl':
          'https://www.linkedin.com/in/abhishek-jaison/details/recommendations/',
      'imageUrl': 'assets/T1.jpeg'
    },
    {
      'name': 'Zaid Sayyed',
      'position':
          'Campus Ambassador @GDG Prayagraj | UHack 2.0 Winner 🏆 | App Developer (Flutter/Dart)',
      'testimonial':
          'I had the privilege of working with Abhishek Jaison during our internship, and it was a truly rewarding experience. We worked together on some challenging projects, tackling complex problems as a team. What stood out the most was Abhishek\'s ability to stay focused, come up with creative solutions, and contribute ideas that made a real impact.\n\nCollaborating with him was always a positive experience. He brought a great attitude, a strong work ethic, and a natural ability to bring people together. We both learned a lot from each other during this time, and his approach to problem-solving and teamwork always made things smoother.\n\nAbhishek is someone who doesn\'t just work hard—he inspires the team to do their best. I\'m confident he\'ll excel in anything he takes on, and I\'m excited to see all the amazing things he\'ll achieve in the future.',
      'linkedinUrl':
          'https://www.linkedin.com/in/abhishek-jaison/details/recommendations/',
      'imageUrl': 'assets/T3.jpeg'
    },
    {
      "name": "Malay Agrawal",
      "position":
          "CI/CD / Automation / Flutter App + Web Developer / UX-UI / FastAPI / AWS / SQL",
      "testimonial":
          "I had the pleasure of working with Abhishek during his internship, where he contributed to the improvement and extension of our Flutter and Dart application. His responsibilities included debugging existing features and implementing new ones, both of which he handled with competence and attention to detail. He was responsive to feedback, eager to learn, and maintained a consistent level of professionalism throughout the internship. I would confidently recommend him for any future opportunity.",
      "linkedinUrl":
          "https://www.linkedin.com/in/malay-agrawal/details/recommendations/",
      "imageUrl": 'assets/T5.jpeg'
    },
    {
      'name': 'Ashutosh Rai',
      'position': 'Flutter Developer | Ex-IT Intern @Honda Car India Ltd.',
      'testimonial':
          'I highly recommend Abhishek for his outstanding dedication and teamwork during our Flutter internship. His proactive approach, problem-solving skills, and collaborative spirit made him an invaluable team member, consistently delivering high-quality results',
      'linkedinUrl':
          'https://www.linkedin.com/in/abhishek-jaison/details/recommendations/',
      'imageUrl': 'assets/T2.jpeg'
    },
    {
      'name': 'Isha Motsara',
      'position': 'Flutter Intern @F Salon Academy | Flutter Developer | Dart',
      'testimonial':
          'I had the pleasure of working with Abhishek in a team where he contributed as a Flutter Developer, and I can confidently say he is an outstanding professional in his field. Abhishek consistently demonstrated exceptional skills in Flutter development, including building intuitive and visually appealing user interfaces, optimizing app performance. I highly recommend him for any opportunities in this domain.',
      'linkedinUrl':
          'https://www.linkedin.com/in/abhishek-jaison/details/recommendations/',
      'imageUrl': 'assets/T4.jpeg'
    },
  ];

  @override
  void initState() {
    super.initState();
    // Delay the start of auto-scroll to ensure PageView is built
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted || !_isPageViewAttached) return;

      if (_currentPage < _testimonials.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _launchLinkedIn(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open LinkedIn profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 400) {
          // Stack vertically: text section, then cards
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: BoxDecoration(
              color: kBackgroundLight.withOpacity(0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionText(context),
                const SizedBox(height: 32),
                _buildCardsStack(context),
              ],
            ),
          );
        } else {
          // Side by side: text section left, cards right
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: BoxDecoration(
              color: kBackgroundLight.withOpacity(0.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildSectionText(context),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: _buildCardsStack(context),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildSectionText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AnimatedText(
          text: 'Testimonials',
          isHeader: true,
        ),
        const SizedBox(height: 24),
        Text(
          'What People Say',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: kTextLight,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Hear from colleagues and clients about their experience working with me.',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: kTextLight.withOpacity(0.8),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildCardsStack(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _isPageViewAttached = true;
              });
            },
            itemCount: _testimonials.length,
            itemBuilder: (context, index) {
              final testimonial = _testimonials[index];
              return _buildTestimonialCard(testimonial);
            },
          ),
        ),
        // Left Navigation Button
        Positioned(
          left: 0,
          child: IconButton(
            onPressed: () {
              if (_currentPage > 0 && _pageController.hasClients) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: kPrimaryColor,
                size: 20,
              ),
            ),
          ),
        ),
        // Right Navigation Button
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {
              if (_currentPage < _testimonials.length - 1 &&
                  _pageController.hasClients) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: kPrimaryColor,
                size: 20,
              ),
            ),
          ),
        ),
        // Page Indicator
        Positioned(
          bottom: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _testimonials.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? kPrimaryColor
                      : kPrimaryColor.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> testimonial) {
    return Container(
      width: double.infinity,
      height: 400,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(testimonial['imageUrl']),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTextLight,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      testimonial['position'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: kPrimaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            testimonial['testimonial'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: kTextLight.withOpacity(0.8),
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'View Full Testimonial',
            onPressed: () => _launchLinkedIn(testimonial['linkedinUrl']),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
