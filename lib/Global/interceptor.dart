import 'package:dio/dio.dart';

Future<Dio> getInterceptors() async {
  BaseOptions options = new BaseOptions();

  /// Fetch User DB and pass on user token to every api Request

  //var user = await db.getLogUser();

  options.sendTimeout = 60000;
  options.receiveTimeout = 60000;
  options.connectTimeout = 70000;
  options.contentType = "application/json";

  Dio dio = new Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        return options;
      },
      onResponse: ( response) async {
        return response; // continue
      },
      onError: (DioError e) async {
        if (e.  response?.statusCode == 401) {
          return e.error;
        }
        if(e.response?.statusCode == 422){
          return e.error;
        }
        else {
          return e.response.data['message'];
        }
      },
    ),
  );
  return dio;
}