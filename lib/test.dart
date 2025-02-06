import 'package:evently/firebase/firebase.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
          onTap: () {
            FirebaseManager.logout();
          },
          child: Center(
            child: Text("jjjjj"),
          )),
    );
  }
}
