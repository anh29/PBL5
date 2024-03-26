import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class ApiService {
  Future<List<User>> fetchUsers({int page = 1}) async {
    final url = 'https://reqres.in/api/users?page=$page';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> usersData = jsonData['data'];

      return usersData
          .map((userData) => User(
                id: userData['id'],
                email: userData['email'],
                firstName: userData['first_name'],
                lastName: userData['last_name'],
                avatarUrl: userData['avatar'],
              ))
          .toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUserById({required int id}) async {
    final url = 'https://reqres.in/api/users/$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final user = User(
        id: jsonData['data']['id'],
        email: jsonData['data']['email'],
        firstName: jsonData['data']['first_name'],
        lastName: jsonData['data']['last_name'],
        avatarUrl: jsonData['data']['avatar'],
      );

      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
