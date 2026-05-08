import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Stack(
        children: [
          // Top organic waves
          Positioned(
            top: -size.height * 0.05,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(size.width, size.height * 0.42),
              painter: WavePainter(),
            ).animate().fadeIn(duration: 600.ms).slideY(
                  begin: -0.1,
                  end: 0,
                  duration: 800.ms,
                  curve: Curves.easeOut,
                ),
          ),

          // Geometric play button shape
          Positioned(
            top: size.height * 0.14,
            left: size.width * 0.5 - 55,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.crimsonRed,
                    AppTheme.darkRed,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkRed.withValues(alpha: 0.4),
                    blurRadius: 30,
                    offset: const Offset(0, 8),
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ).animate().scale(
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1),
                  duration: 900.ms,
                  curve: Curves.elasticOut,
                ),
          ),

          // SIM Card
          Positioned(
            top: size.height * 0.2,
            right: size.width * 0.35,
            child: Transform.rotate(
              angle: 0.15,
              child: _buildSimCard(size).animate().fadeIn(
                    delay: 400.ms,
                    duration: 800.ms,
                  ).slideX(
                    begin: 0.3,
                    end: 0,
                    duration: 800.ms,
                    curve: Curves.easeOut,
                  ),
            ),
          ),

          // Bottom content
          Positioned(
            bottom: size.height * 0.15,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Fox Vodafone',
                  style: GoogleFonts.tajawal(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.darkRed,
                    letterSpacing: -1,
                  ),
                ).animate().fadeIn(
                      delay: 1000.ms,
                      duration: 600.ms,
                    ).slideY(
                      begin: 0.3,
                      end: 0,
                      delay: 1000.ms,
                      duration: 600.ms,
                    ),
                const SizedBox(height: 8),
                Text(
                  'فكة فودافون',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryRed,
                    letterSpacing: 2,
                  ),
                ).animate().fadeIn(
                      delay: 1200.ms,
                      duration: 600.ms,
                    ),
                const SizedBox(height: 40),
                _buildLoadingIndicator(),
              ],
            ),
          ),

          // Decorative elements
          Positioned(
            top: size.height * 0.08,
            left: 30,
            child: Column(
              children: [
                _buildDot(),
                const SizedBox(height: 4),
                _buildDot(),
                const SizedBox(height: 4),
                _buildDot(),
              ],
            ),
          ).animate().fadeIn(delay: 800.ms),

          Positioned(
            top: size.height * 0.6,
            right: 40,
            child: const Icon(
              Icons.close,
              color: AppTheme.burgundy,
              size: 16,
            ),
          ).animate().fadeIn(delay: 1000.ms),

          Positioned(
            top: size.height * 0.55,
            left: 50,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.burgundy,
                  width: 1.5,
                ),
              ),
            ),
          ).animate().fadeIn(delay: 1100.ms),

          Positioned(
            top: size.height * 0.65,
            left: 70,
            child: Row(
              children: [
                _buildDot(),
                const SizedBox(width: 4),
                _buildDot(),
                const SizedBox(width: 4),
                _buildDot(),
              ],
            ),
          ).animate().fadeIn(delay: 1200.ms),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 5,
      height: 5,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.burgundy,
      ),
    );
  }

  Widget _buildSimCard(Size size) {
    return Container(
      width: size.width * 0.18,
      height: size.width * 0.24,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Stack(
        children: [
          // Chip
          Positioned(
            bottom: 8,
            left: 6,
            child: Container(
              width: size.width * 0.08,
              height: size.width * 0.06,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
          ),
          // Cut line
          Positioned(
            right: 5,
            top: 0,
            bottom: 0,
            child: Container(
              width: 1,
              color: Colors.grey.shade200,
            ),
          ),
          // Vodafone logo
          Positioned(
            top: 4,
            left: 4,
            child: Text(
              'Vodafone',
              style: GoogleFonts.tajawal(
                fontSize: 7,
                fontWeight: FontWeight.w900,
                color: AppTheme.primaryRed,
              ),
            ),
          ),
          // Text
          Positioned(
            bottom: 14,
            left: 4,
            child: Text(
              'فكة',
              style: GoogleFonts.tajawal(
                fontSize: 5,
                fontWeight: FontWeight.w700,
                color: AppTheme.darkRed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          AppTheme.primaryRed.withValues(alpha: 0.7),
        ),
      ),
    ).animate(onPlay: (controller) => controller.repeat()).shimmer(
          duration: 1500.ms,
          color: AppTheme.primaryRed.withValues(alpha: 0.1),
        );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppTheme.crimsonRed,
          AppTheme.primaryRed,
          AppTheme.darkRed,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(0, size.height * 0.45);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.35,
      size.width * 0.5,
      size.height * 0.55,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.75,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);

    // Second layer
    final paint2 = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppTheme.darkRed.withValues(alpha: 0.6),
          AppTheme.darkRed.withValues(alpha: 0.2),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path2 = Path();
    path2.moveTo(0, size.height * 0.6);
    path2.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.5,
      size.width * 0.6,
      size.height * 0.7,
    );
    path2.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.85,
      size.width,
      size.height * 0.75,
    );
    path2.lineTo(size.width, 0);
    path2.lineTo(0, 0);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
