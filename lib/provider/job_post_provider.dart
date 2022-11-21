import 'package:first_app/model/job_post_model.dart';
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
    studio: "",
    applicants: [],
  );

  JobModel get job => _job;

  void setUser(String job) {
    _job = JobModel.fromJson(job);

    notifyListeners();
  }
}
