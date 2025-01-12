import 'package:event_planning/model/event.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/event_list_provider.dart';

class EventItemWidget extends StatelessWidget {
  Event event;

  EventItemWidget({required this.event});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      height: height * 0.30,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryLight, width: 2),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(event.image))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.005),
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.whiteColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.dateTime.day.toString(),
                  style: AppStyles.bold20Primary,
                ),
                Text(
                  DateFormat('MMM').format(event.dateTime),
                  style: AppStyles.bold14Primary,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.01),
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: AppStyles.bold14Black,
                  ),
                ),
                InkWell(
                    onTap: () {
                      eventListProvider.updateIsFavoriteEvent(
                          event, context, userProvider.currentUser!.id);
                      // changeFavoriteEvent();
                      // setState(() {
                      //
                      // });
                    },
                    child: Image.asset(
                      event.isFavorite == true
                          ? AssetsManager.iconEventSelectedFavorite
                          : AssetsManager.iconFavorite,
                      color: AppColors.primaryLight,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
