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
