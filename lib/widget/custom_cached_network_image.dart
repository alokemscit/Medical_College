 
import 'package:agmc/config/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//import 'package:http/http.dart' as http;

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.img,
    this.width = 40,
    this.height = 40,
    this.radious = 150,
  });

  final String img;
  final double width;
  final double height;
  final double radious;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: width,
      height: height,
      imageUrl: img,
      placeholder: (context, url) => CircleAvatar(
        backgroundColor: Colors.blue,
        radius: radious,
      ),
      imageBuilder: (context, image) => CircleAvatar(
        backgroundImage: image,
        radius: radious,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.person_off_sharp),
    );
  }
}

class CustomCachedNetworkImageSquareShape extends StatelessWidget {
  const CustomCachedNetworkImageSquareShape({
    super.key,
    required this.img,
    this.width = 40,
    this.height = 40,
    this.radious = 8,
    this.errorIconSize=28,
  });

  final String img;
  final double width;
  final double height;
  final double radious;
  final double errorIconSize ;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusDirectional.circular(radious),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.cover,
        imageUrl: img,
        placeholder: (context, url) => Container(
          //color: Colors.blue,
          height: height,
          width: width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(radious)),
        ),
        errorWidget: (context, url, error) =>  Icon(
          Icons.person_off_sharp,
          size: errorIconSize,
          color: appColorGray200,
        ),
      ),
    );
  }
}
