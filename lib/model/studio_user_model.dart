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
      token: map['token'] as String,
      location: map['location'] as String,
      views: map['views'] as int,
      projectDesc: map['projectDesc'] as String,
      aboutDesc: map['aboutDesc'] as String,
      followers: List<String>.from(map['followers'] as List<dynamic>),
      post: List<String>.from(map['post'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudioModel.fromJson(String source) =>
      StudioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
