import 'dart:convert';

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
  final Map<String, dynamic> studio;
  final List<dynamic> applicants;
  final List<dynamic> shortlisted;
  final List<dynamic> accepted;
  final List<dynamic> declined;
  final List<dynamic> bookmark;
  bool? isFollowed;
  bool? isBookmarked;
  bool? isApplied;
  bool? isAccepted;
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
    required this.shortlisted,
    required this.accepted,
    required this.declined,
    required this.bookmark,
    this.isFollowed,
    this.isBookmarked,
    this.isApplied,
    this.isAccepted,
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
      'shortlisted': shortlisted,
      'accepted': accepted,
      'declined': declined,
      'bookmark': bookmark,
      'isFollowed': isFollowed,
      'isBookmarked': isBookmarked,
      'isApplied': isApplied,
      'isAccepted': isAccepted,
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
      studio: Map<String, dynamic>.from(map['studio'] as Map<String, dynamic>),
      applicants: List<dynamic>.from(map['applicants'] as List<dynamic>),
      shortlisted: List<dynamic>.from(map['shortlisted'] as List<dynamic>),
      accepted: List<dynamic>.from(map['accepted'] as List<dynamic>),
      declined: List<dynamic>.from(map['declined'] as List<dynamic>),
      bookmark: List<dynamic>.from(map['bookmark'] as List<dynamic>),
      isFollowed: map['isFollowed'] != null ? map['isFollowed'] as bool : null,
      isBookmarked:
          map['isBookmarked'] != null ? map['isBookmarked'] as bool : null,
      isApplied: map['isApplied'] != null ? map['isApplied'] as bool : null,
      isAccepted: map['isAccepted'] != null ? map['isAccepted'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) =>
      JobModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class JobModel1 {
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
  final List<dynamic> shortlisted;
  final List<dynamic> accepted;
  final List<dynamic> declined;
  final List<dynamic> bookmark;
  bool? isFollowed;
  bool? isBookmarked;
  bool? isApplied;
  bool? isAccepted;
  bool? isShortlisted;
  bool? isDeclined;
  JobModel1({
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
    required this.shortlisted,
    required this.accepted,
    required this.declined,
    required this.bookmark,
    this.isFollowed,
    this.isBookmarked,
    this.isApplied,
    this.isAccepted,
    this.isShortlisted,
    this.isDeclined,
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
      'shortlisted': shortlisted,
      'accepted': accepted,
      'declined': declined,
      'bookmark': bookmark,
      'isFollowed': isFollowed,
      'isBookmarked': isBookmarked,
      'isApplied': isApplied,
      'isAccepted': isAccepted,
      'isShortlisted': isShortlisted,
      'isDeclined': isDeclined,
    };
  }

  factory JobModel1.fromMap(Map<String, dynamic> map) {
    return JobModel1(
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
      shortlisted: List<dynamic>.from(map['shortlisted'] as List<dynamic>),
      accepted: List<dynamic>.from(map['accepted'] as List<dynamic>),
      declined: List<dynamic>.from(map['declined'] as List<dynamic>),
      bookmark: List<dynamic>.from(map['bookmark'] as List<dynamic>),
      isFollowed: map['isFollowed'] != null ? map['isFollowed'] as bool : null,
      isBookmarked:
          map['isBookmarked'] != null ? map['isBookmarked'] as bool : null,
      isApplied: map['isApplied'] != null ? map['isApplied'] as bool : null,
      isAccepted: map['isAccepted'] != null ? map['isAccepted'] as bool : null,
      isShortlisted:
          map['isShortlisted'] != null ? map['isShortlisted'] as bool : null,
      isDeclined: map['isDeclined'] != null ? map['isDeclined'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel1.fromJson(String source) =>
      JobModel1.fromMap(json.decode(source) as Map<String, dynamic>);
}
