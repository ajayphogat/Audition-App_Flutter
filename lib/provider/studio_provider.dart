import 'package:first_app/model/studio_user_model.dart';
import 'package:flutter/widgets.dart';

class StudioProvider extends ChangeNotifier {
  var _user = StudioModel(
    id: "",
    fname: "",
    email: "",
    number: "",
    password: "",
    token: "",
    location: "",
    profilePic: "",
    views: 0,
    projectDesc: "",
    aboutDesc: "",
    followers: [],
    post: [],
  );

  StudioModel get user => _user;

  void setUser(String user) {
    _user = StudioModel.fromJson(user);

    notifyListeners();
  }
}

class StudioProvider1 extends ChangeNotifier {
  var _user = StudioModel1(
    id: "",
    fname: "",
    email: "",
    number: "",
    password: "",
    token: "",
    location: "",
    profilePic: "",
    views: 0,
    projectDesc: "",
    aboutDesc: "",
    followers: [],
    post: [],
    totalApplicants: "",
    totalAccepted: "",
    totalBookmark: "",
    totalShortlisted: "",
    totalDeclined: "",
  );

  StudioModel1 get user => _user;

  void setUser(String user) {
    _user = StudioModel1.fromJson(user);

    notifyListeners();
  }
}
