import 'package:flutter/material.dart';

class AssetsImage extends StatelessWidget {
  final String name;
  double? height;
  double? width;
  double? scale;

  AssetsImage({
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
