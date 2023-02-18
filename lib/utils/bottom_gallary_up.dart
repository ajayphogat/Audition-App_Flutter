import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/utils/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class BottomMediaUp {
  final _firebaseStorage = FirebaseStorage.instance;
  File? profilePic;
  File? mediaImages;
  final AuthService authService = AuthService();

  void showPicker(context, String userId, String whichUser) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: SizedBox(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () async {
                        circularProgressIndicatorNew(context);
                        await pickImages(context, userId, whichUser);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () async {
                      circularProgressIndicatorNew(context);
                      await imgFromCamera(context, userId, whichUser);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showPickerMedia(context, String userId, String mediaType) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: SizedBox(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () async {
                        circularProgressIndicatorNew(context);
                        // await uploadImageGallary(userId);
                        await pickMedia(context, userId, mediaType);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () async {
                      circularProgressIndicatorNew(context);
                      await mediaCamera(context, userId);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future pickImages(
      BuildContext context, String userId, String whichUser) async {
    showsnack(e) => showSnackBar(context, e.toString());
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpeg', 'jpg', 'png'],
      );
      if (files != null && files.files.isNotEmpty) {
        profilePic = File(files.files[0].path!);
        final fileName = p.basename(profilePic!.path);
        try {
          //Upload to Firebase
          var snapshot = await _firebaseStorage
              .ref()
              .child('images/$userId/${userId}_${DateTime.now()}_$fileName')
              .putFile(profilePic!)
              .whenComplete(() {});
          var downloadUrl = await snapshot.ref.getDownloadURL();
          print(snapshot.state);
          print(downloadUrl);
          await uploadProfilePic(context, downloadUrl, whichUser);
        } catch (e) {
          showsnack(e);
        }
      } else {
        showsnack("No Image Selected");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future imgFromCamera(
      BuildContext context, String userId, String whichUser) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    showsnack(e) => showSnackBar(context, e.toString());

    if (pickedFile != null) {
      var file = File(pickedFile.path);
      final fileName = p.basename(file.path);

      try {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/$userId/${userId}_${DateTime.now()}_$fileName')
            .putFile(file)
            .whenComplete(() {
          print("completed");
        });
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print(snapshot.state);
        print(downloadUrl);
        await uploadProfilePic(context, downloadUrl, whichUser);
      } catch (e) {
        showsnack(e.toString());
      }
    } else {
      showsnack("No image selected");
    }
  }

  Future<void> uploadProfilePic(context, String url, String user) async {
    await authService.updateProfilePic(
        context: context, profilePicUrl: url, user: user);
  }

  Future pickMedia(
      BuildContext context, String userId, String mediaType) async {
    showsnack(e) => showSnackBar(context, e.toString());
    uploadMMedia(String downloadUrl, String text) =>
        uploadMedia(context, downloadUrl, text);
    String? thumbnailVideo;
    File? thumbnail;

    if (mediaType == "photos") {
      try {
        var files = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['jpeg', 'jpg', 'png'],
        );
        if (files != null && files.files.isNotEmpty) {
          mediaImages = File(files.files[0].path!);
          final fileName = p.basename(mediaImages!.path);
          try {
            //Upload to Firebase
            var snapshot = await _firebaseStorage
                .ref()
                .child(
                    'images/$userId/photos/${userId}_${DateTime.now()}_$fileName')
                .putFile(mediaImages!)
                .whenComplete(() {});
            var downloadUrl = await snapshot.ref.getDownloadURL();
            print(snapshot.state);
            print(downloadUrl);
            await uploadMMedia(downloadUrl, mediaType);
          } catch (e) {
            showsnack(e);
          }
        } else {
          showsnack("No Image Selected");
        }
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    } else if (mediaType == "videos") {
      try {
        var files = await FilePicker.platform.pickFiles(
          type: FileType.video,
          allowMultiple: false,
          // allowedExtensions: ['mp4', 'mov', 'avi', 'mkv'],
        );
        if (files != null && files.files.isNotEmpty) {
          mediaImages = File(files.files[0].path!);
          final fileName = p.basename(mediaImages!.path);
          try {
            thumbnailVideo = await VideoThumbnail.thumbnailFile(
              video: mediaImages!.path,
              imageFormat: ImageFormat.JPEG,
              thumbnailPath: (await getTemporaryDirectory()).path,
            );
            final thumbName = p.basename(thumbnailVideo!);
            thumbnail = File(thumbnailVideo);

            //Upload to Firebase

            var thumbnailSnap = await _firebaseStorage
                .ref()
                .child(
                    'videos/$userId/thumbnail/${userId}_${DateTime.now()}_$thumbName')
                .putFile(thumbnail)
                .whenComplete(() {});

            var snapshot = await _firebaseStorage
                .ref()
                .child(
                    'videos/$userId/video/${userId}_${DateTime.now()}_$fileName')
                .putFile(mediaImages!)
                .whenComplete(() {});
            var thumbnailUrl = await thumbnailSnap.ref.getDownloadURL();
            var downloadUrl = await snapshot.ref.getDownloadURL();
            print(snapshot.state);
            print(downloadUrl);

            await uploadMMedia(downloadUrl, mediaType);
            await uploadMMedia(thumbnailUrl, "thumbnail");
          } catch (e) {
            showsnack(e);
          }
        } else {
          showsnack("No Video Selected");
        }
      } catch (e) {
        showsnack(e.toString());
      }
    } else if (mediaType == "audios") {
      try {
        var files = await FilePicker.platform.pickFiles(
          type: FileType.audio,
          allowMultiple: false,
          // allowedExtensions: ['mp4', 'mov', 'avi', 'mkv'],
        );
        if (files != null && files.files.isNotEmpty) {
          mediaImages = File(files.files[0].path!);
          final fileName = p.basename(mediaImages!.path);
          try {
            //Upload to Firebase

            var snapshot = await _firebaseStorage
                .ref()
                .child(
                    'audios/$userId/audios/${userId}_${DateTime.now()}_$fileName')
                .putFile(mediaImages!)
                .whenComplete(() {});
            var downloadUrl = await snapshot.ref.getDownloadURL();
            print(snapshot.state);
            print(downloadUrl);

            await uploadMMedia(downloadUrl, mediaType);
          } catch (e) {
            showsnack(e);
          }
        } else {
          showsnack("No Audio Selected");
        }
      } catch (e) {
        showsnack(e.toString());
      }
    } else if (mediaType == "documents") {
      try {
        var files = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: [
            'txt',
            'csv',
            'vcf',
            'apk',
            'ttf',
            'otf',
            'psd',
            'svg',
            'pps',
            'ppt',
            'pptx',
            'ods',
            'xls',
            'xlsm',
            'xlsx',
            'doc',
            'docx',
            'odt',
            'pdf',
          ],
        );
        if (files != null && files.files.isNotEmpty) {
          mediaImages = File(files.files[0].path!);
          final fileName = p.basename(mediaImages!.path);
          try {
            //Upload to Firebase

            var snapshot = await _firebaseStorage
                .ref()
                .child(
                    'documents/$userId/documents/${userId}_${DateTime.now()}_$fileName')
                .putFile(mediaImages!)
                .whenComplete(() {});
            var downloadUrl = await snapshot.ref.getDownloadURL();
            print(snapshot.state);
            print(downloadUrl);

            await uploadMMedia(downloadUrl, mediaType);
          } catch (e) {
            showsnack(e);
          }
        } else {
          showsnack("No Document Selected");
        }
      } catch (e) {
        showsnack(e.toString());
      }
    }
  }

  Future mediaCamera(BuildContext context, String userId) async {
    final imagePicker = ImagePicker();
    uploadMMedia(downloadUrl) => uploadMedia(context, downloadUrl, "photos");
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    showsnack(e) => showSnackBar(context, e.toString());

    if (pickedFile != null) {
      var file = File(pickedFile.path);
      final fileName = p.basename(file.path);

      try {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child(
                'images/$userId/photos/${userId}_${DateTime.now()}_$fileName')
            .putFile(file)
            .whenComplete(() {
          print("completed");
        });
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print(snapshot.state);
        print(downloadUrl);
        await uploadMMedia(downloadUrl);
      } catch (e) {
        showsnack(e.toString());
      }
    } else {
      showsnack("No image selected");
    }
  }

  Future<void> uploadMedia(context, String photos, String mediaType) async {
    await authService.uploadMedia(
        context: context, media: photos, mediaType: mediaType);
  }
}
