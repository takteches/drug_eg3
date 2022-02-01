import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  String url;

  WebPage(this.url);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text(
          "more information",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Courgette",
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}