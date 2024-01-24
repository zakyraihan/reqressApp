import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reqress_app/model/list_model.dart';

class ApiService {
  Future<ReqresListResult> getUserList() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));
    if (response.statusCode == 200) {
      return ReqresListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to fetch user list');
    }
  }

  Future<Datum> createUser(String name, String email) async {
    const String apiUrl = 'https://reqres.in/api/users';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email}),
    );

    if (response.statusCode == 201) {
      print('Response: ${response.body}');
      final createUser = Datum.fromJson(json.decode(response.body));
      return createUser;
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
