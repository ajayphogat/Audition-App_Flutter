import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/model/studio_user_model.dart';
import 'package:flutter/widgets.dart';

class JobProvider extends ChangeNotifier {
  var _job = JobModel(
    id: "",
    studioName: "",
    jobType: "",
    socialMedia: "",
    description: "",
    productionDetail: "",
    date: "",
    location: "",
    contactNumber: 0,
    keyDetails: "",
    images: [],
    bookmark: [],
    studio: <String, dynamic>{},
    applicants: [],
    accepted: [],
    declined: [],
    shortlisted: [],
  );

  JobModel get job => _job;

  void setUser(String job) {
    _job = JobModel.fromJson(job);

    notifyListeners();
  }
}

class JobProvider1 extends ChangeNotifier {
  var _job = JobModel1(
    id: "",
    studioName: "",
    jobType: "",
    socialMedia: "",
    description: "",
    productionDetail: "",
    date: "",
    location: "",
    contactNumber: 0,
    keyDetails: "",
    images: [],
    bookmark: [],
    studio: "",
    applicants: [],
    accepted: [],
    declined: [],
    shortlisted: [],
    isAccepted: false,
    isShortlisted: false,
    isDeclined: false,
  );

  JobModel1 get job => _job;

  void setUser(String job) {
    _job = JobModel1.fromJson(job);

    notifyListeners();
  }
}
