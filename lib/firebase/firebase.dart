import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/data/model/event_model.dart';
import 'package:evently/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseManager {
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (model, options) {
        return model.toJson();
      },
    );
  }

  static CollectionReference<EventModel> getUserFavCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favorite")
        .withConverter<EventModel>(
      fromFirestore: (snapshot, options) {
        return EventModel.fromMap(snapshot.data()!);
      },
      toFirestore: (model, options) {
        return model.toJson();
      },
    );
  }
///////////////////////////// add user //////////////////////////////////////

  static Future<void> addUser(UserModel userModel) async {
    try {
      CollectionReference<Object?> collection = getUserCollection();
      var userRuf = collection.doc(userModel.id);

      return userRuf.set(userModel);
    } catch (e) {
      print("---------------------Error adding user: $e");
      throw e;
    }
  }

  static Future<UserModel?> readUser() async {
    var collection = getUserCollection();
    DocumentSnapshot<UserModel> docRef =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docRef.data();
  }

  static Future<UserCredential?> signInWithGoogle(
    Function onSecces,
  ) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      if (googleUser == null) {
        print("إلغاء تسجيل الدخول");
        return null;
      }
      var res = await FirebaseAuth.instance.signInWithCredential(credential);
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.setString("user", res.user!.uid);
      UserModel userModel = UserModel(
          id: res.user!.uid,
          name: res.user!.displayName ?? "Sir",
          email: res.user!.email ?? "",
          createdAt: DateTime.now().microsecondsSinceEpoch);

      addUser(userModel);
      onSecces();
      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> createUserWithEmailAndPassword(
    String email,
    String pass,
    String name,
    Function onSecces,
    Function onloading,
    Function onError,
  ) async {
    try {
      onloading();
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);

      credential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: email,
          createdAt: DateTime.now().microsecondsSinceEpoch);

      addUser(userModel);
      onSecces();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      onError("something is error $e");
    }
  }

  static Future<void> signinEmailPass(
    String email,
    String pass,
    Function onSecces,
    Function onloading,
    Function onError,
    Function onVerify,
  ) async {
    try {
      onloading();
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.setString("user", credential.user!.uid);

      onSecces();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError(e.message);
      } else if (e.code == 'wrong-password') {
        onError(e.message);
      } else if (e.code == "invalid-credential") {
        onError(e.message);
      }
    } catch (e) {
      onError("something is wrong $e");
    }
  }

  static Future<void> logout() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.remove("user");
    return FirebaseAuth.instance.signOut();
  }

////////////////////////////////////////
//////////////////////////////////////////// events ////////////////////

  static CollectionReference<EventModel> getEventCollection() {
    return FirebaseFirestore.instance
        .collection("events")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, options) =>
              EventModel.fromMap(snapshot.data()!),
          toFirestore: (model, options) => model.toJson(),
        );
  }

  static addEvent(EventModel eventModel) {
    try {
      CollectionReference<Object?> collectionReference = getEventCollection();
      var eventRuf = collectionReference.doc();
      eventRuf.set(eventModel);
    } catch (e) {
      print(e);
    }
  }

  static Stream<QuerySnapshot<EventModel>> getEvents(String selectedCategory) {
    try {
      var collectionReference = getEventCollection();
      if (selectedCategory == "All") {
        return collectionReference
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy("date", descending: false)
            .snapshots();
      } else {
        return collectionReference
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("category", isEqualTo: selectedCategory)
            .orderBy("date", descending: false)
            .snapshots();
      }
    } catch (e) {
      print("ERROR HERE ==== $e");
      return Stream.error(e);
    }
  }

/////////////////////////////////////////////////////////////
  ///

  static addFavEvent(EventModel eventModel) {
    try {
      CollectionReference<Object?> collectionReference = getUserFavCollection();
      var eventRuf = collectionReference.doc();

      eventRuf.set(eventModel);
    } catch (e) {
      print(e);
    }
  }

  static Stream<QuerySnapshot<EventModel>> getFavEvents() {
    try {
      var collectionReference = getUserFavCollection();

      return collectionReference.orderBy("date", descending: false).snapshots();
    } catch (e) {
      print("ERROR HERE ==== $e");
      return Stream.error(e);
    }
  }

  /////////////////////////////////////////////////////
  ///
  ///
  static Stream<QuerySnapshot<EventModel>> getSearchEvents(String query) {
    try {
      var collectionReference = getUserFavCollection();
      return collectionReference
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThan: query + '\uf8ff') // للبحث الديناميكي
          .snapshots();
    } catch (e) {
      print("ERROR HERE ==== $e");
      return Stream.error(e);
    }
  }
}
//////////////////////////////////////////////
///
///
