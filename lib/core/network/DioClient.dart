import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient._(this.dio);

  factory DioClient.create({required String baseUrl}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.addAll([
      _CommonHeadersInterceptor(),
      _RequestIdInterceptor(),
    ]);

    return DioClient._(dio);
  }
}

class _CommonHeadersInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    options.headers.addAll({
      'X-IP-ADDRESS': '192.168.20.13',
      'CONTENT-TYPE': 'application/json; charset=utf-8',
      'X-LANGUAGE-ID': 'ENG',
      'AUTHORIZATION': 'Bearer FD8413F8-230F-4A96-AAFD-D29593AED0A7',
      'X-AUTHORIZATION': 'FD8413F8-230F-4A96-AAFD-D29593AED0A7',
      'X-GEO-LOCATION': 'INDIA',
      'X-DEVICE-ID': 'FD8413F8-230F-4A96-AAFD-D29593AED0A7',
      'X-API-VERSION': '1.0.0',
      'USER-AGENT': 'Dart/2.18 (dart:io)',
      'X-USER-AGENT': 'iOS',
      'X-APPLICATON-ID': 'MSILAPP1',
      'ACCEPT-ENCODING': 'gzip',
      'X-REQ-UID': 'FD8413F8-230F-4A96-AAFD-D29593AED0A7',
      'ACCEPT': 'application/json',
    });

    handler.next(options);
  }
}

class _RequestIdInterceptor extends Interceptor {
  static int _counter = 0;

  String _generateRequestId() {
    _counter++;
    return 'REQ-${_counter.toString().padLeft(5, '0')}';
  }

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    final requestId = _generateRequestId();

    options.extra['requestId'] = requestId;

    print('');
    print('[$requestId] → ${options.method} ${options.uri}');
    print('[$requestId] → Request: ${options.data}');

    handler.next(options);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    final requestId = response.requestOptions.extra['requestId'];

    print(
      '[$requestId] ← ${response.statusCode} '
          '${response.requestOptions.method} '

    );

    print('[$requestId] ← Response: ${response.data}');

    handler.next(response);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    final requestId = err.requestOptions.extra['requestId'];

    print(
      '[$requestId] ✕ ${err.requestOptions.method} '
          '${err.requestOptions.uri}',
    );

    print('[$requestId] ✕ Error: ${err.message}');
    print('[$requestId] ✕ Response: ${err.response?.data}');

    handler.next(err);
  }
}