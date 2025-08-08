import 'package:flutter/material.dart';
import 'package:split_money/commons/assets_image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            alignment: Alignment.center,
            child: AssetsImage(name: "ic_header_login"))
      ],
    );
  }
}
