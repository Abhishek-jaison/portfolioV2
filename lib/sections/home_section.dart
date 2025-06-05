import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'dart:html' as html;
import 'package:portfolio/sections/mobile_mockup_section.dart';

class HomeSection extends StatefulWidget {
  final VoidCallback? onHireMe;
  const HomeSection({Key? key, this.onHireMe}) : super(key: key);

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/bgvideo.mp4')
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight,
      child: Stack(
        children: [
          // Video background
          Positioned.fill(
            child: _controller.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Container(color: Colors.black),
          ),
          // Content
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Mobile Mockup on the left
                const MobileMockupSection()
                    .animate()
                    .fade(duration: 600.ms)
                    .slideX(begin: -0.3, end: 0),
                const SizedBox(width: 100),
                // Profile Card on the right
                GlassmorphicContainer(
                  width: 400,
                  height: 500,
                  borderRadius: 20,
                  blur: 20,
                  alignment: Alignment.center,
                  border: 2,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.2),
                    ],
                  ),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                          'https://media.licdn.com/dms/image/v2/D5603AQEg0-zbt8TWdg/profile-displayphoto-shrink_400_400/B56ZYQsEhFGcAg-/0/1744036711625?e=1752710400&v=beta&t=xU8ESTpUCDsDHoy4-SvLlvkMHX9U0iEHOZPCWW-R7Jk',
                        ),
                      )
                          .animate()
                          .scale(duration: 600.ms)
                          .fade(duration: 600.ms),
                      const SizedBox(height: 30),
                      Text(
                        'Welcome to My Portfolio',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                          .animate()
                          .fade(duration: 600.ms)
                          .slideY(begin: 0.3, end: 0),
                      const SizedBox(height: 20),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Mobile App\n Developer',
                            textStyle: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                          TypewriterAnimatedText(
                            'Flutter Developer',
                            textStyle: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                          // TypewriterAnimatedText(
                          //   'Problem Solver',
                          //   textStyle: const TextStyle(
                          //     fontSize: 24,
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          //   speed: const Duration(milliseconds: 100),
                          // ),
                        ],
                        totalRepeatCount: 1,
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              const url =
                                  'https://drive.google.com/file/d/1jV6TbQsJwyvah7nNte-0B7v1cM0ALMn4/view?usp=drive_link';
                              html.window.open(url, '_blank');
                            },
                            child: const Text('Download Resume'),
                          )
                              .animate()
                              .fade(duration: 600.ms)
                              .slideX(begin: -0.3, end: 0),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: widget.onHireMe,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: const Text('Hire Me'),
                          )
                              .animate()
                              .fade(duration: 600.ms)
                              .slideX(begin: 0.3, end: 0),
                        ],
                      ),
                    ],
                  ),
                ).animate().fade(duration: 600.ms).slideX(begin: 0.3, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
