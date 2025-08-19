
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_money/blocs/auth_bloc/auth_bloc.dart';
import 'package:split_money/blocs/home_bloc/home_bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() => [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      lazy: true,
    ),
    BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(),
      lazy: true,
    ),
    // BlocProvider<SearchBloc>(
    //   create: (context) => SearchBloc(),
    //   lazy: true,
    // ),
    // BlocProvider<ProfileBloc>(
    //   create: (context) => ProfileBloc(),
    //   lazy: true,
    // ),
    // BlocProvider<RestaurantBloc>(
    //   create: (context) => RestaurantBloc(),
    //   lazy: true,
    // ),
    // BlocProvider<ExploreBloc>(
    //   create: (context) => ExploreBloc(),
    //   lazy: true,
    // ),
    // BlocProvider<BLogBloc>(
    //   create: (context) => BLogBloc(),
    //   lazy: true,
    // ),
    // BlocProvider<LocalizationBloc>(
    //   create: (context) => LocalizationBloc(),
    //   lazy: true,
    // ),
  ];
}
