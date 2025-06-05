import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> _testimonials = [
    {
      'name': 'Vikas Bansal',
      'position':
          'Serial Entrepreneur | Franchisee Influencer | Climate Change Top Voice',
      'testimonial':
          'He was a fantastic resource, full of creativity and man of discipline',
      'linkedinUrl':
          'https://www.linkedin.com/in/abhishek-jaison/details/recommendations/',
      'imageUrl':
          'https://media.licdn.com/dms/image/v2/D5603AQHIGcC-iP0ybA/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1715404605266?e=1752710400&v=beta&t=PKLEfvxHxxwoNGrNugJNyafVBYeZcyTB_6tSR-wmLDc',
    },
    {
      'name': 'Ashutosh Rai',
      'position': 'Flutter Developer | Ex-IT Intern @Honda Car India Ltd.',
      'testimonial':
          'I highly recommend Abhishek for his outstanding dedication and teamwork during our Flutter internship. His proactive approach, problem-solving skills, and collaborative spirit made him an invaluable team member, consistently delivering high-quality results',
      'linkedinUrl':
          'https://www.linkedin.com/in/abhishek-jaison/details/recommendations/',
      'imageUrl':
          'https://media.licdn.com/dms/image/v2/D5635AQG8BJfJpO7K_g/profile-framedphoto-shrink_800_800/profile-framedphoto-shrink_800_800/0/1735052161409?e=1749754800&v=beta&t=Op3xW1HJBd9Xi56RHDZGAsIiPjOwR5vItoNczDKiDO0'
    },
    {
      'name': 'Zaid Sayyed',
      'position':
          'Campus Ambassador @GDG Prayagraj | UHack 2.0 Winner 🏆 | App Developer (Flutter/Dart)',
      'testimonial':
          'I had the privilege of working with Abhishek Jaison during our internship, and it was a truly rewarding experience. We worked together on some challenging projects, tackling complex problems as a team. What stood out the most was Abhishek\'s ability to stay focused, come up with creative solutions, and contribute ideas that made a real impact.\n\nCollaborating with him was always a positive experience. He brought a great attitude, a strong work ethic, and a natural ability to bring people together. We both learned a lot from each other during this time, and his approach to problem-solving and teamwork always made things smoother.\n\nAbhishek is someone who doesn\'t just work hard—he inspires the team to do their best. I\'m confident he\'ll excel in anything he takes on, and I\'m excited to see all the amazing things he\'ll achieve in the future.',
      'linkedinUrl':
          'https://www.linkedin.com/in/abhishek-jaison/details/recommendations/',
      'imageUrl':
          'https://media.licdn.com/dms/image/v2/D5603AQF_DfqMNKxPow/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1697396607338?e=1752710400&v=beta&t=ltHe6dvyb6UY2da_pVHgfJ6bZxaN7VTtBhbKlkNtHm0',
    },
    {
      'name': 'Isha Motsara',
      'position': 'Flutter Intern @F Salon Academy | Flutter Developer | Dart',
      'testimonial':
          'I had the pleasure of working with Abhishek in a team where he contributed as a Flutter Developer, and I can confidently say he is an outstanding professional in his field. Abhishek consistently demonstrated exceptional skills in Flutter development, including building intuitive and visually appealing user interfaces, optimizing app performance. I highly recommend him for any opportunities in this domain.',
      'linkedinUrl':
          'https://www.linkedin.com/in/abhishek-jaison/details/recommendations/',
      'imageUrl':
          'https://media.licdn.com/dms/image/v2/D5635AQH8ukWn1blUNg/profile-framedphoto-shrink_800_800/profile-framedphoto-shrink_800_800/0/1711175572703?e=1749754800&v=beta&t=GKpQ_0t90Iz6FIpUOcAxnwu0vW9wofnEiQsYC3I3J8o'
    },
    {
      "name": "Malay Agrawal",
      "position":
          "CI/CD / Automation / Flutter App + Web Developer / UX-UI / FastAPI / AWS / SQL",
      "testimonial":
          "I had the pleasure of working with Abhishek during his internship, where he contributed to the improvement and extension of our Flutter and Dart application. His responsibilities included debugging existing features and implementing new ones, both of which he handled with competence and attention to detail. He was responsive to feedback, eager to learn, and maintained a consistent level of professionalism throughout the internship. I would confidently recommend him for any future opportunity.",
      "linkedinUrl":
          "https://www.linkedin.com/in/malay-agrawal/details/recommendations/",
      "imageUrl":
          'https://media.licdn.com/dms/image/v2/D5603AQHqe05TOz94Wg/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1704280912062?e=1754524800&v=beta&t=lW9jR34gZYNCJL8KdM-QLSDV06BPyqoRD6UP1oI7ub4'
    }
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < _testimonials.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        color: kBackgroundLight.withOpacity(0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side - Text
          Expanded(
            flex: 1,
            child: Column(
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
            ),
          ),
          const SizedBox(width: 32),
          // Right side - Testimonial Card with Navigation
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 400,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
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
                      if (_currentPage > 0) {
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
                      if (_currentPage < _testimonials.length - 1) {
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
            ),
          ),
        ],
      ),
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
                backgroundImage: NetworkImage(testimonial['imageUrl']),
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
          ElevatedButton.icon(
            onPressed: () => _launchLinkedIn(testimonial['linkedinUrl']),
            icon: const FaIcon(FontAwesomeIcons.linkedin),
            label: const Text('View Full Testimonial'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
