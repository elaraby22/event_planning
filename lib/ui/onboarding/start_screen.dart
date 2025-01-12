import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'onboarding_screen.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = 'start';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Image.asset(AssetsManager.eventlyTitle),
        centerTitle: true,
      ),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Image.asset(AssetsManager.onBoarding1Light),
              SizedBox(
                height: height * 0.02,
              ),
              Text('Personalize Your Experience',
                  textAlign: TextAlign.start, style: AppStyles.bold20Primary),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
                style: AppStyles.medium16Black,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: AppStyles.medium20Primary,
                  ),
                  Image.asset(AssetsManager.languageSwitch)
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: AppStyles.medium20Primary,
                  ),
                  Image.asset(AssetsManager.themeSwitch)
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: width * 0.03),
                      backgroundColor: AppColors.primaryLight,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, OnboardingScreen.routeName);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.lets_start,
                    style: AppStyles.medium20White,
                  )),
              SizedBox(
                height: height * 0.03,
              )
            ],
          ),
        ),
      ),
    );
  }
}
