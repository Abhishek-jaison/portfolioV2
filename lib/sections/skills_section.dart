import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
// If you want more tech icons, you can add font_awesome_flutter or similar packages

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static final List<Map<String, dynamic>> _skills = [
    {
      'name': 'Flutter',
      'asset': 'assets/flutter.png',
      'description': 'Cross-platform mobile development framework',
      'proficiency': 'Intermediate',
      'years': '1+',
      'keyPoints': ['State Management', 'UI/UX Design', 'Widget Development']
    },
    {
      'name': 'Firebase',
      'asset': 'assets/firebase.png',
      'description': 'Backend as a Service (BaaS) platform',
      'proficiency': 'Intermediate',
      'years': '1+',
      'keyPoints': ['Authentication', 'Cloud Firestore', 'Real-time Database']
    },
    {
      "name": "Python",
      "asset": "assets/python.png",
      "description":
          "High-level programming language used for scripting and problem solving",
      "proficiency": "Basic",
      "years": "1+",
      "keyPoints": [
        "Fundamentals & Syntax",
        "Basic Scripting",
        "Problem Solving"
      ]
    },
    {
      'name': 'SQL',
      'asset': 'assets/sql.png',
      'description': 'Database management and querying',
      'proficiency': 'Intermediate',
      'years': '1',
      'keyPoints': ['Database Design', 'Schema Design', 'Query Optimization']
    },
    {
      'name': 'REST API',
      'asset': 'assets/rest.png',
      'description': 'API development and integration',
      'proficiency': 'Intermediate',
      'years': '1',
      'keyPoints': ['Integration', 'Documentation']
    },
    {
      'name': 'C',
      'asset': 'assets/C.png',
      'description': 'System programming language',
      'proficiency': 'Intermediate',
      'years': '1',
      'keyPoints': ['System Programming', 'Memory Management', 'Algorithms']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AnimatedText(
            text: 'Skills',
            isHeader: true,
          ),
          const SizedBox(height: 32),
          Center(
            child: SizedBox(
              width: 1000, // Fixed width to ensure 3 cards per row
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: _skills
                    .map((skill) => _buildSkillCard(context, skill))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, Map<String, dynamic> skill) {
    return Container(
      width: 300,
      height: 320, // Increased from 280 to 320
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Image.asset(
                  skill['asset'] as String,
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 28),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill['name'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      skill['description'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF666666),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoChip('${skill['years']} Years'),
              const SizedBox(width: 8),
              _buildInfoChip(skill['proficiency'] as String),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Key Expertise:',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (skill['keyPoints'] as List<String>)
                  .map((point) => _buildKeyPoint(point))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2D2D2D),
        ),
      ),
    );
  }

  Widget _buildKeyPoint(String point) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Text(
        point,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: const Color(0xFF2D2D2D),
        ),
      ),
    );
  }
}
