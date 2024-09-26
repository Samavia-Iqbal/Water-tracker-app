
import 'package:flutter/material.dart';
import 'package:water_tracker_app/boarding_data/onboarding_data.dart';
import 'package:water_tracker_app/utils/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = OnBoardingData();
  final pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 60,
          ),
          child: Column(
            children: [body(), buildDots(), button()],
          ),
        ));
  }

  //Body
  Widget body() {
    return Expanded(
        child: PageView.builder(
            controller: pageController,
            itemCount: controller.items.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // Images
                  Image.asset(controller.items[currentIndex].image),

                  // Titles
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      controller.items[currentIndex].title,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      controller.items[currentIndex].description,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: grColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              );
            }));
  }

  //Dots
  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          controller.items.length,
          (index) => AnimatedContainer(
              height: 7,
              width: currentIndex == index ? 30 : 14,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: currentIndex == index ? primaryColor : gColor,
              ),
              duration: const Duration(milliseconds: 700))),
    );
  }

// Button
  Widget button() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 100),
        width: MediaQuery.of(context).size.width * 0.7,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: primaryColor),
        child: TextButton(
          onPressed: () {
            setState(() {
              currentIndex != controller.items.length - 1
                  ? currentIndex++
                  : null;
            });
          },
          child: Text(
            currentIndex == controller.items.length - 1
                ? "Get Started"
                : "Next",
            style: TextStyle(
                color: wColor, fontSize: 23, fontWeight: FontWeight.w800),
          ),
        ));
  }
}
