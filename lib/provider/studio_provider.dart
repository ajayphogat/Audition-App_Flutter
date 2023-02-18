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
    totalApplicants: "",
    totalAccepted: "",
    totalBookmark: "",
    totalShortlisted: "",
    totalDeclined: "",
    janJob: 0,
    febJob: 0,
    marJob: 0,
    aprJob: 0,
    mayJob: 0,
    junJob: 0,
    julJob: 0,
    augJob: 0,
    sepJob: 0,
    octJob: 0,
    novJob: 0,
    decJob: 0,
    janApplicants: 0,
    febApplicants: 0,
    marApplicants: 0,
    aprApplicants: 0,
    mayApplicants: 0,
    junApplicants: 0,
    julApplicants: 0,
    augApplicants: 0,
    sepApplicants: 0,
    octApplicants: 0,
    novApplicants: 0,
    decApplicants: 0,
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
