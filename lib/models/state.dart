import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:simple_flutter_auth_app/models/settings.dart';
import 'package:simple_flutter_auth_app/models/user.dart';
import 'package:simple_flutter_auth_app/services/database.dart';
import 'package:simple_flutter_auth_app/services/store-local.dart';

class StateModel extends ChangeNotifier {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;
  //Settings settings;

  StateModel({
    this.isLoading = true,
    this.firebaseUserAuth,
    this.user,
    //this.settings,
  }) {
    print("Hello");
    initState();
    setIsLoading(false); // this.isLoading = true, at the beginning
  }

  void setIsLoading(bool isLoadingInput) {
    isLoading = isLoadingInput;
    notifyListeners();
  }

  void updateStateModel(FirebaseUser firebaseUserAuthInput, User userInput) {
    this.firebaseUserAuth = firebaseUserAuthInput;
    this.user = userInput;
    notifyListeners();
  }

  // init
  Future initState() async {
    FirebaseUser firebaseUserAuth = await FirebaseAuth.instance.currentUser();
    User user = await StoreLocal().getUserLocal();
    this.updateStateModel(firebaseUserAuth, user);
  }

  Future signInAnonymous() async {
    FirebaseUser firebaseUser =
        (await FirebaseAuth.instance.signInAnonymously()).user;
    User user = User(uid: firebaseUser.uid, isAnonymous: true);
    await StoreLocal().storeUserLocal(user);
    await DatabaseService(uid: firebaseUser.uid).updateUserDataAnonymous();
    this.updateStateModel(firebaseUser, user);
  }

  // sign out
  Future signOut() async {
    await StoreLocal().deleteUserLocal();
    await FirebaseAuth.instance.signOut();
    this.updateStateModel(null, null);
  }

  String toString() {
    String res = "";
    if (this.firebaseUserAuth != null) {
      res += "firebaseAuth.uid = " + this.firebaseUserAuth.uid;
    } else {
      res += "firebaseAuth is null.";
    }
    res += "\n";
    if (this.user != null) {
      res += "User.uid = " + this.user.uid;
    } else {
      res += "User null";
    }
    return res;
  }
}
