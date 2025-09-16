import 'package:equatable/equatable.dart';

/// User Entity
/// 
/// Represents a user in the application
class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
    this.preferences = const {},
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String email;
  final String name;
  final String? avatar;
  final Map<String, dynamic> preferences;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? avatar,
    Map<String, dynamic>? preferences,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      preferences: preferences ?? this.preferences,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        avatar,
        preferences,
        createdAt,
        updatedAt,
      ];
}
