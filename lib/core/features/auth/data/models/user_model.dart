
import 'package:clock_store_app/core/features/auth/domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  const UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  User toEntity() {
    return User(id: id, name: name, email: email);
  }
}
