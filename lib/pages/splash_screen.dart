import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cover_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();

    // Navigate when animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CoverPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive font sizes
    final double mainTitleSize = screenWidth * 0.15; // e.g., 64 on big phones
    final double subtitleSize = screenWidth * 0.07;
    final double taglineSize = screenWidth * 0.045;
    final double lineSize = screenWidth * 0.042;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD2691E),
              Color(0xFFFF8C00),
              Color(0xFFD2691E),
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Main title
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'GajalGam',
                            style: TextStyle(
                              fontSize: mainTitleSize,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              letterSpacing: 2.0,
                              shadows: [
                                Shadow(
                                  offset: const Offset(3, 3),
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                Shadow(
                                  offset: const Offset(-1, -1),
                                  blurRadius: 6,
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                Shadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 20,
                                  color:
                                      const Color(0xFFFFD700).withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Nepali subtitle
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'गजलगम',
                            style: TextStyle(
                              fontSize: subtitleSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.9),
                              shadows: [
                                Shadow(
                                  offset: const Offset(1, 1),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        // Tagline
                        Text(
                          'गजलहरू हृदयका रहस्य हुन्',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: taglineSize,
                            fontStyle: FontStyle.italic,
                            color: Colors.white.withOpacity(0.8),
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'जहाँ शब्द बोल्दैनन्, तर सुनिन्छन्',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: lineSize,
                            fontStyle: FontStyle.italic,
                            color: Colors.white.withOpacity(0.85),
                            letterSpacing: 1.0,
                            shadows: [
                              Shadow(
                                offset: const Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.08),

                        // Loading indicator
                        SizedBox(
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.7),
                            ),
                            strokeWidth: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
