import 'package:get_it/get_it.dart';

import 'core/services/api.dart';
import 'core/viewmodel/home_model.dart';


GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(()=>API());
  locator.registerLazySingleton(()=>HomeModel());
}
