
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_money/cores/base_bloc.dart';
import 'package:split_money/models/user/user_stat.dart';
import 'package:split_money/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc
    extends BaseBlocCustom<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitState()) {
    on<GetUserStatEvent>(_handlerGetUserStatEvent);
  }


  FutureOr<void> _handlerGetUserStatEvent(GetUserStatEvent event, Emitter<HomeState> emit) async  {
    try{
      emit(HomeLoadingState());
      var res = await HomeRepositoryImpl.instance.getUserStat();
      if(res.isSuccess){
        emit(GetUserStatSuccessState(stat: res.data!));
      }
    }catch(e){
      emit(HomeErrorState(e.toString()));
    }
    emit(HomeLoadedState());
  }

}