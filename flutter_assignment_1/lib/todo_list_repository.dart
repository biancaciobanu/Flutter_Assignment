import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoRepository {
  Future<List<dynamic>> fetchTodoList() async {
    try {
      final response =
          await http.get(Uri.https('jsonplaceholder.typicode.com', '/todos'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch todo list');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
