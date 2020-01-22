import 'package:flutter/material.dart';
import 'package:github_tools/http/http.dart' as http;
import 'package:github_tools/db/sqlite.dart' as sqlite;
import 'package:github_tools/models/meta.dart';
import 'package:github_tools/utils/random.dart' as random;

class HomeScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomeScreen> {
  Future<http.User> user;
  String token = '';

  @override
  void initState() {
    super.initState();
    
  }

  void callApi() {
    String url = 'https://api.github.com/user';
    user = http.get(url);
  }

  void insertData() {
    Meta meta = Meta(
      id: 1,
      token: 'test',
      password: 'password',
      count: 1,
    );
    sqlite.insertMeta(meta);
  }

  void selectData() {
    Future<List<Meta>> metas = sqlite.metas();

    metas.then((meta) => this.token = meta[0].token);
  }

  void updateData() async {
    List<Meta> metas = await sqlite.metas();

    Meta meta = Meta(
      id: 1,
      token: random.randomString(10),
      password: random.randomString(12),
      count: 1,
    );
    
    sqlite.updateMeta(meta);

    metas = await sqlite.metas();

    setState(() {
      this.token = metas[0].token;
    });
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
          // For HTTP Request Block

          // child: FutureBuilder<http.User>(
          //   future: user,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return Text(snapshot.data.account);
          //     } else if (snapshot.hasError) {
          //       return Text("${snapshot.error}");
          //     }

          //     // By default, show a loading spinner.
          //     return CircularProgressIndicator();
          //   },
          // ),


          // For SQLite Block
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$token',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: updateData,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      )
    );
  }
}