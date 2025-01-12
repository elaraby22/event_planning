import 'package:event_planning/ui/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../utils/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
        color: AppColors.primaryLight,
        fontWeight: FontWeight.bold,
        fontSize: 20.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          color: AppColors.primaryDark,
          fontSize: 24.0,
          fontWeight: FontWeight.bold),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: AppColors.whiteColor,
      imageFlex: 3,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      globalHeader: Image.asset('assets/images/evently_title.png'),
      dotsFlex: 3,
      dotsDecorator: DotsDecorator(
          size: const Size.square(10),
          activeSize: Size(20.0, 10.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: AppColors.blackColor,
          activeColor: AppColors.primaryLight),
      globalBackgroundColor: AppColors.whiteColor,
      showDoneButton: true,
      onDone: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
      done: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 1, color: AppColors.primaryLight)),
        child: Icon(
          Icons.arrow_forward,
          color: AppColors.primaryLight,
        ),
      ),
      showNextButton: true,
      next: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 1, color: AppColors.primaryLight)),
        child: Icon(
          Icons.arrow_forward,
          color: AppColors.primaryLight,
        ),
      ),
      showBackButton: true,
      back: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 1, color: AppColors.primaryLight)),
        child: Icon(
          Icons.arrow_back,
          color: AppColors.primaryLight,
        ),
      ),
      pages: [
        PageViewModel(
          title: "Find Events That Inspire You",
          body:
              "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
          image: _buildImage('onboarding_light2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Effortless Event Planning",
          body:
              "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
          image: _buildImage('onboarding_light3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Connect with Friends & Share Moments",
          body:
              "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
          image: _buildImage('onboarding_light4.png'),
          decoration: pageDecoration,
        ),
      ],
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }
}
