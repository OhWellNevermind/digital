import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lab1/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User> loginUser(String email, String password) async {
  Map data = {'email': email, "password": password};

  final response = await http.post(
    Uri.parse('http://192.168.200.46:3000/api/v1/auth/login'),
    body: json.encode(data),
    headers: {"Content-Type": "application/json"},
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception(jsonDecode(response.body)["message"]);
  }
}

Future<User> registerUser(String email, String password, String name) async {
  Map data = {'email': email, "password": password, "username": name};
  print(data);

  final response = await http.post(
    Uri.parse('http://192.168.200.46:3000/api/v1/auth/register'),
    body: json.encode(data),
    headers: {"Content-Type": "application/json"},
  );

  print(response);

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception(jsonDecode(response.body)["details"]["message"]);
  }
}

Future<User> getUserById(int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final response = await http.get(
    Uri.parse('http://192.168.200.46:3000/api/v1/user/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  print(jsonDecode(response.body));
  if (response.statusCode == 200) {
    return User.fromGetUserJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception(jsonDecode(response.body)["details"]["message"]);
  }
}
