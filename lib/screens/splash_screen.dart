import 'package:flutter/material.dart';
import 'package:split_money/cores/dependency_injection.dart';
import 'package:split_money/extension/context.dart';
import 'package:split_money/route/app_path.dart';
import 'package:split_money/utils/shared_preference.dart';

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
    var token = await getIt.get<SharedPreferencesService>().token;
    if (mounted) {
      if (token == null || token.isEmpty) {
        context.pushReplace(AppPaths.login);
      } else {
        context.pushReplace(AppPaths.home, extra: {"refreshToken": true});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Welcome ", style: context.headerTextBlack())),
    );
  }
}
