import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icorrect_pc/core/app_colors.dart';
import 'package:icorrect_pc/src/data_source/constants.dart';
import 'package:icorrect_pc/src/utils/utils.dart';

// import 'package:webview_cef/webview_cef.dart';
import 'package:webview_windows/webview_windows.dart';

class AIResponseWidget extends StatefulWidget {
  String url;

  AIResponseWidget({required this.url, super.key});

  @override
  State<AIResponseWidget> createState() => _AIResponseWidgetState();
}

class _AIResponseWidgetState extends State<AIResponseWidget> {
  final _controller = WebviewController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      await _controller.initialize();
      await _controller.setBackgroundColor(Colors.transparent);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller.loadUrl(widget.url);
      if (!mounted) return;
      setState(() {});
    } on PlatformException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Error'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Code: ${e.code}'),
                      Text('Message: ${e.message}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Continue'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      });
    }
  }

  Widget compositeView() {
    if (!_controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        children: [
          Expanded(
              child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      Webview(
                        _controller,
                        permissionRequested: _onPermissionRequested,
                      ),
                      StreamBuilder<LoadingState>(
                          stream: _controller.loadingState,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data == LoadingState.loading) {
                              return const LinearProgressIndicator();
                            } else {
                              return const SizedBox();
                            }
                          }),
                    ],
                  ))),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: StreamBuilder<String>(
      //       stream: _controller.title,
      //       builder: (context, snapshot) {
      //         return Text(
      //             snapshot.hasData ? snapshot.data! : 'WebView (Windows) Example');
      //       },
      //     )),
      body: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          decoration: BoxDecoration(
              color: AppColors.opacity,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 2)),
          child: compositeView()),
    );
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// class _AIResponseWidgetState extends State<AIResponseWidget> {
//   final _controller = WebViewController();
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   Future<void> initPlatformState() async {
//     String url = widget.url;
//     await _controller.initialize();
//     await _controller.loadUrl(url);
//     _controller.setWebviewListener(WebviewEventsListener(
//       onTitleChanged: (t) {},
//       onUrlChanged: (url) {},
//     ));
//     // ignore: prefer_collection_literals
//     final Set<JavascriptChannel> jsChannels = [
//       JavascriptChannel(
//           name: 'Print',
//           onMessageReceived: (JavascriptMessage message) {
//             _controller.sendJavaScriptChannelCallBack(
//                 false,
//                 "{'code':'200','message':'print succeed!'}",
//                 message.callbackId,
//                 message.frameId);
//           }),
//     ].toSet();
//     await _controller.setJavaScriptChannels(jsChannels);
//     await _controller.executeJavaScript("function abc(e){console.log(e)}");
//
//     if (!mounted) return;
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration.zero, () {
//       setState(() {});
//     });
//     return Scaffold(
//           body: Container(
//               margin: const EdgeInsets.only(bottom: 50),
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
//               decoration: BoxDecoration(
//                   color: AppColors.opacity,
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(color: Colors.black, width: 2)),
//               child: Column(
//                 children: [
//                   _controller.value
//                       ? Expanded(child: WebView(_controller))
//                       : Text(Utils.instance().multiLanguage(
//                       StringConstants.something_went_wrong_title)),
//                 ],
//               )));
//   }
// }
