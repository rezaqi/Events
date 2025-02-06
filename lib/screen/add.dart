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
        leading: Icon(
          Icons.arrow_back,
          color: AppColors.primaryColor,
        ),
        title: Text(
          "Create Event",
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
                                  borderColor: AppColors.primaryColor,
                                  textColor: i == index
                                      ? AppColors.primaryColor
                                      : AppColors.background,
                                  backgroundColor: i == index
                                      ? AppColors.background
                                      : AppColors.primaryColor,
                                  icon: event[index + 1]["icon"],
                                  title: event[index + 1]["name"],
                                  i: i == index ? true : false,
                                ),
                              ),
                            ))),
              ),
              Text(
                "Title",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.primaryColor),
              ),
              CustomTextForm(
                  minLines: 1,
                  title: "title",
                  c: title,
                  icon: Icons.input_rounded),
              Text(
                "Description",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.primaryColor),
              ),
              CustomTextForm(
                  minLines: 5,
                  title: "Description",
                  c: description,
                  icon: null),
              CustomAddTime(
                icon: Icons.calendar_month_sharp,
                title: "Event Date",
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
                icon: Icons.timer,
                title: "Event Time",
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
                      category: event[i + 1]['name'],
                      location: "",
                    ));
                    Navigator.pop(context);
                  },
                  widget: Text(
                    "Add",
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
