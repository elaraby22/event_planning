import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/model/event.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:event_planning/ui/home_screen/tabs/widget/choose_date_or_time.dart';
import 'package:event_planning/ui/home_screen/tabs/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/home_screen/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = 'add_event';

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime? selectedDate;
  String formatedDate = '';
  TimeOfDay? selectedTime;
  String? formatedTime;
  String selectedImage = '';
  String selectedEvent = '';
  late EventListProvider eventListProvider; // global
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    eventListProvider.getEventNameList(context);
    eventListProvider.eventsNameList.removeAt(0);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List<String> imageSelectedNameList = [
      AssetsManager.sportImage,
      AssetsManager.birthdayImage,
      AssetsManager.meetingImage,
      AssetsManager.gamingImage,
      AssetsManager.workshopImage,
      AssetsManager.bookClubImage,
      AssetsManager.exhibitionImage,
      AssetsManager.holidayImage,
      AssetsManager.eatingImage,
    ];

    selectedImage = imageSelectedNameList[eventListProvider.selectedIndex];
    selectedEvent =
        eventListProvider.eventsNameList[eventListProvider.selectedIndex];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyles.medium20Primary,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.asset(
                    imageSelectedNameList[eventListProvider.selectedIndex]),
                borderRadius: BorderRadius.circular(16),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                height: height * 0.05,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          eventListProvider.changeSelectedIndex(
                              index, userProvider.currentUser!.id);
                        },
                        child: TabEventWidget(
                            borderColor: AppColors.primaryLight,
                            backgroundColor: AppColors.primaryLight,
                            textSelectedStyle: AppStyles.bold16White,
                            textUnSelectedStyle: AppStyles.bold16Primary,
                            eventName: eventListProvider.eventsNameList[index],
                            isSelected:
                                eventListProvider.selectedIndex == index),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: width * 0.01,
                      );
                    },
                    itemCount: eventListProvider.eventsNameList.length),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.title,
                        style: AppStyles.medium16Black,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomTextField(
                        controller: titleController,
                        hintText: AppLocalizations.of(context)!.event_title,
                        prefixIcon: Image.asset(AssetsManager.iconEdit),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_event_title;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        AppLocalizations.of(context)!.description,
                        style: AppStyles.medium16Black,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomTextField(
                        controller: descriptionController,
                        hintText:
                            AppLocalizations.of(context)!.event_description,
                        maxLines: 4,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_event_description;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      ChooseDateOrTime(
                          iconName: AssetsManager.iconDate,
                          eventDateOrTime:
                              AppLocalizations.of(context)!.event_date,
                          chooseDateOrTime: selectedDate == null
                              ? AppLocalizations.of(context)!.choose_date
                              : DateFormat('dd/MM/yyyy').format(selectedDate!),
                          // formatedDate,
                          // '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                          onChooseDateOrTime: chooseDate),
                      ChooseDateOrTime(
                          iconName: AssetsManager.iconTime,
                          eventDateOrTime:
                              AppLocalizations.of(context)!.event_time,
                          chooseDateOrTime: formatedTime == null
                              ? AppLocalizations.of(context)!.choose_time
                              : formatedTime!,
                          onChooseDateOrTime: chooseTime),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        AppLocalizations.of(context)!.location,
                        style: AppStyles.medium16Black,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: AppColors.primaryLight, width: 2)),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04,
                                  vertical: height * 0.02),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.primaryLight),
                              child: Image.asset(AssetsManager.iconLocation),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .choose_event_location,
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
                      CustomElevatedButton(
                          text: AppLocalizations.of(context)!.add_event,
                          textStyle: AppStyles.medium20White,
                          onButtonClicked: addEvent)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      //todo: add event
      Event event = Event(
          title: titleController.text,
          description: descriptionController.text,
          image: selectedImage,
          eventName: selectedEvent,
          dateTime: selectedDate!,
          time: formatedTime!);
      FirebaseUtils.addEventToFireStore(event, userProvider.currentUser!.id)
          .then((value) {
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.event_added_successfully,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // todo: refresh eventsList
        eventListProvider.changeSelectedIndex(
            eventListProvider.selectedIndex, userProvider.currentUser!.id);
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.event_added_successfully,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // todo: refresh eventsList
        eventListProvider.changeSelectedIndex(
            eventListProvider.selectedIndex, userProvider.currentUser!.id);
        Navigator.pop(context);
      });
    }
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chooseDate;
    formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime = chooseTime;
    formatedTime = selectedTime!.format(context);
    setState(() {});
  }
}
