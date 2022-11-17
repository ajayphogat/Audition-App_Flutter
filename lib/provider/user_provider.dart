import 'package:first_app/model/audition_user_model.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  var _user = UserModel(
    id: "",
    fname: "",
    email: "",
    number: "",
    password: "",
    category: "",
    token: "",
    bio: "",
    pronoun: "",
    gender: "",
    location: "",
    profileUrl: "",
    visibility: "",
    age: "",
    ethnicity: "",
    height: "",
    weight: "",
    bodyType: "",
    hairColor: "",
    eyeColor: "",
    socialMedia: [],
    unionMembership: [],
    skills: [],
    credits: [],
  );

  UserModel get user => _user;

  void setUser(String user) {
    _user = UserModel.fromJson(user);

    notifyListeners();
  }
}

// class PerfectLogin extends ChangeNotifier {
//   var _loginDone = "";

//   String get loginDone => _loginDone;

//   void setLoginDone(String value) {
//     _loginDone = value;
//     notifyListeners();
//   }
// }
