import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../firebase_utils.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier {
  // data
  List<Event> eventsList = [];
  int selectedIndex = 0;
  List<String> eventsNameList = [];
  Map<String, String> categoryData = {};

  void getEventNameList(BuildContext context) {
    eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];

    categoryData = {
      AppLocalizations.of(context)!.all: "All",
      AppLocalizations.of(context)!.sport: "Sport",
      AppLocalizations.of(context)!.birthday: "Birthday",
      AppLocalizations.of(context)!.meeting: "Meeting",
      AppLocalizations.of(context)!.gaming: "Gaming",
      AppLocalizations.of(context)!.workshop: "Workshop",
      AppLocalizations.of(context)!.book_club: "Book Club",
      AppLocalizations.of(context)!.exhibition: "Exhibition",
      AppLocalizations.of(context)!.holiday: "Holiday",
      AppLocalizations.of(context)!.eating: "Eating",
    };
  }

  List<Event> filterList = []; // filter (eventName)

  List<Event> favoriteList = [];

  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId).get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterList = eventsList;

    //todo: sorting
    filterList.sort((Event event1, Event event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getAllEvents1(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
            .orderBy('dateTime', descending: false)
            .get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterList = eventsList;
    //
    // //todo: sorting
    // filterList.sort((Event event1 , Event event2){
    //   return event1.dateTime.compareTo(event2.dateTime);
    // });
    notifyListeners();
  }

  void getFilterEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId).get();
    //todo: get all events
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    String? selectedCategory =
        categoryData[eventsNameList[selectedIndex] ?? "All"];

    //todo: filter eventList
    filterList = eventsList.where((event) {
      return event.eventName == selectedCategory;
    }).toList();

    //todo: sorting
    filterList.sort((Event event1, Event event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });

    notifyListeners();
  }

  void getFilterEvents1(String uId) async {
    String? selectedCategory =
        categoryData[eventsNameList[selectedIndex] ?? "All"];
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
            .orderBy('dateTime', descending: false)
            .where('eventName', isEqualTo: selectedCategory)
            .get();
    //todo: get all events
    filterList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    // filterList = eventsList.where((event){
    //   return event.eventName == eventsNameList[selectedIndex];
    // }).toList();
    notifyListeners();
  }

  void updateIsFavoriteEvent(Event event, BuildContext context, String uId) {
    FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .update({'isFavorite': !event.isFavorite}).timeout(
            Duration(milliseconds: 500), onTimeout: () {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.event_added_to_favorite,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
    getFavoriteEvent(uId);
  }

  void getFavoriteEvent(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(uId)
        .orderBy('dateTime', descending: false)
        .where('isFavorite', isEqualTo: true)
        .get();
    favoriteList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void updateEventDetails(Event event, String uId) {
    FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .update(event.toFireStore())
        .timeout(Duration(milliseconds: 500), onTimeout: () {
      print('done');
    });
    notifyListeners();
  }

  void deleteEvent(Event event, String uId, BuildContext context) {
    FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .delete()
        .timeout(Duration(milliseconds: 500), onTimeout: () {
      Fluttertoast.showToast(
          msg: 'Event Deleted Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }).then((value) {
      Fluttertoast.showToast(
          msg: 'Event Deleted Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    if (selectedIndex == 0) {
      // todo: All
      getAllEvents(uId);
    } else {
      getFilterEvents(uId);
    }
  }
}
