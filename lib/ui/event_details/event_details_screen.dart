import 'package:event_planning/ui/event_details/edit_event.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/event_list_provider.dart';
import '../../providers/user_provider.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = 'event_details';

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text(AppLocalizations.of(context)!.event_details),
        titleTextStyle: AppStyles.medium20Primary,
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {
                eventListProvider
                    .filterList[eventListProvider.selectedIndex].id;
                Navigator.of(context).pushNamed(EditEventScreen.routeName);
                // eventListProvider.updateEventDetails(eventListProvider.filterList[eventListProvider.selectedIndex],
                //     userProvider.currentUser!.id);
              },
              child: Image.asset(AssetsManager.iconEditDetails)),
          SizedBox(
            width: width * 0.02,
          ),
          InkWell(
              onTap: () {
                eventListProvider.deleteEvent(
                    eventListProvider
                        .filterList[eventListProvider.selectedIndex],
                    userProvider.currentUser!.id,
                    context);
                eventListProvider.changeSelectedIndex(
                    eventListProvider.selectedIndex,
                    userProvider.currentUser!.id);
                Navigator.of(context).pop();
              },
              child: Image.asset(AssetsManager.iconDelete)),
          SizedBox(
            width: width * 0.02,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(eventListProvider
                      .filterList[eventListProvider.selectedIndex].image)),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                eventListProvider
                    .filterList[eventListProvider.selectedIndex].title,
                style: AppStyles.medium20Primary,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.02,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primaryLight, width: 1)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.013,
                        horizontal: width * 0.025,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.asset(AssetsManager.iconCalendar),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMMM yyyy').format(eventListProvider
                              .filterList[eventListProvider.selectedIndex]
                              .dateTime),
                          style: AppStyles.medium16Primary,
                        ),
                        Text(
                          eventListProvider
                              .filterList[eventListProvider.selectedIndex].time,
                          style: AppStyles.medium16Black,
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.02,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primaryLight, width: 1)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.013,
                        horizontal: width * 0.025,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.asset(AssetsManager.iconLocation),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      'Cairo , Egypt',
                      style: AppStyles.medium16Primary,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.primaryLight,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Image.asset(AssetsManager.mapImage),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: AppStyles.medium16Black,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                eventListProvider
                    .filterList[eventListProvider.selectedIndex].description,
                style: AppStyles.medium16Black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
