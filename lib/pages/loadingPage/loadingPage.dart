import 'package:first_app/auth/other_services.dart';
import 'package:first_app/constants.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  static const String routeName = "/loading-page";
  final String? jobId;
  const LoadingPage({super.key, this.jobId});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  OtherService otherService = OtherService();
  @override
  void initState() {
    super.initState();
    otherService.getJobDetails(context: context, jobId: widget.jobId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: greenColor),
      ),
    );
  }
}
