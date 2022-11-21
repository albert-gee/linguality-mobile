import 'package:dio/dio.dart';
import 'package:linguality_mobile/utils/api/api_response.dart';
import 'package:linguality_mobile/utils/auth/auth_service_contract.dart';

class Api {
  final Dio _dio = Dio();
  final AuthServiceContract auth;

  Api({required this.auth});

  Future<ApiResponse> post({required String url, Map<String, dynamic>? data}) async {
    ApiResponse apiResponse;

    try {
      await auth.authenticate();
      var jwt = await auth.getAccessToken();
      if (jwt == null) {
        throw Exception("Unauthenticated");
      }

      Response response = await _dio.post(
        url,
        data: data,
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
            "Content-Type": "application/json",
            "Authorization": (jwt != null ? "Bearer $jwt" : null),
          },
        ),
      );

      apiResponse =
          ApiResponse(statusCode: response.statusCode, statusMessage: response.statusMessage, data: response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      apiResponse = ApiResponse(statusCode: 500, statusMessage: "Internal Server Error", data: null);
    }

    return apiResponse;
  }

  Future<ApiResponse> get({required String url}) async {
    ApiResponse apiResponse;

    try {
      await auth.authenticate();
      var jwt = await auth.getAccessToken();
      if (jwt == null) {
        throw Exception("Unauthenticated");
      }

      Response response = await _dio.get(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": ("Bearer $jwt"),
        }),
      );

      apiResponse =
          ApiResponse(statusCode: response.statusCode, statusMessage: response.statusMessage, data: response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      apiResponse = ApiResponse(statusCode: 500, statusMessage: "Internal Server Error", data: null);
    }

    return apiResponse;
  }

  /// Send post request, download file, and save to temporary directory
  Future<ApiResponse> postDownload({
    required String url,
    required String tempFilePath,
    required Map<String, dynamic> data,
  }) async {
    ApiResponse apiResponse;

    try {
      await auth.authenticate();
      var jwt = await auth.getAccessToken();
      if (jwt == null) {
        throw Exception("Unauthenticated");
      }

      Response response = await _dio.download(
        url,
        tempFilePath,
        data: data,
        options: Options(method: "POST", headers: {
          "Content-Type": "application/json",
          "Authorization": (jwt != null ? "Bearer $jwt" : null),
        }),
      );

      apiResponse = ApiResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        data: tempFilePath,
      );
    } catch (e) {
      print(e);
      apiResponse = ApiResponse(
        statusCode: 500,
        statusMessage: "Internal Server Error",
        data: null,
      );
    }

    return apiResponse;
  }

  /// Send get request, download file, and save to temporary directory
  Future<ApiResponse> getDownload({
    required String url,
    required String tempFilePath,
  }) async {
    ApiResponse apiResponse;

    try {
      await auth.authenticate();
      var jwt = await auth.getAccessToken();
      if (jwt == null) {
        throw Exception("Unauthenticated");
      }

      Response response = await _dio.download(
        url,
        tempFilePath,
        options: Options(method: "GET", headers: {
          "Content-Type": "application/json",
          "Authorization": ("Bearer $jwt"),
        }),
      );

      apiResponse = ApiResponse(
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        data: tempFilePath,
      );
    } catch (e) {
      print(e);
      apiResponse = ApiResponse(
        statusCode: 500,
        statusMessage: "Internal Server Error",
        data: null,
      );
    }

    return apiResponse;
  }
}
