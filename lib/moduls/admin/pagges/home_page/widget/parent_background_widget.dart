import 'package:flutter/material.dart';

class ParentPageBackground extends StatelessWidget {
  const ParentPageBackground({
    super.key,  this.backOpacity=0.030,  this.imageOpacity=0.051,  this.assetImagePath="assets/Backgrounds/Spline.png",
  });
  final double backOpacity;
final double imageOpacity;
  final String assetImagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
       
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 58, 56, 56).withOpacity(backOpacity),
        image:  DecorationImage(
            image: const ExactAssetImage("assets/Backgrounds/Spline.png"),
            fit: BoxFit.cover,
            opacity: imageOpacity,
            colorFilter: const ColorFilter.srgbToLinearGamma()),
      ),
    );
  }
}
