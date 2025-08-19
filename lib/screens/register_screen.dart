import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_money/blocs/auth_bloc/auth_bloc.dart';
import 'package:split_money/commons/assets_image.dart';
import 'package:split_money/commons/back_button.dart';
import 'package:split_money/commons/red_button.dart';
import 'package:split_money/extension/context.dart';
import 'package:split_money/extension/string_ext.dart';
import 'package:split_money/main.dart';
import 'package:split_money/screens/verify_dialog.dart';

import '../commons/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // State variable to manage password visibility
  bool _isPasswordVisible = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String email = "";
  String name = "";
  String password = "";
  bool _isSubmitting = false;
  late AuthBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of(context);
  }

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      bloc.add(RegisterEvent(email: email, name: name, password: password));
      setState(() {
        _isSubmitting = false;
      });
    }
  }


  void showDialogAfterRegister(String email, String name) async {
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
        return Center(child: VerifyDialog(email: email,name: name,));
      },
    );
    if(mounted){
      context.pop();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if(state is RegisterSuccessState){
          toast(message: 'Register Success');
          showDialogAfterRegister(state.email,state.name);
        }else if(state is AuthErrorState){
          toast(message: state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButtonCommon(),
        ),
        // The background color from the Figma design
        backgroundColor: const Color(0xFFE4E9F2),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // Top illustration placeholder
                    _header(context),

                    const SizedBox(height: 30),

                    // Welcome title
                    Text(
                      'Welcome',
                      style: context.headerTextWhite().copyWith(
                        color: context.darkBluePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle text
                    Text(
                      "Set a name for your profile, here's\nthe password",
                      textAlign: TextAlign.center,
                      style: context.normalTextBlack().copyWith(
                        color: Color(0xFF6F7B8C),
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Password input field
                    TextFormFieldCommon(
                      controller: _nameController,
                      hint: "",
                      label: 'Name',
                      onChange: (value){
                        name = value;
                      },
                      validator: (p0) {
                        if(p0 == null || p0.isEmpty){
                          return 'Fill in your name please';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Email input field
                    TextFormFieldCommon(
                      controller: _emailController,
                      hint: "Email",
                      label: 'Email',
                      validator: (value) {
                        return value.isEmail();
                      },
                      onChange: (value){
                        email = value;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Name input field
                    TextFormFieldCommon(
                      controller: _passwordController,
                      isObscureText: _isPasswordVisible,
                      hint: "******",
                      label: 'Password',
                      onChange: (value){
                       password = value;
                      },
                      validator: (p0) {
                        return p0.validatePassword();
                      },
                    ),

                    const SizedBox(height: 50),

                    // Continue button
                    _registerButton(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
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
      child: Center(child: AssetsImageCommon(name: "ic_header_register")),
    );
  }

  Widget _registerButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: RedButtonCommon(text: 'CONTINUE',onPress: () => _registerUser(),isSubmitting: _isSubmitting,),
    );
  }
}
