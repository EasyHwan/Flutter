import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HelloPage(title: 'Hello World',)
    );
  }
}

class HelloPage extends StatefulWidget {
  const HelloPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  String _message= 'Hello World';
  int _counter=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:
          FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: _changeMessage),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_message,style:TextStyle(fontSize: 30)),
                Text('$_counter',style:TextStyle(fontSize: 30)),
              ],
            ))
    );
  }

  void _changeMessage() {
    setState(() {
      _message='헬로 월드';
      _counter++;
    });
  }
}




