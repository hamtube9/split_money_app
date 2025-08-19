
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitState extends HomeState {
  const HomeInitState();
}


class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeLoadedState extends HomeState {
  const HomeLoadedState();
}

class HomeErrorState extends HomeState {
  final String error;

  const HomeErrorState(this.error);
}

class GetUserStatSuccessState extends HomeState{
  final UserStat stat;

  const GetUserStatSuccessState({required this.stat});
}