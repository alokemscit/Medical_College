 
import 'package:agmc/core/config/colors.dart';
import 'package:agmc/core/config/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
 

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor:kBgLightColor,
      appBar: AppBar(
        backgroundColor:kBgLightColor,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: GestureDetector(
                onTap: () async{
                 await savePdf(context,url);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.share,color:Colors.blueAccent,))),
          )
        ],
      ),
      body: Container()
      // const PDF().fromUrl(
      //   url,
      //   placeholder: (double progress) => Center(child: Text('$progress %')),
      //   errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      // ),
    );
  }
}
