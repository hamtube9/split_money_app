import 'package:flutter/material.dart';
import 'package:split_money/extension/context.dart';
import 'package:split_money/route/app_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if(mounted){
      context.pushReplace(AppPaths.splash);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Welcome ",style: context.headerTextBlack(),),),
    );
  }
}
