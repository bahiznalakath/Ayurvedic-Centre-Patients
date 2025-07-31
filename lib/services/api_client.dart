import 'dart:convert';

import 'package:ayurvedic_centre_patients/helper/connectivity_status.dart';
import 'package:ayurvedic_centre_patients/helper/shared_storage/shared_storage.dart';
import 'package:ayurvedic_centre_patients/models/models/error_response.dart';
import 'package:ayurvedic_centre_patients/utils/constants.dart';
import 'package:ayurvedic_centre_patients/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetConnect {
  final int timeoutInSeconds = 40;
  static const String exceptionMessage = 'Something went wrong!';
  final constHeader = {
    'Accept': 'application/json',
  };

  ApiClient() {
    httpClient.timeout = Duration(seconds: timeoutInSeconds);
    httpClient.defaultContentType = 'application/json; charset=UTF-8';
  }

  getToken() async {
    var token = await SharedStorage().getSharedData(AppConstants.userToken);
    return token;
  }

  Future<Response> getData(String uri) async {
    var token = await getToken();
    bool connected = await connectivityStatus();
    Map<String, String> headers = token == null
        ? constHeader
        : {'Authorization': 'Bearer $token', 'Accept': 'application/json'};
    if (connected == false) {
      return const Response(statusCode: 0, statusText: noNetwork);
    } else {
      try {
        Response request =
            await get('${AppConstants.baseUrl}$uri', headers: headers);
        Response response = handleResponse(request);
        debugPrint(
            '====> API Call: token: $token $uri\nResponse: ${response.body}');

        return response;
      } catch (e) {
        return Response(statusCode: 1, statusText: e.toString());
      }
    }
  }

  Future<Response> postData(String uri, body) async {
    debugPrint('post_baseurl : ${AppConstants.baseUrl}');
    var token = await getToken();
    bool connected = await connectivityStatus();
    Map<String, String> headers = token == null
        ? constHeader
        : {'Authorization': 'Bearer $token', 'Accept': 'application/json'};
    if (connected == false) {
      return const Response(statusCode: 0, statusText: noNetwork);
    } else {
      try {
        Response request = await post(
                '${AppConstants.baseUrl}$uri', jsonEncode(body),
                headers: headers)
            .timeout(Duration(seconds: timeoutInSeconds));
        debugPrint('headers $headers');
        debugPrint('REQUEST ${request.statusCode}');
        debugPrint('REQUEST TEXT ${request.statusText}');

        Response response = handleResponse(request);
        debugPrint(
            '====> API Call: token: $token\n$uri\nBody: $body\nResponse: ${response.body}');
        return response;
      } catch (e) {
        debugPrint('error $e');
        return Response(statusCode: 1, statusText: e.toString());
      }
    }
  }

  Response handleResponse(Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
        body: _body ?? response.body,
        bodyString: response.body.toString(),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.statusText);
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors![0].message);
      } else if (_response.body.toString().startsWith('{message:')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      } else if (_response.statusCode != 500 && _response.body != null) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.statusText);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: _response.statusText);
    }
    return _response;
  }

  Response handleMultipartResponse(http.Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
        body: _body ?? response.body,
        bodyString: response.body.toString(),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase);
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors![0].message);
      } else if (_response.body.toString().startsWith('{message:')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
      // new code for handle error from projects
      else if (_response.body['errors'] is Map &&
          _response.body['errors'].isNotEmpty) {
        final errorDetails = _response.body['errors'] as Map;
        String? errorMessage;
        errorDetails.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            errorMessage = value[0];
          }
        });
        _response = Response(
          statusCode: _response.statusCode,
          body: _response.body,
          statusText: errorMessage ?? _response.statusText,
        );
      }
      //end
      else if (_response.statusCode != 500 && _response.body != null) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.statusText);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: _response.statusText);
    }
    return _response;
  }
}
