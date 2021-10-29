import 'dart:convert';

import 'package:consumo_servicios/datasource/network/network_utils.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {

  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String text= "";

  void _incrementCounter() {

    setState(() {
      //_testAddParameters();
      //_testAddPath();
      //_testCallGet();
      //_testCallDelete();
      _testCallPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$text',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _testAddParameters() {
    Map<String,dynamic> parameters = Map();
    parameters["nombre"] = "Sofia";
    parameters["apellido"] = "ramos";
    final String url = addParams(parameters: parameters, url: "${kBasePath}books");
    text = url;
  }

  void _testAddPath() {
    final String url = addPath(parameter: 1, url: "${kBasePath}book/$kPathKey");
    text = url;
  }
  
  Future<void> _testCallDelete() async {
    final Map<dynamic, dynamic> responseService = await callDelete(serviceUrl: "${kBasePath}books");
    final Map<dynamic, dynamic> data = responseService["data"];
    print("");
  }

  Future<void> _testCallGet() async {
    final Map<dynamic, dynamic> responseService = await callGet(serviceUrl: "${kBasePath}books");
    dynamic data;
    try{
      data = responseService["data"] as dynamic;
    } on Exception catch (e) {
      data = responseService["data"] as List<dynamic>;
    }
    text = data.toString();
  }

  Future<void> _testCallPost() async {
    final Map<dynamic, dynamic> responseService = await callPost(serviceUrl: kBasePath + "books/save");
    dynamic data;
    try{
      data = responseService["data"] as dynamic;
    } on Exception catch (e) {
      data = responseService["data"] as List<dynamic>;
    }
    text = data.toString();
  }


}
