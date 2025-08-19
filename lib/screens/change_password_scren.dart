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

class ChangePasswordScreen extends StatefulWidget {
  final String email;

  const ChangePasswordScreen({super.key, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // Global key to manage the form state for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for the password fields
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();

  // State to manage the password visibility toggle
  bool _isNewPasswordVisible = false;
  bool _isOldPasswordVisible = false;

  // State for the submitting button
  bool _isSubmitting = false;
  String _oldPassword = "";
  String _newPassword = "";
  late AuthBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of(context);
  }

  // Handle the submission logic
  void _onSubmittingPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      bloc.add(
        ChangePasswordEvent(
          email: widget.email,
          oldPassword: _oldPassword,
          password: _newPassword,
        ),
      );

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listener: (BuildContext context, AuthState state) {
        if(state is ChangePasswordState){
          toast(message: 'Change password success');
          context.pop();
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Image for the screen, which is a placeholder since we can't use the asset directly
                  AssetsImageCommon(name: 'ic_verify',height: 120,),
                  const SizedBox(height: 32.0),
                    Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: context.headerTextBlack().copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 8.0),
                    Text(
                    "Set a name for your profile, here's the password",
                    textAlign: TextAlign.center,
                    style: context.normalTextBlack().copyWith(color: Colors.grey)
                  ),
                  const SizedBox(height: 40.0),
                  // New password input field
                  TextFormFieldCommon(
                    label: 'Old Password',
                    controller: _oldPasswordController,
                    onChange: (p0) {
                      _oldPassword = p0;
                    },
                    validator: (p0) {
                      return p0.validatePassword();
                    },
                    isObscureText: _isOldPasswordVisible,
                  ),
                  const SizedBox(height: 20.0),
                  // Confirm password input field
                  TextFormFieldCommon(
                    label: 'New Password',
                    controller: _newPasswordController,
                    onChange: (p0) {
                      _newPassword = p0;
                    },
                    validator: (p0) {
                      return p0.validatePassword();
                    },
                    isObscureText: _isNewPasswordVisible,
                  ),
                  const SizedBox(height: 40.0),
                  // Submitting button
                  RedButtonCommon(
                    text: 'SUBMIT',
                    isSubmitting: _isSubmitting,
                    onPress: () => _onSubmittingPressed(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
