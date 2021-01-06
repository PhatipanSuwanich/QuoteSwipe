import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;

import 'quoteDao.dart';

class QuotesPage extends StatefulWidget {
  QuotesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  Future<QuotesDao> _randomQuotes() async {
    var url = "https://www.affirmations.dev/";
    var response = await Http.get(url);
    Map map = json.decode(response.body);
    QuotesDao msg = QuotesDao.fromJson(map);
    print("message = " + msg?.message);
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: _randomQuotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuotesDao msg = snapshot.data;
              return Text(msg.message);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //Re build
          });
        },
        tooltip: 'random',
        child: Icon(Icons.cached),
      ),
    );
  }
}
