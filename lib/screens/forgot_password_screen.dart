import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_money/blocs/auth_bloc/auth_bloc.dart';
import 'package:split_money/commons/assets_image.dart';
import 'package:split_money/commons/back_button.dart';
import 'package:split_money/commons/red_button.dart';
import 'package:split_money/commons/text_form_field.dart';
import 'package:split_money/extension/context.dart';
import 'package:split_money/extension/string_ext.dart';
import 'package:split_money/main.dart';
import 'package:split_money/route/app_path.dart';
import 'package:split_money/screens/reset_password_dialog.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Global key to manage the form state for validation
  final _formKey = GlobalKey<FormState>();
  late AuthBloc bloc;
  // TextEditingController to get the email input
  final TextEditingController _emailController = TextEditingController();
  String email = "";
  bool _isSubmitting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of(context);
  }
  // Handle the button press
  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      bloc.add(ForgotPasswordEvent(email: email));
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _showDialogForgotPassword() async {
    await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 400),
    // The transitionBuilder is where the animation magic happens.
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // Use a SlideTransition to slide the dialog up from the bottom.
      // We also use a FadeTransition for a smoother appearance.
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            // The dialog starts off-screen at the bottom.
            begin: const Offset(0, 1),
            // It slides to its normal position in the center.
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: child, // The dialog's content.
        ),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      // The pageBuilder returns the actual content of the dialog.
      return Center(child: ResetPasswordDialog(email: email));
    },
    );
    if(mounted){
      context.pushReplace(AppPaths.changePassword,extra: {"email" : email});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listener: (BuildContext context, AuthState state) {
        if(state is ForgotPasswordState){

          _showDialogForgotPassword();
        }else if (state is AuthErrorState){
          toast(message: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F5F9),
        // Background color from the image
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButtonCommon(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Image for the screen, which is a placeholder since we can't use the asset directly
                  AssetsImageCommon(
                    name: 'ic_forgot_password_header',
                    height: 150,
                  ),
                  const SizedBox(height: 32.0),
                  Text(
                    'Forgot Password',
                    textAlign: TextAlign.center,
                    style: context.headerTextBlack(),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Set a name for your profile, here's the password",
                    textAlign: TextAlign.center,
                    style: context.normalTextBlack(),
                  ),
                  const SizedBox(height: 40.0),
                  // Email input field
                  TextFormFieldCommon(
                    controller: _emailController,
                    hint: "Email",
                    label: 'Email',
                    validator: (value) {
                      return value?.isEmail();
                    },
                    onChange: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(height: 40.0),
                  // Next button
                  RedButtonCommon(text: 'NEXT',onPress: () => _onNextPressed(),isSubmitting: _isSubmitting,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
