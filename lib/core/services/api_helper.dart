import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/core/const.dart';

abstract class  ApiHelper {
 static late Dio _dio ;
 static Dio createDio(){
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstApi.baseURl,
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(seconds: 15),
      ),
    )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            // options.headers['Authorization'] = "Bearer ";
            log('Base URL: ${options.baseUrl}');
            log('Path: ${options.path}');
            log('Method: ${options.method}');
            log('Headers: ${options.headers}');
            log('Data: ${options.data}');
            return handler.next(options);
          },
          onResponse: (response, handler) {
            log('StatusMessage: ${response.statusMessage}');
            log('Headers: ${response.headers}');
            log('Data: ${response.data}');
            return handler.next(response);
          },
        ),
      );
    return _dio;
  }
}
