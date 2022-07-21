import 'package:flutter/material.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  static const String routeName = "/inbox-page";

  @override
  State<InboxPage> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Inbox Page"),
      ),
    );
  }
}
