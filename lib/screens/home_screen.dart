import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import '../widgets/curved_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showMessage(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Stack(
          children: [
            // Background diagonal lines
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: DiagonalLinesPainter(),
            ),
            
            // Small decorative elements
            Positioned(
              top: 20,
              left: 20,
              child: Column(
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade800,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade800,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade800,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            
            Positioned(
              top: 30,
              right: 30,
              child: Text(
                '×',
                style: TextStyle(
                  color: Colors.deepPurple.shade700,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            Positioned(
              bottom: 100,
              left: 20,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.deepPurple.shade600,
                    width: 1.5,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            
            Positioned(
              bottom: 120,
              right: 25,
              child: Icon(
                Icons.play_arrow,
                size: 16,
                color: Colors.deepPurple.shade700,
              ),
            ),
            
            Positioned(
              bottom: 80,
              right: 40,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade700,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade700,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade700,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            
            // Main content
            SingleChildScrollView(
              child: Column(
                children: [
                  const CurvedHeader(),
                  const SizedBox(height: 40),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        if (authProvider.tokenData != null) ...[
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'رقم الهاتف:',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      authProvider.tokenData!.msisdn,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'التوكن:',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        authProvider.tokenData!.accessToken,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'monospace',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                        
                        ElevatedButton(
                          onPressed: authProvider.isLoading
                              ? null
                              : () async {
                                  final success = await authProvider.login();
                                  if (success) {
                                    _showMessage(context, '✅ تم تسجيل الدخول بنجاح');
                                  } else if (authProvider.errorMessage != null) {
                                    _showMessage(
                                      context,
                                      authProvider.errorMessage!,
                                      isError: true,
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 8,
                            shadowColor: Colors.red.shade300,
                          ),
                          child: authProvider.isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  authProvider.tokenData != null
                                      ? 'تسجيل الدخول مرة أخرى'
                                      : 'تسجيل الدخول',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        
                        const SizedBox(height: 60),
                        
                        // Team Fox text
                        Text(
                          'Team Fox',
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}
}

class DiagonalLinesPainter extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {
final paint = Paint()
  ..color = Colors.grey.shade200
  ..strokeWidth = 0.5;

for (double i = -size.height; i < size.width + size.height; i += 30) {
  canvas.drawLine(
    Offset(i, 0),
    Offset(i + size.height, size.height),
    paint,
  );
}
}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
