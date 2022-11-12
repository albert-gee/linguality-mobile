import 'package:dio/dio.dart';
import 'package:linguality_mobile/utils/api/api_response.dart';

class Api {
  final Dio _dio = Dio();

  Future<ApiResponse> post(
      {required String url, Map<String, dynamic>? data, String? jwt}) async {
    Response response = await _dio.post(url,
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

  /// Send post request, download file, and save to temporary directory
  Future<ApiResponse> postDownload(
      {required String url, required String tempFilePath, Map<String, dynamic>? data, String? jwt}) async {

    ApiResponse apiResponse;

    try {
      Response response = await _dio.download(url,
          tempFilePath,
          data: data,
          options: Options(
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "Authorization": (jwt != null ? "Bearer $jwt" : null),
            }),
      );

      apiResponse = ApiResponse(
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          data: tempFilePath);

    } catch (e) {
      print(e);
      apiResponse = ApiResponse(
          statusCode: 500,
          statusMessage: "Internal Server Error",
          data: null);
    }
    return apiResponse;
  }
}
