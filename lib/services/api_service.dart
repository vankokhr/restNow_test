import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<String> sendCommand(String command) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode({'command': command}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return 'Команда "$command" виконана успішно';
      } else {
        return 'Помилка виконання команди';
      }
    } catch (e) {
      return '''Помилка з'єднання''';
    }
  }

  static Future<bool> simulatePayment() async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode({'status': 'success'}),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
