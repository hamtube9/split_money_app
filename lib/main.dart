import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:split_money/split_money.dart';
import 'package:split_money/utils/bloc_observer.dart';
import 'package:split_money/utils/my_http.dart';
import 'cores/dio_client.dart';
import 'firebase_options.dart';
import 'cores/dependency_injection.dart' as di;

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configLoading();
  /// Init Bloc Observer
  Bloc.observer = AppBlocObserver();

  HttpOverrides.global = MyHttpOverrides();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await setupFlutterNotifications();

  /// Init dependency injection
  /// Initial  Dio
  await Future.wait([di.init(), DioClient.initService()]);
  runApp(const SplitMoney());
}

void configLoading() {
  EasyLoading.instance
    ..indicatorColor = const Color(0xfff1039A)
    ..indicatorType = EasyLoadingIndicatorType.wanderingCubes
    ..backgroundColor = Colors.transparent
    ..userInteractions = false
    ..loadingStyle = EasyLoadingStyle.light
    ..maskColor = const Color(0xfff1039A).withValues(alpha: 0.5)
    ..dismissOnTap = false
    ..backgroundColor = Colors.black26;
}

void toast({String message = ''}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showLoading() {
  EasyLoading.show();
}

void hideLoading() {
  EasyLoading.dismiss();
}