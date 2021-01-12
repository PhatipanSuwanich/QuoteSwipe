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
  bool loading = true;
  Size screenSize;
  IconData _icon_emoticon;

  Future<QuotesDao> _randomQuotes() async {
    var url = "https://www.affirmations.dev/";
    var response = await Http.get(url);
    Map map = json.decode(response.body);
    QuotesDao msg = QuotesDao.fromJson(map);
    print("message = " + msg?.message);
    loading = false;
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: _randomQuotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return cardQuote(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget cardQuote(QuotesDao quote) {
    return Card(
      color: Colors.transparent,
      elevation: 4.0,
      child: Container(
        width: screenSize.width / 1.2,
        height: screenSize.height / 1.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: loading
            ? Icon(_icon_emoticon, color: Colors.pink, size: 100.0)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(quote.message, textAlign: TextAlign.center),
                  Container(
                      width: screenSize.width / 1.2,
                      height: screenSize.height / 1.5 - screenSize.height / 2.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text("NOPE"),
                            onPressed: () {
                              if (!loading) {
                                setState(() {
                                  _icon_emoticon = Icons.sentiment_dissatisfied;
                                  loading = true;
                                });
                              }
                            },
                          ),
                          new RaisedButton(
                            child: Text("LIKE"),
                            onPressed: () {
                              if (!loading) {
                                setState(() {
                                  _icon_emoticon =
                                      Icons.sentiment_very_satisfied;
                                  loading = true;
                                });
                              }
                            },
                          ),
                        ],
                      ))
                ],
              ),
      ),
    );
  }
}
