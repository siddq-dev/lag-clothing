import 'dart:convert';

import 'package:http/http.dart' as http;

class ContactService {
  ContactService._();

  static const String _functionUrl =
      'https://us-central1-lag-clothing-e4567.cloudfunctions.net/sendContactMessage';

  static Future<void> sendContactMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    final response = await http.post(
      Uri.parse(_functionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'message': message.trim(),
      }),
    );

    Map<String, dynamic>? data;

    try {
      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        data = decoded;
      }
    } catch (_) {
      // Ignore invalid JSON and use the HTTP status below.
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (data?['success'] == false) {
        throw Exception(data?['message'] ?? 'Unable to send your message.');
      }

      return;
    }

    throw Exception(
      data?['message'] ??
          'Unable to send your message right now. Please try again later.',
    );
  }
}
