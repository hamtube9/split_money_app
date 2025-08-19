import 'package:flutter/material.dart';

extension BuildContextEntension<T> on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;

  bool get isSmallTablet =>
      MediaQuery.of(this).size.width < 650.0 &&
      MediaQuery.of(this).size.width > 500.0;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;

  bool get isSmall =>
      MediaQuery.of(this).size.width < 850.0 &&
      MediaQuery.of(this).size.width >= 560.0;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;

  String imagePng(String text) => 'assets/images/$text.png';

  String svgPicture(String text) => 'assets/svg/$text.svg';

  static const String BACKGROUND = "0xffEFF5FE";
  static const String BACKGROUND2 = "0xffEFF2F4";

  Color get background => const Color(0xffEFF5FE);

  Color get background2 => const Color(0xffEFF2F4);

  Color get redPrimary => const Color(0xffFB847C);

  Color get darkBluePrimary => const Color(0xff011A51);

  void pop({dynamic result}) {
    Navigator.of(this).pop(result);
  }

  Future<T?> push<T>(String path, {Map<String, dynamic>? extra}) {
    return Navigator.of(this).pushNamed(path, arguments: extra);
  }

  Future<T?> pushRemoveUntil<T>(String path, {Map<String, dynamic>? extra}) {
    return Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(path, (route) => false, arguments: extra);
  }

  Future<T?> pushReplace<T>(String path, {Map<String, dynamic>? extra}) {
    return Navigator.of(this).pushReplacementNamed(path, arguments: extra);
  }

  // String translate(String key) {
  //   return AppLocalizations.translate(key);
  // }

  TextStyle headerTextBlack() {
    return const TextStyle(
      fontFamily: 'TitilliumWeb',
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Color(0xff011A51),
    );
  }

  TextStyle headerTextWhite() {
    return const TextStyle(
      fontFamily: 'TitilliumWeb',
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Color(0xffffffff),
    );
  }

  TextStyle normalTextBlack() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Color(0xff000000),
    );
  }

  TextStyle normalTextWhite() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Color(0xffffffff),
    );
  }

  TextStyle normalTextBold() {
    return const TextStyle(
      fontSize: 14.0,
      fontFamily: 'TitilliumWeb',
      fontWeight: FontWeight.w700,
      color: Color(0xff333333),
    );
  }

  TextStyle normalTextBoldWhite() {
    return const TextStyle(
      fontSize: 14.0,
      fontFamily: 'TitilliumWeb',
      fontWeight: FontWeight.w700,
      color: Color(0xffffffff),
    );
  }

  TextStyle dateTextNormal() {
    return const TextStyle(
      fontSize: 14.0,
      // fontFamily: 'AvenirNextLTPro',
      fontWeight: FontWeight.w400,
      color: Color(0xff000000),
    );
  }

  TextStyle dateTextMedium() {
    return const TextStyle(
      fontSize: 14.0,
      // fontFamily: 'AvenirNextLTPro',
      fontWeight: FontWeight.w600,
      color: Color(0xff000000),
    );
  }
}
