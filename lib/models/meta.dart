class Meta {
  final int id;
  final String token;
  final String password;
  final int count;

  Meta({this.id, this.token, this.password, this.count});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'token': token,
      'password': password,
      'count': count,
    };
  }

  @override
  String toString() {
    return 'Meta{id: $id, token: $token, password: $password, count: $count}';
  }
}
