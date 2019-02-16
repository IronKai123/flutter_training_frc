import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red
      ),

      title: 'Assets',
      home: new Scaffold (

          appBar: AppBar(
              title: Text ('Image Test'),
      ),

          body: new Center(child: (Image.asset('images/download (14).jpg'))),



      ),
    );
  }
}



