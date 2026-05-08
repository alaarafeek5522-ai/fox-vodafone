import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SimCardWidget extends StatelessWidget {
  const SimCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.5;
    final cardHeight = cardWidth * 1.4;

    return Transform.rotate(
      angle: 0.08,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Stack(
          children: [
            // Chip
            Positioned(
              bottom: 16,
              left: 12,
              child: Container(
                width: cardWidth * 0.4,
                height: cardWidth * 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                ),
                child: Center(
                  child: Container(
                    width: cardWidth * 0.2,
                    height: cardWidth * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),

            // Cut line
            Positioned(
              right: 10,
              top: 0,
              bottom: 0,
              child: Container(
                width: 1.5,
                color: Colors.grey.shade200,
              ),
            ),

            // Vodafone Logo
            Positioned(
              top: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vodafone',
                    style: GoogleFonts.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.primaryRed,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: cardWidth * 0.3,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryRed,
                          AppTheme.darkRed,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Arabic Text
            Positioned(
              bottom: 40,
              left: 12,
              child: Text(
                'فكة فودافون',
                style: GoogleFonts.tajawal(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkRed,
                ),
              ),
            ),

            // Glossy effect
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: cardHeight * 0.3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.8),
                      Colors.white.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
