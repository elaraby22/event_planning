import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  Color? backgroundColor;
  Widget? iconButton;
  String? text;
  TextStyle textStyle;
  Color? borderSide;
  Function onButtonClicked;

  CustomElevatedButton(
      {this.backgroundColor,
      this.iconButton,
      this.text,
      required this.textStyle,
      this.borderSide,
      required this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.02, horizontal: width * 0.05),
            backgroundColor: backgroundColor ?? AppColors.primaryLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: borderSide ?? AppColors.whiteColor))),
        onPressed: () {
          onButtonClicked();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconButton ?? SizedBox(),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              text ?? '',
              style: textStyle,
            )
          ],
        ));
  }
}
