import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'package:portfolio/widgets/custom_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Container(
          constraints: BoxConstraints(minHeight: screenHeight),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          decoration: BoxDecoration(
            color: kBackgroundLight.withOpacity(0.5),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                kPrimaryColor.withOpacity(0.1),
                kBackgroundLight.withOpacity(0.5),
              ],
            ),
          ),
          child: Column(
            children: [
              const AnimatedText(
                text: 'Get In Touch',
                isHeader: true,
              ),
              const SizedBox(height: 48),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Let\'s Talk',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Feel free to reach out to me for any questions or opportunities. I\'ll get back to you as soon as possible.',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: kTextLight,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 32),
                          _buildContactInfo(
                            icon: Icons.email,
                            title: 'Email',
                            value: 'abhisehkjaison04@gmail.com',
                          ),
                          const SizedBox(height: 16),
                          _buildContactInfo(
                            icon: Icons.phone,
                            title: 'Phone',
                            value: '+91 8714726501',
                          ),
                          const SizedBox(height: 16),
                          _buildContactInfo(
                            icon: Icons.location_on,
                            title: 'Location',
                            value: 'Thrissur, Kerala',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                    SizedBox(
                      width: 400,
                      child: Container(
                        padding: const EdgeInsets.all(32),
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Send Message',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kTextLight,
                                ),
                              ),
                              const SizedBox(height: 24),
                              _buildTextField(
                                controller: _nameController,
                                hint: 'Your Name',
                                icon: Icons.person,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _emailController,
                                hint: 'Your Email',
                                icon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _messageController,
                                hint: 'Your Message',
                                icon: Icons.message,
                                maxLines: 5,
                              ),
                              const SizedBox(height: 24),
                              CustomButton(
                                text: 'Send Message',
                                onPressed: _handleSubmit,
                              ),
                            ],
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
      },
    );
  }

  Widget _buildContactInfo({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: kPrimaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: kTextLight.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kTextLight,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: kTextLight.withOpacity(0.7),
        ),
        prefixIcon: Icon(
          icon,
          color: kPrimaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: kTextLight.withOpacity(0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: kTextLight.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hint';
        }
        if (keyboardType == TextInputType.emailAddress) {
          if (!value.contains('@') || !value.contains('.')) {
            return 'Please enter a valid email address';
          }
        }
        return null;
      },
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement form submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message sent successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }
}
