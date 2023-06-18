import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanify/onboarding.dart';

import 'dashboard_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(
                    "assets/gitam_logo.png",
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  width: double.infinity,
                  color: Color(0xFF981F2B),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Scanify",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.7,
                        child: Text(
                          "Never again let forgetfulness or lack of awareness let you miss upcoming academic events and deadlines",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FirebaseAuth.instance.currentUser != null
                                          ? const DashboardScreen()
                                          : const OnboardingScreen()));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Get Started".toUpperCase(),
                              style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              child: SvgPicture.asset(
                "assets/Thesis-pana.svg",
                width: constraints.maxWidth,
              ),
              top: 100,
            ),
          ],
        ),
      );
    }));
  }
}
