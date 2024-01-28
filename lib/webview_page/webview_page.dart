import 'package:first_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  static const String routeName = '/web-view-page';
  final String pageName;
  final String url;
  const WebViewPage({super.key, required this.pageName, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageName,
        ),
        centerTitle: true,
        backgroundColor: secondoryColor,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
