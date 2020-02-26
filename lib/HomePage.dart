import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List currencies;
  final List<MaterialColor> _colors = [Colors.green, Colors.blue, Colors.red];

//  @override
//  void initState() async{
//  super.initState();
//  currencies = await getCurrencies();
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CRYPTOCURRENCY"),
      ),

      body: _cryptocurrency(),
    );
  }

  Widget _cryptocurrency(){
    return Container(
      child: Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
                itemCount: widget.currencies.length,
                itemBuilder: (BuildContext context, int index){
                  final Map currency = widget.currencies[index];
                  final MaterialColor color = _colors[index % _colors.length];

                  return new Card(
                      child: _getListItemui(currency,color)
                  );
                },
              )
          ),
        ],
      ),
    );
  }


  ListTile _getListItemui(Map currency, MaterialColor color){
    return new ListTile(
      leading: new CircleAvatar(
        child: new Text(
            currency['name'][0]
        ),
      ),

      title: new Text(
        currency['name'],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(
        currency['price_usd'], currency['percent_change_1h'],
      ),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange){

    TextSpan priceTextWidget = new TextSpan(
      text: "\$$priceUSD\n", style: new TextStyle(color: Colors.black),
    );
    String percentageChangeText = "1 hour : $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));

      return new RichText(
        text: new TextSpan(
            children: [priceTextWidget, percentageChangeTextWidget]
        ),
      );

    } else {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: new TextStyle(color: Colors.red));

      return new RichText(
        text: new TextSpan(
          children: [priceTextWidget, percentageChangeTextWidget]
        ),
      );
    }
  }
}
