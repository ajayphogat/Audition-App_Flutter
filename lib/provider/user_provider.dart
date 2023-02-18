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
    profilePic: "",
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
    photos: [],
    videos: [],
    audios: [],
    documents: [],
    applied: [],
    shortlisted: [],
    accepted: [],
    declined: [],
    following: [],
    thumbnailVideo: [],
  );

  UserModel get user => _user;

  void setUser(String user) {
    _user = UserModel.fromJson(user);

    notifyListeners();
  }
}

class UserProvider1 extends ChangeNotifier {
  var _user = UserModel1(
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
    profilePic: "",
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
    photos: [],
    videos: [],
    audios: [],
    documents: [],
    applied: [],
    shortlisted: [],
    accepted: [],
    declined: [],
    following: [],
    thumbnailVideo: [],
  );

  UserModel1 get user => _user;

  void setUser(String user) {
    _user = UserModel1.fromJson(user);

    notifyListeners();
  }
}
