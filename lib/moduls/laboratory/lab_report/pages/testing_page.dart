// import 'dart:convert';

 

// import 'package:webview_flutter/webview_flutter.dart';

// import '../../../../core/config/const.dart';

// class TestingPage extends StatelessWidget {
//   const TestingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     late final PlatformWebViewControllerCreationParams params;
//     // params = WebKitWebViewControllerCreationParams(
//     //     allowsInlineMediaPlayback: true,
//     //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//     //   );

//     params = const PlatformWebViewControllerCreationParams();

//     final WebViewController controller =
//         WebViewController.fromPlatformCreationParams(params);
//     controller
//       .loadRequest(Uri.dataFromString(
//           '<iframe src="data:application/pdf;base64,$s" />',
//           mimeType: 'application/pdf',
//         //  base64 : true,
//         //  encoding: Encoding.getByName('utf-8')
//           ));

//     return WebViewWidget(controller: controller);
//   }
// }
