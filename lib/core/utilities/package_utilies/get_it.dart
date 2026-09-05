import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/core/services/api_helper.dart';

final getIt =GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton<Dio>(
    () => ApiHelper.createDio(),
  );
}

