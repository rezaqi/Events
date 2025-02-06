import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/data/model/event_model.dart';
import 'package:evently/firebase/firebase.dart';
import 'package:evently/widget/customs/text_form.dart';
import 'package:evently/widget/home/event.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late TextEditingController _textEditingController;
  String searchQuery = "";
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      setState(() {
        searchQuery = _textEditingController.text;
        print(searchQuery);
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              CustomTextForm(
                  title: "Search for Event",
                  c: _textEditingController,
                  icon: Icons.search),
              StreamBuilder<QuerySnapshot<EventModel>>(
                stream: searchQuery.isEmpty
                    ? FirebaseManager.getFavEvents()
                    : FirebaseManager.getSearchEvents(
                        _textEditingController.text),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<EventModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(child: Text("حدث خطأ ما"));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("لا توجد أحداث متاحة"));
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => CustomEvent(
                        eventModel: snapshot.data!.docs[index].data(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
