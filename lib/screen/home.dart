import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/static/category.dart';
import 'package:evently/data/model/event_model.dart';
import 'package:evently/firebase/firebase.dart';
import 'package:evently/provider/provider.dart';
import 'package:evently/widget/home/app_bar.dart';
import 'package:evently/widget/home/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String id = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          const HomeAppBar(),
          Expanded(
            child: StreamBuilder<QuerySnapshot<EventModel>>(
              stream: FirebaseManager.getEvents(event[changeI.i]["name"]),
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

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => CustomEvent(
                    eventModel: snapshot.data!.docs[index].data(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
