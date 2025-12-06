import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._();

  static Future<Map<String, dynamic>> get<T>({
    required String url,
  }) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        debugPrint('API Error: ${response.statusCode} - ${response.body}');
        throw Exception(
            'Failed to load data: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> post<T>(
      {required String url, Object? body}) async {
    try {
      final response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        debugPrint('API Error: ${response.statusCode} - ${response.body}');
        throw Exception(
            'Failed to load data: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
