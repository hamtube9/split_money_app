import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_money/commons/alert_dialog.dart';
import 'package:split_money/main.dart';
import 'package:split_money/utils/app_exceptions.dart';
import 'package:split_money/utils/log_util.dart';


abstract class BaseBlocCustom<Event, State> extends Bloc<Event, State> {
  BaseBlocCustom(super.initialState);

  /// HANDLE ERROR EXCEPTION
  /// [BadRequestException] will throw when bad request
  /// [FetchDataException]  will throw when occurred exception during fetching data
  /// [ApiNotRespondingException] Server not responding or sending timeout
  /// [NotFoundException] will throw when URL not found
  /// [TimeoutException] will throw when request timeout
  /// [CancelRequestException] will throw when user cancel request
  /// [SocialLoginException] will throw when something went wrong with social login
  /// [FileTooLargeException] will throw when user upload file size too large
  ///
  String handleError(error) {
    if (error is BadRequestException) {
      return LogUtils().i('${error.message} - URL: ${error.url}');
    } else if (error is FetchDataException) {
      return LogUtils().i('${error.message} - URL: ${error.url}');
    } else if (error is ApiNotRespondingException) {
      return LogUtils().i('${error.message} - URL: ${error.url}');
    } else if (error is NotFoundException) {
      AlertPopup(title: 'Error', msg: error.message ?? 'Failed')
          .showAlertPopup(navigatorKey.currentState!.overlay!.context);
      return LogUtils().i('${error.message} - URL: ${error.url}');
    } else if (error is TimeoutException) {
      return LogUtils()
          .i('${error.message.toString()} - URL: ${error.duration.toString()}');
    } else if (error is CancelRequestException) {
      return LogUtils().i('${error.message.toString()} - URL: ${error.url}');
    } else if (error is SocialLoginException) {
      return LogUtils().i('${error.message.toString()} - Failed: $error');
    } else if (error is FileTooLargeException) {
      AlertPopup(title: 'Error', msg: '${error.message}')
          .showAlertPopup(navigatorKey.currentState!.overlay!.context);
      return LogUtils().i('${error.message.toString()} - Failed: $error');
    } else {
      return error.toString();
    }
  }

}