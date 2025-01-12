import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/ui/event_details/event_details_screen.dart';
import 'package:event_planning/ui/home_screen/tabs/home/event_item_widget.dart';
import 'package:event_planning/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    eventListProvider.getEventNameList(context);
    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyles.regular14White,
                ),
                Text(
                  userProvider.currentUser!.name,
                  style: AppStyles.bold24White,
                )
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.sunny,
                  color: AppColors.whiteColor,
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02, vertical: height * 0.01),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor),
                  child: Text(
                    'EN',
                    style: AppStyles.bold14Primary,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.01),
            height: height * 0.15,
            decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35))),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AssetsManager.iconMap),
                    Text(
                      'Cairo , Egypt',
                      style: AppStyles.medium14White,
                    )
                  ],
                ),
                DefaultTabController(
                    length: eventListProvider.eventsNameList.length,
                    child: TabBar(
                        onTap: (index) {
                          eventListProvider.changeSelectedIndex(
                              index, userProvider.currentUser!.id);
                        },
                        isScrollable: true,
                        indicatorColor: AppColors.transparentColor,
                        dividerHeight: 0,
                        tabAlignment: TabAlignment.start,
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: width * 0.01, vertical: height * 0.02),
                        tabs: eventListProvider.eventsNameList.map((eventName) {
                          return TabEventWidget(
                              backgroundColor: AppColors.whiteColor,
                              textSelectedStyle: AppStyles.medium16Primary,
                              textUnSelectedStyle: AppStyles.medium16White,
                              eventName: eventName,
                              isSelected: eventListProvider.selectedIndex ==
                                  eventListProvider.eventsNameList
                                      .indexOf(eventName));
                        }).toList())),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: eventListProvider.filterList.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context)!.no_items_found))
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          eventListProvider.selectedIndex = index;
                          Navigator.of(context)
                              .pushNamed(EventDetailsScreen.routeName);
                        },
                        child: EventItemWidget(
                          event: eventListProvider.filterList[index],
                        ),
                      );
                    },
                    itemCount: eventListProvider.filterList.length,
                  ),
          ))
        ],
      ),
    );
  }
}
