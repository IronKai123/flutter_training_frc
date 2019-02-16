import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(


        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder> {
        SecondRoute.routeName: (context) => new SecondRoute()
    },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // ignore: non_constant_identifier_names

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String testString;
  @override
  void initState() {
    getNamePreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Example Home Page'),
      ),
      body: SingleChildScrollView(
        child: new Center(

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.


          child: Container (
              child: Column(
                children: <Widget>[
                  Image.asset(
                      'images/download (14).jpg'
                  ),
                  Text(
                      'This image represents Monarchist Germany under the Hohenzollern Dynasty'
                  ),
                  RaisedButton(
                    child: Text('Open Route'),
                    onPressed: () {
                      saveName (

                      );

                    },
                  ),
                  TextField(
                      controller: returnTest(),
                      keyboardType:  TextInputType.multiline,
                      onChanged:(String value){
                        testString = value;
                      },


                      maxLines: 10,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Please write something because I am lonely....'
                      ),

                  ),

                ],
              )
          ),

          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      )
    );
  }

  returnTest(){
    if(testString != null){
      return TextEditingController(text: "$testString");
    } else if(testString == null){
      return TextEditingController(text: null);
    }
  }

  void saveName() {
    String name = testString;
    saveNamePreference(name).then((bool committed) {
      Navigator.of(context).pushNamed(SecondRoute.routeName);
    });
  }

  Future<String> getNamePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name");
    testString = name;
    return name;
  }
}

Future<bool> saveNamePreference(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name", name);

  return prefs.commit();
}

Future<String> getNamePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name");



  return name;
}

class SecondRoute extends StatefulWidget {
  static String routeName = "/nextPage";

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  String _name = "";

  @override
  void initState() {
  getNamePreference().then(updateName);
super.initState();
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Example Second Page'),
        ),
        body: SingleChildScrollView(
          child: new Center(

            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.


            child: Container (
                child: Column(
                  children: <Widget>[
                    Image.asset(
                        'images/download (14).jpg'
                    ),
                    Text(
                        _name
                    ),
                    RaisedButton(
                      child: Text('Frick, go back'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextField(
                      keyboardType:  TextInputType.multiline,
                      maxLines: 10,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Please write something because I am lonely....'
                      ),

                    ),

                  ],
                )
            ),

            // This trailing comma makes auto-formatting nicer for build methods.
          ),
        )
    );

  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }
}
