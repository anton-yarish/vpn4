import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'BaseApiServices.dart';

class NetworkApiServices extends BaseApiServices {
  var timeoutDuration = const Duration(seconds: 20);
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeoutDuration);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: data).timeout(timeoutDuration);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        dynamic responseData =
            (response.body.isNotEmpty) ? jsonDecode(response.body) : "";
        String responsemessage = responseData['message'];
        throw InvalidInputRequest(
            responsemessage + response.statusCode.toString());
      case 400:
        dynamic responseData =
            (response.body.isNotEmpty) ? jsonDecode(response.body) : "";
        String responsemessage = responseData['message'];
        throw BadRequestException(
            responsemessage + response.statusCode.toString());
      default:
        dynamic responseData =
            (response.body.isNotEmpty) ? jsonDecode(response.body) : "";
        String responsemessage =
            (response.body.isNotEmpty) ? responseData['message'] : "";
        throw FetchDataException(
            "${responsemessage} ${responseData.toString()}");
    }
  }
}
