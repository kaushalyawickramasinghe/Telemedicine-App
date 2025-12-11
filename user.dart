class User {
  final String id;
  final String name;
  final String email;
  final String role;

  User({required this.id, required this.name, required this.email, required this.role});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        role: json['role'] ?? 'patient',
      );
}

import 'package:flutter/foundation.dart';
import 'user.dart';

class UserModel extends ChangeNotifier {
  User? _user;
  String? _token; // simple in-memory token; use secure storage in production

  User? get user => _user;
  String? get token => _token;

  bool get isAuthenticated => _user != null && _token != null;

  void setUser(User user, String token) {
    _user = user;
    _token = token;
    notifyListeners();
  }

  void clear() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}