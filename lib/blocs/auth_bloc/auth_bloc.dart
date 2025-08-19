
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_money/cores/base_bloc.dart';
import 'package:split_money/cores/dio_client.dart';
import 'package:split_money/main.dart';
import 'package:split_money/models/user/user.dart';
import 'package:split_money/repository/auth_repository.dart';
import 'package:split_money/utils/shared_preference.dart';

import '../../cores/dependency_injection.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc
    extends BaseBlocCustom<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitState()) {
    on<LoginEvent>(_handleLoginEvent);
    on<RegisterEvent>(_handlerRegisterEvent);
    on<ChangePasswordEvent>(_handleChangePasswordEvent);
    on<ForgotPasswordEvent>(_handleForgotPasswordEvent);
  }

  FutureOr<void> _handleLoginEvent(LoginEvent event, Emitter<AuthState> emit) async{
    try{
      emit(AuthLoadingState());
      var res = await AuthRepositoryImpl.instance.login(event.email, event.password);
      if(res.isSuccess){
        await _handleAfterLogin(res.data!.accessToken ?? "",res.data!.user!);
        emit(LoginSuccessState());
      }else{
        emit(AuthErrorState(res.message ?? ""));
      }
    }catch(e){
      emit(AuthErrorState(e.toString()));
    }
    emit(AuthLoadedState());
  }


  FutureOr<void> _handlerRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async  {
    try{
      showLoading();
      emit(AuthLoadingState());
      var res = await AuthRepositoryImpl.instance.register(event.email, event.name, event.password);
      if(res.isSuccess){
        emit(RegisterSuccessState(name: event.name, email: event.email));
      }
    }catch(e){
      emit(AuthErrorState(e.toString()));
    }
    emit(AuthLoadedState());
    hideLoading();
  }

  FutureOr<void> _handleChangePasswordEvent(ChangePasswordEvent event, Emitter<AuthState> emit) async {
    try{
      showLoading();
      emit(AuthLoadingState());
      var res = await AuthRepositoryImpl.instance.changePassword(event.email,event.oldPassword,event.password);
      if(res.isSuccess){
        emit(ChangePasswordState());
      }
    }catch(e){
      emit(AuthErrorState(e.toString()));
    }
    emit(AuthLoadedState());
    hideLoading();
  }

  FutureOr<void> _handleForgotPasswordEvent(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    try{
      showLoading();
      emit(AuthLoadingState());
      var res = await AuthRepositoryImpl.instance.forgotPassword(event.email,);
      if(res.isSuccess){
        emit(ForgotPasswordState(email: event.email));
      }
    }catch(e){
      emit(AuthErrorState(e.toString()));
    }
    emit(AuthLoadedState());
    hideLoading();
  }

  void _logOut() async {
    await getIt.get<SharedPreferencesService>().logOut();
    DioClient.logOut();
  }

  Future _handleAfterLogin(String token, User user) async {
    await getIt.get<SharedPreferencesService>().setToken(token);
    await getIt.get<SharedPreferencesService>().setUser(user);
    DioClient.setToken(token);
  }

}