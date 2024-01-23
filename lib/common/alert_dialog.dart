import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:flutter/material.dart';

class ShowAlert {
  Future<void> deleteAccount({
    required BuildContext context,
    required double height,
    required String platform,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Are you sure you want to delete you account?",
          style: TextStyle(
            fontSize: height,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: const Text(
          "After deleting you account you will not be able to access it again and all your data will be lost.",
        ),
        actions: [
          TextButton(
            onPressed: () async {
              circularProgressIndicatorNew(context);
              if (platform == 'audition') {
                await AuthService().deleteUser(context);
              } else {
                await AuthService().deleteUserStudio(context);
              }
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "No",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
