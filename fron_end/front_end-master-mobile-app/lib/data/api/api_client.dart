import 'dart:convert';

import '/utils/utils.dart';
import 'package:get/get.dart';
import 'dart:html';
import 'package:http/http.dart' as http;

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  // final authController = Get.find<UserAuthController>().getUserToken();
  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri, headers: headers ?? _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateData(String uri, dynamic body) async {
    try {
      Response response = await put(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<http.Response> downloadFile(
      String uri, String fileName, int userId) async {
    try {
      http
          .post(
        Uri.parse(uri),
        body: json.encode(
          {"fileName": fileName, 'userId': userId},
        ),
        headers: _mainHeaders,
      )
          .then((response) {
        final blob = Blob([response.bodyBytes]);
        final url = Url.createObjectUrl(blob);
        final link = AnchorElement(href: url)
          ..setAttribute('download', fileName);
        link.click();
        Url.revokeObjectUrl(url);
        return response;
      });
      final message = 'Failed';
      return http.Response(message, 400, headers: const {});
    } catch (e) {
      print(e);
      final message = 'Failed';
      return http.Response(message, 400, headers: const {});
    }
  }
}
