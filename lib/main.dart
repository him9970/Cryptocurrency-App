import 'dart:convert';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:http/http.dart' as http;

void main() async{
  List currencies = await getCurrencies();
  print(currencies);
  runApp(new MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List _currencies;
  MyApp(this._currencies);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cryptocurrency APP",
      theme: new ThemeData(
        primarySwatch: Colors.amber,

      ),
      home: new HomePage(_currencies),
    );
  }
}

Future<List> getCurrencies() async{
  String url = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}