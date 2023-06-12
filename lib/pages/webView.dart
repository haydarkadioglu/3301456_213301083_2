import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {

  final String texturl;

  const WebViewScreen({required this.texturl});
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  List<String> history = [];
  int currentIndex = -1;




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex > 0) {
          setState(() {
            currentIndex--;
            controller.loadUrl(history[currentIndex]);
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Web View'),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (currentIndex > 0) {
                  setState(() {
                    currentIndex--;
                    controller.loadUrl(history[currentIndex]);
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                if (currentIndex < history.length - 1) {
                  setState(() {
                    currentIndex++;
                    controller.loadUrl(history[currentIndex]);
                  });
                }
              },
            ),
          ],
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.texturl,
          onWebViewCreated: (controller) {
            this.controller = controller;
            history.add(widget.texturl); // İlk URL'i geçmişe ekleyin
            currentIndex = 0;
          },
          navigationDelegate: (NavigationRequest request) {
            setState(() {
              history.add(request.url);
              currentIndex = history.length - 1;
            });
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
