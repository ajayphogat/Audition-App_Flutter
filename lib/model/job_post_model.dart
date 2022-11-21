import 'dart:convert';

import 'package:first_app/model/audition_user_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class JobModel {
  final String id;
  final String studioName;
  final String jobType;
  final String socialMedia;
  final String description;
  final String productionDetail;
  final String date;
  final String location;
  final int contactNumber;
  final String keyDetails;
  final List<dynamic> images;
  final String studio;
  final List<dynamic> applicants;
  JobModel({
    required this.id,
    required this.studioName,
    required this.jobType,
    required this.socialMedia,
    required this.description,
    required this.productionDetail,
    required this.date,
    required this.location,
    required this.contactNumber,
    required this.keyDetails,
    required this.images,
    required this.studio,
    required this.applicants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'studioName': studioName,
      'jobType': jobType,
      'socialMedia': socialMedia,
      'description': description,
      'productionDetail': productionDetail,
      'date': date,
      'location': location,
      'contactNumber': contactNumber,
      'keyDetails': keyDetails,
      'images': images,
      'studio': studio,
      'applicants': applicants,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['_id'] as String,
      studioName: map['studioName'] as String,
      jobType: map['jobType'] as String,
      socialMedia: map['socialMedia'] as String,
      description: map['description'] as String,
      productionDetail: map['productionDetail'] as String,
      date: map['date'] as String,
      location: map['location'] as String,
      contactNumber: map['contactNumber'] as int,
      keyDetails: map['keyDetails'] as String,
      images: List<dynamic>.from(map['images'] as List<dynamic>),
      studio: map['studio'] as String,
      applicants: List<dynamic>.from(map['applicants'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) =>
      JobModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
