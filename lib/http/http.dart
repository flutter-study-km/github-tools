import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<User> get(String url) async {
  final response = await http.get(
    url,
    headers: {HttpHeaders.authorizationHeader: "token xxxxxxxxxxxxxxxxxxxxxxxxxxxx"},
  );

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to request to Github');
  }
}

class User {
  final String account;
  final int id;
  final String url;
  final String htmlUrl;
  final String name;

  User({
    this.account,
    this.id,
    this.url,
    this.htmlUrl,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      account: json['login'],
      id: json['id'],
      url: json['url'],
      htmlUrl: json['html_url'],
      name: json['name'],
    );
  }
}