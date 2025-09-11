import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class THttpHelper {
  static const String _baseUrl = APIConstants.baseURL;

  // Common headers; extend as needed
  static Map<String, String> _headers({String? token}) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
  };

  // GET
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? query,
    String? token,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: query);
    final resp = await http
        .get(uri, headers: _headers(token: token))
        .timeout(timeout);
    return _handleResponse(resp);
  }

  // POST
  static Future<Map<String, dynamic>> post(
    String endpoint, {
    dynamic data,
    String? token,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final resp = await http
        .post(
          uri,
          headers: _headers(token: token),
          body: jsonEncode(data ?? {}),
        )
        .timeout(timeout);
    return _handleResponse(resp);
  }

  // PUT
  static Future<Map<String, dynamic>> put(
    String endpoint, {
    dynamic data,
    String? token,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final resp = await http
        .put(uri, headers: _headers(token: token), body: jsonEncode(data ?? {}))
        .timeout(timeout);
    return _handleResponse(resp);
  }

  // DELETE
  static Future<Map<String, dynamic>> delete(
    String endpoint, {
    dynamic data,
    String? token,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final resp = await http
        .delete(
          uri,
          headers: _headers(token: token),
          body: jsonEncode(data ?? {}),
        )
        .timeout(timeout);
    return _handleResponse(resp);
  }

  // Basic response handler
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final status = response.statusCode;
    final body = response.body.isEmpty ? {} : jsonDecode(response.body);

    if (status >= 200 && status < 300) {
      return {'success': true, 'status': status, 'data': body};
    } else {
      return {
        'success': false,
        'status': status,
        'error':
            body is Map<String, dynamic> ? (body['message'] ?? body) : body,
      };
    }
  }
}
