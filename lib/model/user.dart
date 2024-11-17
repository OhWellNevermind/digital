const String tableUsers = 'users';

class UserFields {
  static const id = 'id';
  static const email = 'email';
  static const name = 'name';
  static const password = 'password';
  static const createdAt = 'created_at';
}

class User {
  final int? id;
  final String email;
  final String name;
  final String password;
  final String? createdAt;
  final String? token;

  User(
      {this.id,
      required this.email,
      required this.name,
      required this.password,
      this.createdAt,
      this.token});

  Map<String, dynamic> toMap() {
    return {
      UserFields.id: id,
      UserFields.email: email,
      UserFields.name: name,
      UserFields.password: password,
      UserFields.createdAt: createdAt,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map[UserFields.id] as int?,
      email: map[UserFields.email] as String,
      name: map[UserFields.name] as String,
      password: map[UserFields.password] as String,
      createdAt: map[UserFields.createdAt] as String?,
    );
  }

  User copyWith({
    int? id,
    String? email,
    String? name,
    String? password,
    String? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory User.fromGetUserJson(Map<String, dynamic> json) {
    final user = json['user'];

    return User(
      id: user['id'] as int,
      email: user['email'] as String,
      name: user['name'] as String,
      password: '',
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    final token = user['token'];

    return User(
      id: user['id'] as int,
      email: user['email'] as String,
      name: user['username'] as String,
      password: '',
      token: token as String,
    );
  }
}
