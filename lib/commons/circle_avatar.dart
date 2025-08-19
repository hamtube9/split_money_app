import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:split_money/commons/assets_image.dart';

class CircleAvatarCommon extends StatelessWidget {
  final double size;
  final String? base64String;

  const CircleAvatarCommon({super.key, this.base64String, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: base64String == null
          ? _blankAvatar()
          : Image.memory(base64Decode(base64String!), height: size, width: size),
    );
  }

  Widget _blankAvatar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(),
      ),
      height: size,
      width: size,
      child: AssetsImageCommon(name: 'ic_user'),
    );
  }
}
