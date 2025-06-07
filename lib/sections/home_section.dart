import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'dart:html' as html;
import 'package:portfolio/sections/mobile_mockup_section.dart';
import 'package:portfolio/widgets/custom_button.dart';

class HomeSection extends StatefulWidget {
  final VoidCallback? onHireMe;
  final ScrollController? scrollController;
  const HomeSection({Key? key, this.onHireMe, this.scrollController})
      : super(key: key);

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
          // Video Background
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          // Content
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 800) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const MobileMockupSection(),
                            const SizedBox(height: 80),
                            GlassmorphicContainer(
                              width: 350,
                              height: 450,
                              borderRadius: 20,
                              blur: 20,
                              alignment: Alignment.center,
                              border: 2,
                              linearGradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.2),
                                  Colors.white.withOpacity(0.05),
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
                                    radius: 60,
                                    backgroundImage:
                                        AssetImage("assets/profile.jpg"),
                                  )
                                      .animate()
                                      .scale(duration: 600.ms)
                                      .fade(duration: 600.ms),
                                  const SizedBox(height: 24),
                                  Text(
                                    'Welcome to My Portfolio',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.center,
                                  )
                                      .animate()
                                      .fade(duration: 600.ms)
                                      .slideY(begin: 0.3, end: 0),
                                  const SizedBox(height: 16),
                                  AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        'Mobile App\n Developer',
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        speed:
                                            const Duration(milliseconds: 100),
                                        textAlign: TextAlign.center,
                                      ),
                                      TypewriterAnimatedText(
                                        'Flutter Developer',
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        speed:
                                            const Duration(milliseconds: 100),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                    totalRepeatCount: 1,
                                    displayFullTextOnTap: true,
                                    stopPauseOnTap: true,
                                  ),
                                  const SizedBox(height: 32),
                                  Wrap(
                                    spacing: 20,
                                    runSpacing: 20,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      CustomButton(
                                        text: 'Resume',
                                        onPressed: () {
                                          const url =
                                              'https://drive.google.com/file/d/1v4xAd_fO9mLMiXhugxV-QBYPeEYb0uiW/view?usp=drive_link';
                                          html.window.open(url, '_blank');
                                        },
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 8),
                                        textStyle: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                        isOutlined: true,
                                        borderColor: Colors.grey[800],
                                      ),
                                      CustomButton(
                                        text: 'Hire Me',
                                        onPressed: () {
                                          if (widget.scrollController != null) {
                                            widget.scrollController!.animateTo(
                                              widget.scrollController!.position
                                                  .maxScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 8),
                                        textStyle: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      )
                                          .animate()
                                          .fade(duration: 600.ms)
                                          .slideX(begin: 0.3, end: 0),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const MobileMockupSection(),
                          const SizedBox(width: 80),
                          GlassmorphicContainer(
                            width: 350,
                            height: 450,
                            borderRadius: 20,
                            blur: 20,
                            alignment: Alignment.center,
                            border: 2,
                            linearGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.05),
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
                                  radius: 60,
                                  backgroundImage:
                                      AssetImage("assets/profile.jpg"),
                                )
                                    .animate()
                                    .scale(duration: 600.ms)
                                    .fade(duration: 600.ms),
                                const SizedBox(height: 24),
                                Text(
                                  'Welcome to My Portfolio',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  textAlign: TextAlign.center,
                                )
                                    .animate()
                                    .fade(duration: 600.ms)
                                    .slideY(begin: 0.3, end: 0),
                                const SizedBox(height: 16),
                                AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      'Mobile App\n Developer',
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                      textAlign: TextAlign.center,
                                    ),
                                    TypewriterAnimatedText(
                                      'Flutter Developer',
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                  totalRepeatCount: 1,
                                  displayFullTextOnTap: true,
                                  stopPauseOnTap: true,
                                ),
                                const SizedBox(height: 32),
                                Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    CustomButton(
                                      text: 'Resume',
                                      onPressed: () {
                                        const url =
                                            'https://drive.google.com/file/d/1v4xAd_fO9mLMiXhugxV-QBYPeEYb0uiW/view?usp=drive_link';
                                        html.window.open(url, '_blank');
                                      },
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 8),
                                      textStyle: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                      isOutlined: true,
                                      borderColor: Colors.grey[800],
                                    ),
                                    CustomButton(
                                      text: 'Hire Me',
                                      onPressed: () {
                                        if (widget.scrollController != null) {
                                          widget.scrollController!.animateTo(
                                            widget.scrollController!.position
                                                .maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      },
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 8),
                                      textStyle: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    )
                                        .animate()
                                        .fade(duration: 600.ms)
                                        .slideX(begin: 0.3, end: 0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
