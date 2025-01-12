import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/event.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../home_screen/tabs/home/tab_event_widget.dart';
import '../home_screen/tabs/widget/choose_date_or_time.dart';
import '../home_screen/tabs/widget/custom_elevated_button.dart';
import '../home_screen/tabs/widget/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = 'edit_event';

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  String editedImage = '';
  String editedEvent = '';
  var formKey = GlobalKey<FormState>();
  var titleEdited = TextEditingController();
  var descriptionEdited = TextEditingController();
  DateTime? editedDate;
  String formatedDate = '';
  TimeOfDay? selectedTime;
  String? editedTime;
  late EventListProvider eventListProvider;
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    eventListProvider.getEventNameList(context);
    eventListProvider.eventsNameList.removeAt(0);
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

    editedImage = imageSelectedNameList[eventListProvider.selectedIndex];
    editedEvent =
        eventListProvider.eventsNameList[eventListProvider.selectedIndex];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text(
          AppLocalizations.of(context)!.edit_event,
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
                child: Image.asset(eventListProvider
                    .filterList[eventListProvider.selectedIndex].image),
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
                            isSelected: eventListProvider
                                    .eventsNameList[index] ==
                                eventListProvider
                                    .filterList[eventListProvider.selectedIndex]
                                    .eventName),
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
                        controller: titleEdited,
                        hintText: eventListProvider
                            .filterList[eventListProvider.selectedIndex].title,
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
                        controller: descriptionEdited,
                        hintText: eventListProvider
                            .filterList[eventListProvider.selectedIndex]
                            .description,
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
                          chooseDateOrTime: editedDate == null
                              ? DateFormat('dd/MM/yyyy').format(
                                  eventListProvider
                                      .filterList[
                                          eventListProvider.selectedIndex]
                                      .dateTime)
                              : DateFormat('dd/MM/yyyy').format(editedDate!),
                          onChooseDateOrTime: chooseDate),
                      ChooseDateOrTime(
                          iconName: AssetsManager.iconTime,
                          eventDateOrTime:
                              AppLocalizations.of(context)!.event_time,
                          chooseDateOrTime: editedTime == null
                              ? eventListProvider
                                  .filterList[eventListProvider.selectedIndex]
                                  .time
                              : editedTime!,
                          onChooseDateOrTime: chooseTime),
                      SizedBox(
                        height: height * 0.02,
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
                          text: AppLocalizations.of(context)!.update_event,
                          textStyle: AppStyles.medium20White,
                          onButtonClicked: () {
                            editEvent();
                          })
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void editEvent() {
    if (formKey.currentState?.validate() == true) {
      //todo: update event
      Event event = Event(
          id: eventListProvider.filterList[eventListProvider.selectedIndex].id,
          title: titleEdited.text.isEmpty
              ? eventListProvider
                  .filterList[eventListProvider.selectedIndex].title
              : titleEdited.text,
          description: descriptionEdited.text.isEmpty
              ? eventListProvider
                  .filterList[eventListProvider.selectedIndex].description
              : descriptionEdited.text,
          image: editedImage,
          eventName: editedEvent,
          dateTime: editedDate ??
              eventListProvider
                  .filterList[eventListProvider.selectedIndex].dateTime,
          time: editedTime ??
              eventListProvider
                  .filterList[eventListProvider.selectedIndex].time);
      eventListProvider.updateEventDetails(event, userProvider.currentUser!.id);
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
      Navigator.of(context).pop();
    }
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    editedDate = chooseDate;
    formatedDate = DateFormat('dd/MM/yyyy').format(editedDate!);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime = chooseTime;
    editedTime = selectedTime!.format(context);
    setState(() {});
  }
}
