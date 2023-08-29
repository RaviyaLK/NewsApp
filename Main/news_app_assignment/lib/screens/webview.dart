import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/colors.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key, required this.webURL}) : super(key: key);
  
  final String webURL;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;
  late WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(appBackground)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          if (progress == 100 && mounted) {
            setState(() {
              isLoading = false;
            });
          }
          
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    )..loadRequest(Uri.parse(widget.webURL));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarBackground,
        title: const Text(''),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
