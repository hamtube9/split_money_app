import 'package:flutter/material.dart';
import 'package:split_money/extension/context.dart';

class TextFormFieldCommon extends StatefulWidget {
  TextEditingController controller;
  Function(String)? onChange;
  String? Function(String?)? validator;
  String? label;
  String? hint;
  bool? isObscureText;

  TextFormFieldCommon({super.key,required this.controller , this.hint, this.label, this.onChange, this.isObscureText, this.validator});

  @override
  State<TextFormFieldCommon> createState() => _TextFormFieldCommonState();
}

class _TextFormFieldCommonState extends State<TextFormFieldCommon> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isObscureText ?? false,
      onChanged: widget.onChange,
      validator: (value) {
        if (widget.validator != null) {
          // Use the custom validator if it exists
          return widget.validator!(value);
        }

        return null;
      },
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