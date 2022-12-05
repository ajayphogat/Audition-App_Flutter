// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:equatable/equatable.dart';

// class ChatUser extends Equatable {
//   final String id;
//   final String photoUrl;
//   final String displayName;
//   final String phoneNumber;
//   final String aboutMe;

//   const ChatUser({
//     required this.id,
//     required this.photoUrl,
//     required this.displayName,
//     required this.phoneNumber,
//     required this.aboutMe,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'photoUrl': photoUrl,
//       'displayName': displayName,
//       'phoneNumber': phoneNumber,
//       'aboutMe': aboutMe,
//     };
//   }

//   factory ChatUser.fromMap(Map<String, dynamic> map) {
//     return ChatUser(
//       id: map['id'] as String,
//       photoUrl: map['photoUrl'] as String,
//       displayName: map['displayName'] as String,
//       phoneNumber: map['phoneNumber'] as String,
//       aboutMe: map['aboutMe'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ChatUser.fromJson(String source) => ChatUser.fromMap(json.decode(source) as Map<String, dynamic>);
// }
