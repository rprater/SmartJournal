import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/entry.dart';
import 'package:flutter_app/screens/journal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Journal(),
      /*      debugShowCheckedModeBanner: false,
      navigatorKey: _navKey,
      initialRoute: Journal.routeName,
      theme: ThemeData(
          backgroundColor: Color(0xffe2e8f0)
      ),
      routes: {
        Entry.routeName: (context) => Entry(),
        Journal.routeName: (context) => Journal()
      },*/
    ); 
  }
}

