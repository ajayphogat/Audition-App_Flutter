import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StudioModel {
  final String id;
  final String fname;
  final String email;
  final String number;
  final String password;
  final String token;
  final String location;
  final String profilePic;
  final int views;
  final String projectDesc;
  final String aboutDesc;
  final List<dynamic> followers;
  final List<dynamic> post;
  String? totalApplicants;
  String? totalShortlisted;
  String? totalAccepted;
  String? totalDeclined;
  String? totalBookmark;
  int? janJob;
  int? febJob;
  int? marJob;
  int? aprJob;
  int? mayJob;
  int? junJob;
  int? julJob;
  int? augJob;
  int? sepJob;
  int? octJob;
  int? novJob;
  int? decJob;
  int? janApplicants;
  int? febApplicants;
  int? marApplicants;
  int? aprApplicants;
  int? mayApplicants;
  int? junApplicants;
  int? julApplicants;
  int? augApplicants;
  int? sepApplicants;
  int? octApplicants;
  int? novApplicants;
  int? decApplicants;
  StudioModel({
    required this.id,
    required this.fname,
    required this.email,
    required this.number,
    required this.password,
    required this.token,
    required this.location,
    required this.profilePic,
    required this.views,
    required this.projectDesc,
    required this.aboutDesc,
    required this.followers,
    required this.post,
    this.totalApplicants,
    this.totalShortlisted,
    this.totalAccepted,
    this.totalDeclined,
    this.totalBookmark,
    this.janJob,
    this.febJob,
    this.marJob,
    this.aprJob,
    this.mayJob,
    this.junJob,
    this.julJob,
    this.augJob,
    this.sepJob,
    this.octJob,
    this.novJob,
    this.decJob,
    this.janApplicants,
    this.febApplicants,
    this.marApplicants,
    this.aprApplicants,
    this.mayApplicants,
    this.junApplicants,
    this.julApplicants,
    this.augApplicants,
    this.sepApplicants,
    this.octApplicants,
    this.novApplicants,
    this.decApplicants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fname': fname,
      'email': email,
      'number': number,
      'password': password,
      'token': token,
      'location': location,
      'profilePic': profilePic,
      'views': views,
      'projectDesc': projectDesc,
      'aboutDesc': aboutDesc,
      'followers': followers,
      'post': post,
      'totalApplicants': totalApplicants,
      'totalShortlisted': totalShortlisted,
      'totalAccepted': totalAccepted,
      'totalDeclined': totalDeclined,
      'totalBookmark': totalBookmark,
      'janJob': janJob,
      'febJob': febJob,
      'marJob': marJob,
      'aprJob': aprJob,
      'mayJob': mayJob,
      'junJob': junJob,
      'julJob': julJob,
      'augJob': augJob,
      'sepJob': sepJob,
      'octJob': octJob,
      'novJob': novJob,
      'decJob': decJob,
      'janApplicants': janApplicants,
      'febApplicants': febApplicants,
      'marApplicants': marApplicants,
      'aprApplicants': aprApplicants,
      'mayApplicants': mayApplicants,
      'junApplicants': junApplicants,
      'julApplicants': julApplicants,
      'augApplicants': augApplicants,
      'sepApplicants': sepApplicants,
      'octApplicants': octApplicants,
      'novApplicants': novApplicants,
      'decApplicants': decApplicants,
    };
  }

  factory StudioModel.fromMap(Map<String, dynamic> map) {
    return StudioModel(
      id: map['_id'] as String,
      fname: map['fname'] as String,
      email: map['email'] as String,
      number: map['number'] as String,
      password: map['password'] as String,
      token: map['token'] as String,
      location: map['location'] as String,
      profilePic: map['profilePic'] as String,
      views: map['views'] as int,
      projectDesc: map['projectDesc'] as String,
      aboutDesc: map['aboutDesc'] as String,
      followers: List<dynamic>.from(map['followers'] as List<dynamic>),
      post: List<dynamic>.from(map['post'] as List<dynamic>),
      totalApplicants: map['totalApplicants'] != null
          ? map['totalApplicants'] as String
          : null,
      totalShortlisted: map['totalShortlisted'] != null
          ? map['totalShortlisted'] as String
          : null,
      totalAccepted:
          map['totalAccepted'] != null ? map['totalAccepted'] as String : null,
      totalDeclined:
          map['totalDeclined'] != null ? map['totalDeclined'] as String : null,
      totalBookmark:
          map['totalBookmark'] != null ? map['totalBookmark'] as String : null,
      janJob: map['janJob'] != null ? map['janJob'] as int : null,
      febJob: map['febJob'] != null ? map['febJob'] as int : null,
      marJob: map['marJob'] != null ? map['marJob'] as int : null,
      aprJob: map['aprJob'] != null ? map['aprJob'] as int : null,
      mayJob: map['mayJob'] != null ? map['mayJob'] as int : null,
      junJob: map['junJob'] != null ? map['junJob'] as int : null,
      julJob: map['julJob'] != null ? map['julJob'] as int : null,
      augJob: map['augJob'] != null ? map['augJob'] as int : null,
      sepJob: map['sepJob'] != null ? map['sepJob'] as int : null,
      octJob: map['octJob'] != null ? map['octJob'] as int : null,
      novJob: map['novJob'] != null ? map['novJob'] as int : null,
      decJob: map['decJob'] != null ? map['decJob'] as int : null,
      janApplicants:
          map['janApplicants'] != null ? map['janApplicants'] as int : null,
      febApplicants:
          map['febApplicants'] != null ? map['febApplicants'] as int : null,
      marApplicants:
          map['marApplicants'] != null ? map['marApplicants'] as int : null,
      aprApplicants:
          map['aprApplicants'] != null ? map['aprApplicants'] as int : null,
      mayApplicants:
          map['mayApplicants'] != null ? map['mayApplicants'] as int : null,
      junApplicants:
          map['junApplicants'] != null ? map['junApplicants'] as int : null,
      julApplicants:
          map['julApplicants'] != null ? map['julApplicants'] as int : null,
      augApplicants:
          map['augApplicants'] != null ? map['augApplicants'] as int : null,
      sepApplicants:
          map['sepApplicants'] != null ? map['sepApplicants'] as int : null,
      octApplicants:
          map['octApplicants'] != null ? map['octApplicants'] as int : null,
      novApplicants:
          map['novApplicants'] != null ? map['novApplicants'] as int : null,
      decApplicants:
          map['decApplicants'] != null ? map['decApplicants'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudioModel.fromJson(String source) =>
      StudioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class StudioModel1 {
  final String id;
  final String fname;
  final String email;
  final String number;
  final String password;
  String? token;
  final String location;
  final String profilePic;
  final int views;
  final String projectDesc;
  final String aboutDesc;
  final List<dynamic> followers;
  final List<dynamic> post;
  String? totalApplicants;
  String? totalShortlisted;
  String? totalAccepted;
  String? totalDeclined;
  String? totalBookmark;
  StudioModel1({
    required this.id,
    required this.fname,
    required this.email,
    required this.number,
    required this.password,
    required this.token,
    required this.location,
    required this.profilePic,
    required this.views,
    required this.projectDesc,
    required this.aboutDesc,
    required this.followers,
    required this.post,
    this.totalApplicants,
    this.totalShortlisted,
    this.totalAccepted,
    this.totalDeclined,
    this.totalBookmark,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fname': fname,
      'email': email,
      'number': number,
      'password': password,
      'token': token,
      'location': location,
      'profilePic': profilePic,
      'views': views,
      'projectDesc': projectDesc,
      'aboutDesc': aboutDesc,
      'followers': followers,
      'post': post,
      'totalApplicants': totalApplicants,
      'totalShortlisted': totalShortlisted,
      'totalAccepted': totalAccepted,
      'totalDeclined': totalDeclined,
      'totalBookmark': totalBookmark,
    };
  }

  factory StudioModel1.fromMap(Map<String, dynamic> map) {
    return StudioModel1(
      id: map['_id'] as String,
      fname: map['fname'] as String,
      email: map['email'] as String,
      number: map['number'] as String,
      password: map['password'] as String,
      token: map['token'] != null ? map['token'] as String : null,
      location: map['location'] as String,
      profilePic: map['profilePic'] as String,
      views: map['views'] as int,
      projectDesc: map['projectDesc'] as String,
      aboutDesc: map['aboutDesc'] as String,
      followers: List<dynamic>.from(map['followers'] as List<dynamic>),
      post: List<dynamic>.from(map['post'] as List<dynamic>),
      totalApplicants: map['totalApplicants'] != null
          ? map['totalApplicants'] as String
          : null,
      totalShortlisted: map['totalShortlisted'] != null
          ? map['totalShortlisted'] as String
          : null,
      totalAccepted:
          map['totalAccepted'] != null ? map['totalAccepted'] as String : null,
      totalDeclined:
          map['totalDeclined'] != null ? map['totalDeclined'] as String : null,
      totalBookmark:
          map['totalBookmark'] != null ? map['totalBookmark'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudioModel1.fromJson(String source) =>
      StudioModel1.fromMap(json.decode(source) as Map<String, dynamic>);
}
