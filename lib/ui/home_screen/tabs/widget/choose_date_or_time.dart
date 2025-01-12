import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ChooseDateOrTime extends StatelessWidget {
  String iconName;
  String eventDateOrTime;
  String chooseDateOrTime;
  Function onChooseDateOrTime;

  ChooseDateOrTime(
      {required this.iconName,
      required this.eventDateOrTime,
      required this.chooseDateOrTime,
      required this.onChooseDateOrTime});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(iconName),
        SizedBox(
          width: width * 0.02,
        ),
        Text(
          eventDateOrTime,
          style: AppStyles.medium16Black,
        ),
        Spacer(),
        TextButton(
            onPressed: () {
              onChooseDateOrTime();
            },
            child: Text(
              chooseDateOrTime,
              style: AppStyles.medium16Primary,
            ))
      ],
    );
  }
}
