import 'package:flutter/material.dart';
import 'package:split_money/commons/assets_image.dart';
import 'package:split_money/commons/red_button.dart';
import 'package:split_money/extension/context.dart';

class VerifyDialog extends StatelessWidget {
  final String name;
  final String email;
  const VerifyDialog({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 480,
        maxWidth: 320
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          // Congratulation title
          Text(
            'Congratulation\nWelcome $name',
            textAlign: TextAlign.center,
            style: context.headerTextBlack().copyWith(
                color: context.darkBluePrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // Subtitle text
            Text(
            "Please verify account by your email : $email\n to start using the app",
            textAlign: TextAlign.center,
            style: context.normalTextBlack().copyWith(color: Color(0xFF6F7B8C))
          ),

          const SizedBox(height: 40),

          // Illustration placeholder
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFD6E3FF),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFB1D1FF),
                width: 5,
              ),
            ),
            child: Center(
              child: AssetsImageCommon(name: 'ic_registered'),
            ),
          ),

          const SizedBox(height: 40), // Pushes the button to the bottom

          // Start button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: RedButtonCommon(onPress: (){
              context.pop();
            },text: 'START',),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
