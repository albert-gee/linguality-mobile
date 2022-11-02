import 'package:dio/dio.dart';
import 'package:linguality_mobile/utils/api/api_response.dart';

class Api {
  final Dio _dio = Dio();

  Future<ApiResponse> post(
      {required url, Map<String, dynamic>? data, String? jwt}) async {
    Response response = await _dio.post("$url",
        data: data,
        options: Options(
            validateStatus: (status) {
              return status! < 500;
            },
            headers: {
              "Content-Type": "application/json",
              "Authorization": (jwt != null ? "Bearer $jwt" : null),
            }));

    return ApiResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        data: response.data);
  }
}
