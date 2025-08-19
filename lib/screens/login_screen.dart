import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_money/blocs/auth_bloc/auth_bloc.dart';
import 'package:split_money/commons/assets_image.dart';
import 'package:split_money/commons/red_button.dart';
import 'package:split_money/commons/text_field_common.dart';
import 'package:split_money/commons/text_form_field.dart';
import 'package:split_money/extension/context.dart';
import 'package:split_money/extension/string_ext.dart';
import 'package:split_money/main.dart';
import 'package:split_money/route/app_path.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShowPassword = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  late AuthBloc bloc;
  String email = "";
  String password = "";
  bool _isSubmitting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      bloc.add(LoginEvent(email: email, password: password));
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _resetPassword() {
    context.push(AppPaths.forgotPassword);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if(state is LoginSuccessState){
            context.pushRemoveUntil(AppPaths.home,extra: {"refreshToken" : false});
            toast(message: 'Success');
          }else if (state is AuthErrorState){
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: GestureDetector(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),

                        // Top illustration placeholder
                        _header(context),

                        const SizedBox(height: 30),

                        // Login title
                        Text(
                          'Login',
                          style: context.headerTextBlack().copyWith(
                            color: context.darkBluePrimary,
                          ),
                        ),

                        const SizedBox(height: 50),

                        // Name input field
                        TextFormFieldCommon(
                          controller: _emailController,
                          label: 'Email',
                          hint: 'email',
                          validator: (p0) {
                            return p0.isEmail();
                          },
                          onChange: (email) {
                            this.email = email;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Password input field
                        TextFormFieldCommon(
                          controller: _passController,
                          label: 'Password',
                          hint: 'Password',
                          validator: (p0) {
                            return p0.validatePassword();
                          },
                          onChange: (password) {
                            this.password = password;
                          },
                          isObscureText: isShowPassword,
                        ),

                        const SizedBox(height: 10),

                        // "Forgot password?" text
                        _forgotPassword(context),

                        const SizedBox(height: 30),

                        // Login button
                        _loginButton(context),

                        const SizedBox(height: 50),

                        // "Don't have an account? Signup" text
                        _footerText(context),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => _resetPassword(),
        child: Text(
          'Forgot password?',
          style: context.normalTextBlack().copyWith(
            fontWeight: FontWeight.w500,
            color: Color(0xFF6F7B8C),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: RedButtonCommon(text: 'LOGIN', onPress: () => _login(),isSubmitting: _isSubmitting,),
    );
  }

  Widget _footerText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have an account? ",
        style: context.normalTextBlack().copyWith(fontSize: 16),
        children: [
          TextSpan(
            text: 'Signup',
            style: context.normalTextBlack().copyWith(
              fontSize: 16,
              color: context.redPrimary,
            ),
            // Wrap with a TapGestureRecognizer for a clickable link
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.push(AppPaths.register);
              },
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFD6E3FF),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFB1D1FF), width: 5),
      ),
      child: Center(child: AssetsImageCommon(name: "ic_header_login")),
    );
  }
}
