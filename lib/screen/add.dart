import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/static/category.dart';
import 'package:evently/data/model/event_model.dart';
import 'package:evently/firebase/firebase.dart';
import 'package:evently/provider/provider.dart';
import 'package:evently/widget/add/custom_add_time.dart';
import 'package:evently/widget/customs/button.dart';
import 'package:evently/widget/customs/text_form.dart';
import 'package:evently/widget/home/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int i = 0;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    title = TextEditingController();
    description = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    double h = MediaQuery.of(context).size.height;

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          "create_event".tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16)),
                height: h / 4,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    event[i + 1]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        scrollDirection: Axis.horizontal,
                        itemCount: event.length - 1,
                        itemBuilder: (context, index) => SizedBox(
                              height: 10,
                              width: 150,
                              child: InkWell(
                                onTap: () {
                                  i = index;
                                  setState(() {});
                                },
                                child: CustomCategories(
                                  borderColor:
                                      provider.themeMode == ThemeMode.light
                                          ? AppColors.background
                                          : AppColors.primaryColor,
                                  textColor: i == index
                                      ? provider.themeMode == ThemeMode.light
                                          ? AppColors.primaryColor
                                          : AppColorsDark.background
                                      : provider.themeMode == ThemeMode.light
                                          ? AppColors.background
                                          : AppColors.primaryColor,
                                  backgroundColor: i == index
                                      ? provider.themeMode == ThemeMode.light
                                          ? AppColors.background
                                          : AppColors.primaryColor
                                      : provider.themeMode == ThemeMode.light
                                          ? AppColors.primaryColor
                                          : AppColorsDark.background,
                                  icon: event[index + 1]["icon"],
                                  title: context.locale == Locale("en")
                                      ? event[index + 1]["name"]
                                      : event[index + 1]["name_ar"],
                                  i: i == index ? true : false,
                                ),
                              ),
                            ))),
              ),
              Text(
                "event_title".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.primaryColor),
              ),
              CustomTextForm(
                  minLines: 1,
                  title: "event_title".tr(),
                  c: title,
                  icon: Icons.input_rounded),
              Text(
                "event_description".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.primaryColor),
              ),
              CustomTextForm(
                  minLines: 5,
                  title: "event_description".tr(),
                  c: description,
                  icon: null),
              CustomAddTime(
                color: provider.themeMode == ThemeMode.light
                    ? AppColors.dark
                    : AppColors.white,
                icon: Icons.calendar_month_sharp,
                title: "event_date".tr(),
                subtitle: provider.selectedDate.toString().substring(0, 10),
                ontap: () async {
                  var selectedDate = await showDatePicker(
                      initialDate: DateTime.now(),
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)));

                  if (selectedDate != null) {
                    provider.changeDate(selectedDate);
                  }
                },
              ),
              CustomAddTime(
                color: provider.themeMode == ThemeMode.light
                    ? AppColors.dark
                    : AppColors.white,
                icon: Icons.timer,
                title: "event_time".tr(),
                subtitle: provider.selectedTimer.format(context),
                ontap: () async {
                  var timer = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());

                  if (timer != null) {
                    provider.changeTimer(timer);
                  }
                },
              ),
              CustomButton(
                  color: AppColors.primaryColor,
                  ontap: () {
                    FirebaseManager.addEvent(EventModel(
                      image: i + 1,
                      id: provider.userId.toString(),
                      title: title.text,
                      description: description.text,
                      date: provider.selectedDate.microsecondsSinceEpoch,
                      timer: provider.selectedTimer.format(context),
                      category: context.locale == Locale("en")
                          ? event[i + 1]['name']
                          : event[i + 1]['name_ar'],
                      location: "",
                    ));
                    Navigator.pop(context);
                  },
                  widget: Text(
                    "event_add".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors.background, fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
