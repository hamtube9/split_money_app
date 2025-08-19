import 'package:flutter/material.dart';
import 'package:split_money/extension/context.dart';

class TextFieldCommon extends StatefulWidget {
  TextEditingController controller;
  Function(String)? onChange;
  String? label;
  String? hint;
  bool? isObscureText;

  TextFieldCommon({super.key,required this.controller , this.hint, this.label, this.onChange, this.isObscureText});

  @override
  State<TextFieldCommon> createState() => _TextFieldCommonState();
}

class _TextFieldCommonState extends State<TextFieldCommon> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isObscureText ?? false,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        hintStyle: context.normalTextBlack(),
        labelStyle: context.normalTextBlack(),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
          suffixIcon: widget.isObscureText != null ? IconButton(
            icon: Icon(
              widget.isObscureText!
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                widget.isObscureText = !widget.isObscureText!;
              });
            },
          ) : null
      ),
    );
  }
}
