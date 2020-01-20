import 'package:flutter/material.dart';
import 'package:github_tools/http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomeScreen> {
  Future<http.User> user;

  @override
  void initState() {
    super.initState();
    String url = 'https://api.github.com/user';
    user = http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Github Tools'),
        ),
        body: Center(
          child: FutureBuilder<http.User>(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.account);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      )
    );
  }
}