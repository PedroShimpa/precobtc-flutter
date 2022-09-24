import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _logo = AssetImage("images/logo.png");

  String _precoAtual = "";

  void _buscaPrecoBTC() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _precoAtual = retorno["BRL"]["buy"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    _buscaPrecoBTC();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image(image: _logo),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text('R\$ ' + _precoAtual, style: TextStyle(fontSize: 22)),
        ),
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: RaisedButton(
              child: Text("Atualizar",
                  style: TextStyle(fontSize: 25, color: Colors.white)),
              onPressed: _buscaPrecoBTC,
              color: Colors.orange,
            ))
      ])),
    );
  }
}
