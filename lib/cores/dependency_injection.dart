
import 'package:get_it/get_it.dart';
import 'package:split_money/utils/shared_preference.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  /// Register Dependency
  _initBloc();
}

void _initBloc() async {
  // Init lazy singleton services
  asyncInstance();

  // Init bloc
  // getIt.registerLazySingleton<AuthenticationBloc>(
  //   () => AuthenticationBloc(),
  // );
  //
  // getIt.registerLazySingleton<DashboardBloc>(
  //   () => DashboardBloc(),
  // );
  //
  // getIt.registerLazySingleton<SearchBloc>(
  //   () => SearchBloc(),
  // );
  //
  // getIt.registerLazySingleton<ProfileBloc>(
  //   () => ProfileBloc(),
  // );
  //
  // getIt.registerLazySingleton<RestaurantBloc>(
  //   () => RestaurantBloc(),
  // );
  // getIt.registerLazySingleton<ExploreBloc>(
  //   () => ExploreBloc(),
  // );
  // getIt.registerLazySingleton<BLogBloc>(
  //   () => BLogBloc(),
  // );
  // getIt.registerLazySingleton<LocalizationBloc>(
  //       () => LocalizationBloc(),
  // );
}

void asyncInstance() async {
  /***********************
   * SERVICES
   **********************/
  // Shared Preferences
  getIt.registerLazySingletonAsync<SharedPreferencesService>(
      () => SharedPreferencesService.instance);
  await getIt.isReady<SharedPreferencesService>();

  // Connectivity
  // getIt.registerLazySingletonAsync<List<ConnectivityResult>>(
  //     () => Connectivity().checkConnectivity());
  // await getIt.isReady<List<ConnectivityResult>>();
}
