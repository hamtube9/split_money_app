import 'package:flutter/material.dart';
import 'package:split_money/extension/context.dart';

class RedButtonCommon extends StatelessWidget {
  Function()? onPress;
  String? text;
  bool isSubmitting;

  RedButtonCommon({super.key, this.onPress, this.text = '', this.isSubmitting = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF7262),
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: isSubmitting
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            )
          : Text(
              '$text',
              style: context.normalTextBoldWhite().copyWith(fontSize: 18),
            ),
    );
  }
}
