import 'package:flutter/material.dart';
import 'package:split_money/commons/assets_image.dart';

class BackButtonCommon extends StatelessWidget {
  Function? onPress;
  BackButtonCommon({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      icon: SvgImageCommon(name: 'ic_back'),
      onPressed: () {
        if(onPress != null){
          onPress!();
        }else{
          Navigator.pop(context);
        }
      },
    );
  }
}
