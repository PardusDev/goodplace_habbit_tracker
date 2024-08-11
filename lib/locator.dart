import 'package:get_it/get_it.dart';
import 'package:goodplace_habbit_tracker/repository/repository.dart';
import 'package:goodplace_habbit_tracker/services/api_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Repository());
  locator.registerLazySingleton(() => ApiService());
}