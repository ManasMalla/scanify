import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanify/login_screen.dart';

class Onboarding extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int index;
  final Function() onNext;
  const Onboarding(this.title, this.description, this.image, this.index,
      {super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SvgPicture.asset(
                    "assets/scanify.svg",
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                const Spacer(),
                Container(
                  color: const Color(0xFF981F2B),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 48.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24, top: 8),
                        child: Text(
                          description,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7)),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 36),
                          child: SizedBox(
                            height: 8,
                            child: ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, dotIndex) {
                                  return ClipOval(
                                    child: Container(
                                      color: dotIndex == index
                                          ? const Color(0xFFFFFFFF)
                                          : const Color(0x50FFFFFF),
                                      height: 8,
                                      width: 8,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, _) {
                                  return const SizedBox(
                                    width: 12,
                                  );
                                },
                                itemCount: 4),
                          )),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: index == 0 ? 360 : 310,
              child: SvgPicture.asset(
                image,
                width: constraints.maxWidth,
              ),
            ),
            Positioned(
              bottom: 280,
              right: 16,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: const Color(0xFFFFAC00),
                foregroundColor: Colors.white,
                onPressed: () {
                  onNext();
                },
                child: const Icon(Icons.chevron_right),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var titles = [
    "Scanning has\nnever gotten easier.",
    "Crop. Edit.\nOrganize.",
    "Secure &\nSeamless.",
    "OCR &\nConvert.",
  ];
  var descriptions = [
    "No more skewed angles, faded text, or smudged ink — scan as crisp as if they came straight off a flatbed scanner",
    "User-friendly interface to crop, edit, tag and organize your scanned documents",
    "Seamlessly integrated, your documents are securely backed up and easily accessible from any device, anywhere in the world",
    "Imagine capturing important information on the go, converting physical documents into high-quality digital files",
  ];
  var images = [
    "assets/People search-pana.svg",
    "assets/Editorial commision-pana.svg",
    "assets/Add files-cuate.svg",
    "assets/Annotation-pana.svg"
  ];
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemBuilder: (context, pageIndex) {
        return Onboarding(
          titles[pageIndex],
          descriptions[pageIndex],
          images[pageIndex],
          pageIndex,
          onNext: () {
            if (pageIndex == 3) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            } else {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            }
          },
        );
      },
      itemCount: 5,
    );
  }
}
