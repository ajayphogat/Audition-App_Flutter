import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StudioModel {
  final String id;
  final String fname;
  final String email;
  final String number;
  final String password;
  final String token;
  StudioModel({
    required this.id,
    required this.fname,
    required this.email,
    required this.number,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fname': fname,
      'email': email,
      'number': number,
      'password': password,
      'token': token,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory StudioModel.fromJson(String source) =>
      StudioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
