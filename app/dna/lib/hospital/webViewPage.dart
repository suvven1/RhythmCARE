import 'package:dna/widget/enums/bottomNavItem.dart';
import 'package:dna/widget/sizeBox.dart';
import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../url.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  // 전화걸기 함수
  void _call(String phoneNumber) async {
    if (await canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber))) {
      await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
    } else {
      throw 'Could not launch';
    }
  }

  // 웹뷰
  late final WebViewController _controller;
  final String hospitalUrl = 'http://${URL.ip}/hospitalapp';
  bool isWebLoding = false;

  void webViewinitState () {

  }
  @override
  void initState() {
    super.initState();


    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            webLodingFt();
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
                        Page resource error:
                          code: ${error.errorCode}
                          description: ${error.description}
                          errorType: ${error.errorType}
                          isForMainFrame: ${error.isForMainFrame}
                    ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('allowing navigation to ${request.url}');

            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          // react에서 데이터를 받아온 뒤 실행되는 함수
          print(message.message);
          _call(message.message);
        },
      )
      ..loadRequest(Uri.parse(hospitalUrl));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);

      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    print('success');

    _controller = controller;
  }

  // 웹뷰 로딩중 표시 함수
  void webLodingFt () async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isWebLoding = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(BottomNaviItem.values[1]);
    return Stack(
      children: [
        WebViewWidget(
          controller: _controller,
        ),
        !isWebLoding
            ? Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
              )
            : SizedBox()
      ],
    );
  }
}
