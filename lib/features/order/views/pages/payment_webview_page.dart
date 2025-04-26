import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebviewPage extends StatefulWidget {
  final String paymentUrl;
  const PaymentWebviewPage({super.key, required this.paymentUrl});

  @override
  State<PaymentWebviewPage> createState() => _PaymentWebviewPageState();
}

class _PaymentWebviewPageState extends State<PaymentWebviewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            log("📦 Final loaded URL: $url");
            if (url.contains("success=true")) {
              log("✅ Payment success detected Payment succeeded!");
              Navigator.pop(context, true);
            } else if (url.contains("success=false")) {
              log("❌ Payment failed detected Payment failed!");
              Navigator.pop(context, false);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarDefaultTheme(title: "Payment"),
      body: WebViewWidget(controller: _controller),
    );
  }
}
