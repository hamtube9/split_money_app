import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:split_money/route/app_path.dart';
import 'package:split_money/screens/change_password_scren.dart';
import 'package:split_money/screens/forgot_password_screen.dart';
import 'package:split_money/screens/home_screen.dart';
import 'package:split_money/screens/login_screen.dart';
import 'package:split_money/screens/register_screen.dart';
import 'package:split_money/screens/splash_screen.dart';
import 'package:split_money/theme/app_theme.dart';

import 'cores/main_bloc.dart';
import 'main.dart';

class SplitMoney extends StatelessWidget {
  const SplitMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainBloc.allBlocs(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localeResolutionCallback: (locale, _) {
          return locale;
        },
        localizationsDelegates: [
          DefaultCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        builder: EasyLoading.init(
          builder: (context, widget) {
            widget = GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: widget,
            );
            return widget;
          },
        ),
        routes: {
          AppPaths.splash: (context) => const SplashScreen(),

          AppPaths.login: (context) => const LoginScreen(),

          AppPaths.register: (context) => const RegisterScreen(),

          AppPaths.forgotPassword: (context) => const ForgotPasswordScreen(),

          AppPaths.changePassword: (context) {
            String? email;
            final data =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            if (data != null) {
              if (data.containsKey('email')) {
                email = data['email'];
              }
            }

            return ChangePasswordScreen(email: email ?? "");
          },

          AppPaths.home: (context) {
            bool refreshToken = false;
            final data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
            if (data != null && data.containsKey('refreshToken')) {
              refreshToken = data['refreshToken'];
            }
            return HomeScreen(refreshToken: refreshToken,);
          },
        },
      ),
    );
  }
}
