import 'dart:async';

import 'package:smart_news/controllers/SmartNewsController.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebNews extends StatefulWidget {
  final String newsUrl;
  WebNews({Key? key, required this.newsUrl}) : super(key: key);

  @override
  State<WebNews> createState() => _WebNewsState();
}

class _WebNewsState extends State<WebNews> {
  SmartNewsController newsController = SmartNewsController();

  final Completer<WebViewController> controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
          initialUrl: widget.newsUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              controller.complete(webViewController);
            });
          },
        ));
  }
}
