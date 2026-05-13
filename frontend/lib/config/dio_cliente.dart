import 'package:dio/dio.dart';
import 'api_config.dart';
class DioClient {
  final Dio dio;
  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiConfigUsers.baseUrl,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),

            headers: {
              "Content-Type": "application/json",
            },
          ),
        );

}