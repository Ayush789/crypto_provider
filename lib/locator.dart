import 'package:get_it/get_it.dart';

import 'core/services/api.dart';
import 'core/sharedmodel/all_coins.dart';
import 'core/viewmodel/add_coin_model.dart';
import 'core/viewmodel/dashboard_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => API());
  locator.registerLazySingleton(() => HomeModel());
  locator.registerLazySingleton(() => AllCoins());
  locator.registerFactory(() => AddCoinModel());
}
