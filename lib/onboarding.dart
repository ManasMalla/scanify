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
                Spacer(),
                Container(
                  color: Color(0xFF981F2B),
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
                      SizedBox(
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
                                          ? Color(0xFFFFFFFF)
                                          : Color(0x50FFFFFF),
                                      height: 8,
                                      width: 8,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, _) {
                                  return SizedBox(
                                    width: 12,
                                  );
                                },
                                itemCount: 5),
                          )),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 340,
              child: SvgPicture.asset(
                image,
                width: constraints.maxWidth,
              ),
            ),
            Positioned(
              bottom: 280,
              right: 16,
              child: FloatingActionButton(
                shape: CircleBorder(),
                backgroundColor: Color(0xFFFFAC00),
                foregroundColor: Colors.white,
                onPressed: () {
                  onNext();
                },
                child: Icon(Icons.chevron_right),
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
    "View and manage your class schedules, exam dates, and other important academic events",
    "Receive notifications to remind you about upcoming events, deadlines and other important information",
    "Set reminders for specific events, lectures, seminars or tasks and balance out your academic life",
    "Customise your notification preferences and get the work done ahead of time",
    "Achieve more with GITAM by planning and balancing out your academic life and your passion"
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
