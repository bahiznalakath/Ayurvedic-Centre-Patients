import 'dart:convert';

import 'package:ayurvedic_centre_patients/helper/connectivity_status.dart';
import 'package:ayurvedic_centre_patients/helper/shared_storage/shared_storage.dart';
import 'package:ayurvedic_centre_patients/models/models/error_response.dart';
import 'package:ayurvedic_centre_patients/utils/constants.dart';
import 'package:ayurvedic_centre_patients/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetConnect {
  final int timeoutInSeconds = 40;

  ApiClient() {
    httpClient.timeout = Duration(seconds: timeoutInSeconds);
  }

  Future<String?> getToken() async {
    return await SharedStorage().getSharedData(AppConstants.userToken);
  }

  Future<Response> getData(String uri) async {
    final token = await getToken();
    final connected = await connectivityStatus();

    if (!connected) {
      return const Response(statusCode: 0, statusText: noNetwork);
    }

    try {
      final headers = <String, String>{};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response =
          await get("${AppConstants.baseUrl}$uri", headers: headers);
      print(response.body);
      return handleResponse(response);
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    debugPrint('POST: ${AppConstants.baseUrl}$uri');
    final token = await getToken();
    final connected = await connectivityStatus();

    if (!connected) {
      return const Response(statusCode: 0, statusText: noNetwork);
    }

    final headers = {
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await post(
        '${AppConstants.baseUrl}$uri',
        jsonEncode(body),
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSeconds));

      debugPrint('Response ${response.statusCode}: ${response.body}');
      return handleResponse(response);
    } catch (e) {
      debugPrint('POST ERROR: $e');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleResponse(Response response) {
    dynamic parsedBody;
    try {
      parsedBody = jsonDecode(response.body);
    } catch (_) {
      parsedBody = response.body;
    }

    Response finalResponse = response.copyWith(body: parsedBody);

    if (finalResponse.statusCode != 200 && parsedBody != null) {
      return _extractError(finalResponse);
    }

    return finalResponse;
  }

  Future<Response> comment({
    required String uri,
    required Map<String, String> fields,
  }) async {
    final token = await getToken();
    final connected = await connectivityStatus();

    if (!connected) {
      return const Response(statusCode: 0, statusText: noNetwork);
    }

    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse("${AppConstants.baseUrl}$uri"));

      // Set Authorization header
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Add fields to the request
      request.fields.addAll(fields);
      debugPrint("Multipart FormData Sent -> ${request.fields}");

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      return handleMultipartResponse(response);
    } catch (e) {
      debugPrint("Comment Error: $e");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleMultipartResponse(http.Response response) {
    dynamic parsedBody;
    try {
      parsedBody = jsonDecode(response.body);
    } catch (_) {
      parsedBody = response.body;
    }

    Response finalResponse = Response(
      body: parsedBody,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (finalResponse.statusCode != 200 && parsedBody != null) {
      return _extractError(finalResponse);
    }

    return finalResponse;
  }

  Response _extractError(Response response) {
    final bodyStr = response.body.toString();

    if (bodyStr.startsWith('{errors: [{code:')) {
      final error = ErrorResponse.fromJson(response.body);
      return response.copyWith(
          statusText: error.errors?[0].message ?? 'Unknown error');
    } else if (response.body is Map && response.body['message'] != null) {
      return response.copyWith(statusText: response.body['message']);
    } else if (response.body is Map && response.body['errors'] is Map) {
      final errors = response.body['errors'] as Map;
      String? message;
      errors.forEach((key, value) {
        if (value is List && value.isNotEmpty) {
          message = value[0];
        }
      });
      return response.copyWith(statusText: message ?? response.statusText);
    } else {
      return response;
    }
  }
}
