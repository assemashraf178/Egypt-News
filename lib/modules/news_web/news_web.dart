import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebScreen extends StatefulWidget {
  final String url;
  final String name;
  NewsWebScreen({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  State<NewsWebScreen> createState() => _NewsWebScreenState();
}

class _NewsWebScreenState extends State<NewsWebScreen> {
  int inProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
        ),
      ),
      body: Column(
        children: [
          if (inProgress != 100) const LinearProgressIndicator(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 50.0,
          ),
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              onProgress: (int progress) {
                setState(() {
                  inProgress = progress;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
