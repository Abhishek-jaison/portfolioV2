import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';

class SocialLinks extends StatefulWidget {
  const SocialLinks({super.key});

  @override
  State<SocialLinks> createState() => _SocialLinksState();
}

class _SocialLinksState extends State<SocialLinks> {
  final List<Map<String, dynamic>> _socialLinks = [
    {
      'icon': Icons.code,
      'url': 'https://github.com/yourusername',
      'label': 'GitHub',
    },
    {
      'icon': Icons.link,
      'url': 'https://linkedin.com/in/yourusername',
      'label': 'LinkedIn',
    },
    {
      'icon': Icons.chat,
      'url': 'https://twitter.com/yourusername',
      'label': 'Twitter',
    },
    {
      'icon': Icons.email,
      'url': 'mailto:abhisehkjaison04@gmail.com',
      'label': 'Email',
    },
  ];

  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _socialLinks.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: MouseRegion(
            onEnter: (_) => setState(() => _hoveredIndex = index),
            onExit: (_) => setState(() => _hoveredIndex = null),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: _hoveredIndex == index
                    ? kPrimaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(
                  _socialLinks[index]['icon'] as IconData,
                  color: _hoveredIndex == index ? kPrimaryColor : kTextLight,
                  size: 24,
                ),
                onPressed: () {
                  // TODO: Implement URL launcher
                },
                tooltip: _socialLinks[index]['label'] as String,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
