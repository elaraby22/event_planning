import 'package:event_planning/ui/home_screen/tabs/favorite/favorite_tab.dart';
import 'package:event_planning/ui/home_screen/tabs/home/add_Event/add_event.dart';
import 'package:event_planning/ui/home_screen/tabs/home/home_tab.dart';
import 'package:event_planning/ui/home_screen/tabs/map/map_tab.dart';
import 'package:event_planning/ui/home_screen/tabs/profile/profile_tab.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), FavoriteTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data:
            Theme.of(context).copyWith(canvasColor: AppColors.transparentColor),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                buildBottomNavItems(
                    index: 0,
                    iconSelectedName: AssetsManager.iconSelectedHome,
                    iconName: AssetsManager.iconHome,
                    label: AppLocalizations.of(context)!.home),
                buildBottomNavItems(
                    index: 1,
                    iconSelectedName: AssetsManager.iconSelectedMap,
                    iconName: AssetsManager.iconMap,
                    label: AppLocalizations.of(context)!.map),
                buildBottomNavItems(
                    index: 2,
                    iconSelectedName: AssetsManager.iconSelectedFavorite,
                    iconName: AssetsManager.iconFavorite,
                    label: AppLocalizations.of(context)!.favorite),
                buildBottomNavItems(
                    index: 3,
                    iconSelectedName: AssetsManager.iconSelectedProfile,
                    iconName: AssetsManager.iconProfile,
                    label: AppLocalizations.of(context)!.profile),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add event
          // navigate to add event screen
          Navigator.of(context).pushNamed(AddEvent.routeName);
        },
        child: Icon(
          Icons.add,
          color: AppColors.whiteColor,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavItems(
      {required int index,
      required String iconName,
      required String label,
      required String iconSelectedName}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage(selectedIndex == index ? iconSelectedName : iconName)),
        label: label);
  }
}
