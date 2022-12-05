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
  final int views;
  final String projectDesc;
  final String aboutDesc;
  final List<dynamic> followers;
  final List<dynamic> post;
  StudioModel({
    required this.id,
    required this.fname,
    required this.email,
    required this.number,
    required this.password,
    required this.token,
    required this.location,
    required this.views,
    required this.projectDesc,
    required this.aboutDesc,
    required this.followers,
    required this.post,
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
      'views': views,
      'projectDesc': projectDesc,
      'aboutDesc': aboutDesc,
      'followers': followers,
      'post': post,
    };
  }

  factory StudioModel.fromMap(Map<String, dynamic> map) {
    return StudioModel(
      id: map['_id'] as String,
      fname: map['fname'] as String,
      email: map['email'] as String,
      number: map['number'] as String,
      password: map['password'] as String,
      token: map['token'] == null ? map['token'] = "" : map['token'] as String,
      location: map['location'] as String,
      views: map['views'] as int,
      projectDesc: map['projectDesc'] as String,
      aboutDesc: map['aboutDesc'] as String,
      followers: List<String>.from(map['followers'] as List<dynamic>),
      post: List<dynamic>.from(map['post'] as List<dynamic>),
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
