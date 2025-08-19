import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetsImageCommon extends StatelessWidget {
  final String name;
  double? height;
  double? width;
  double? scale;

  AssetsImageCommon({
    super.key,
    required this.name,
    this.height,
    this.width,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/$name.png", height: height, width: width);
  }
}

class SvgImageCommon extends StatelessWidget {
  final String name;
  double? height;
  double? width;

  SvgImageCommon({
    super.key,
    required this.name,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/svg/$name.svg",
      width: width,
      height: height,
    );
  }
}
