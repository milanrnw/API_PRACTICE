
import 'package:api_practice/model/profile_name_model.dart';

class ProfileModel {
  final int id;
  final String email;
  final String username;
  final String password;
  final ProfileNameModel name;

  ProfileModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      name: ProfileNameModel.fromJson(json['name']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'username': username,
        'password': password,
        'name': name.toJson(),
      };
}
