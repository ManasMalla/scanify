import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/scanner.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Transform.translate(
                          offset: const Offset(8, -8),
                          child: Transform.rotate(
                            angle: -20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/scanner.jpg",
                                fit: BoxFit.cover,
                                width: 64,
                                height: 64,
                                color: const Color(0x60981F2B),
                                colorBlendMode: BlendMode.multiply,
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            "assets/scanner.jpg",
                            fit: BoxFit.cover,
                            width: 64,
                            height: 64,
                          ),
                        ),
                        Positioned(
                          bottom: -6,
                          right: -6,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                color: Color(0xFF981F2B),
                                shape: BoxShape.circle),
                            child: Text(
                              "4",
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                          border: Border.all(
                              width: 4,
                              color: Colors.white.withOpacity(0.5),
                              strokeAlign: BorderSide.strokeAlignOutside)),
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.5)),
                      ),
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: const Icon(
                        FeatherIcons.zap,
                        color: Color(0x50202023),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
