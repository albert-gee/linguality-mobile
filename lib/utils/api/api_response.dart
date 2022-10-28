class ApiResponse {

  final dynamic data;
  final int? statusCode;
  final String? statusMessage;

  ApiResponse({
    this.data,
    this.statusCode,
    this.statusMessage
  });
}