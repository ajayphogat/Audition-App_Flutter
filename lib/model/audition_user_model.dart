import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String fname;
  final String email;
  final String number;
  final String password;
  final String category;
  final String token;
  final String bio;
  final String pronoun;
  final String gender;
  final String location;
  final String profileUrl;
  // working title is category
  final String visibility;
  final String age;
  final String ethnicity;
  final String height;
  final String weight;
  final String bodyType;
  final String hairColor;
  final String eyeColor;
  final List<String> socialMedia;
  final List<String> unionMembership;
  final List<String> skills;
  final List<String> credits;
  UserModel({
    required this.id,
    required this.fname,
    required this.email,
    required this.number,
    required this.password,
    required this.category,
    required this.token,
    required this.bio,
    required this.pronoun,
    required this.gender,
    required this.location,
    required this.profileUrl,
    required this.visibility,
    required this.age,
    required this.ethnicity,
    required this.height,
    required this.weight,
    required this.bodyType,
    required this.hairColor,
    required this.eyeColor,
    required this.socialMedia,
    required this.unionMembership,
    required this.skills,
    required this.credits,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fname': fname,
      'email': email,
      'number': number,
      'password': password,
      'category': category,
      'token': token,
      'bio': bio,
      'pronoun': pronoun,
      'gender': gender,
      'location': location,
      'profileUrl': profileUrl,
      'visibility': visibility,
      'age': age,
      'ethnicity': ethnicity,
      'height': height,
      'weight': weight,
      'bodyType': bodyType,
      'hairColor': hairColor,
      'eyeColor': eyeColor,
      'socialMedia': socialMedia,
      'unionMembership': unionMembership,
      'skills': skills,
      'credits': credits,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      fname: map['fname'] as String,
      email: map['email'] as String,
      number: map['number'] as String,
      password: map['password'] as String,
      category: map['category'] as String,
      token: map['token'] as String,
      bio: map['bio'] as String,
      pronoun: map['pronoun'] as String,
      gender: map['gender'] as String,
      location: map['location'] as String,
      profileUrl: map['profileUrl'] as String,
      visibility: map['visibility'] as String,
      age: map['age'] as String,
      ethnicity: map['ethnicity'] as String,
      height: map['height'] as String,
      weight: map['weight'] as String,
      bodyType: map['bodyType'] as String,
      hairColor: map['hairColor'] as String,
      eyeColor: map['eyeColor'] as String,
      socialMedia: List<String>.from(map['socialMedia']),
      unionMembership: List<String>.from(map['unionMembership']),
      skills: List<String>.from(map['skills']),
      credits: List<String>.from(map['credits']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
