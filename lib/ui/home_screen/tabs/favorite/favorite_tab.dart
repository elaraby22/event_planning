import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/event_list_provider.dart';
import '../home/event_item_widget.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if (eventListProvider.favoriteList.isEmpty) {
      eventListProvider.getFavoriteEvent(userProvider.currentUser!.id);
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          children: [
            CustomTextField(
              borderColor: AppColors.primaryLight,
              hintText: AppLocalizations.of(context)!.search_for_event,
              hintStyle: AppStyles.bold14Primary,
              prefixIcon: Image.asset(AssetsManager.iconSearch),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Expanded(
                child: eventListProvider.favoriteList.isEmpty
                    ? Center(
                        child: Text('No favorite events found'),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return EventItemWidget(
                              event: eventListProvider.favoriteList[index]);
                        },
                        itemCount: eventListProvider.favoriteList.length,
                      ))
          ],
        ),
      ),
    );
  }
}
