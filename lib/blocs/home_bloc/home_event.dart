part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class GetUserStatEvent extends HomeEvent{
  const GetUserStatEvent();
}