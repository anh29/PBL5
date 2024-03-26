import 'package:first_app/models/user.dart';

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatarUrl;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
  });
}
