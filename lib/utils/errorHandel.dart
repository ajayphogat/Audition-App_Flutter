import 'dart:convert';

import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/utils/showSnackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void httpErrorHandel({
  required BuildContext context,
  required http.Response res,
  required VoidCallback onSuccess,
}) async {
  if (res.statusCode == 200) {
    onSuccess();
  } else if (res.statusCode == 400 || res.statusCode == 401) {
    showSnackBar(context, jsonDecode(res.body)['msg']);
    Navigator.pop(context);
  } else if (res.statusCode == 500 || res.statusCode == 501) {
    showSnackBar(context, jsonDecode(res.body)['error']);
    Navigator.pop(context);
  } else {
    showSnackBar(context, jsonDecode(res.body));
    Navigator.pop(context);
  }
}

void httpErrorHandelForLoginSignup({
  required BuildContext context,
  required http.Response res,
  required VoidCallback onSuccess,
}) async {
  if (res.statusCode == 200) {
    onSuccess();
  } else if (res.statusCode == 400 || res.statusCode == 401) {
    showSnackBar(context, jsonDecode(res.body)['msg']);
  } else if (res.statusCode == 500 || res.statusCode == 501) {
    showSnackBar(context, jsonDecode(res.body)['error']);
  } else {
    showSnackBar(context, jsonDecode(res.body));
  }
}
