import 'package:flutter/material.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:flutter_icons/flutter_icons.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mySteps;
  var result;
  var steps;
  double st = 100.0;
  double cl;
  double ht;
  double wt;
  double heartrate;

  Future<void> read() async {
    bool permissions;
    int i = 0;
    int j = 0;
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    st = 0.0;
    cl = 0.0;
    ht = 0.0;
    wt = 0.0;

    try {
      permissions = await FitKit.requestPermissions(DataType.values);
      var arr = [DataType.STEP_COUNT, DataType.ENERGY];
      var results;
      // print(date);
      if (!permissions) {
        result = 'requestPermissions: failed';
      } else {
        for (i = 0; i < arr.length; i++) {
          if (arr[i].toString() == "DataType.STEP_COUNT") {
            results = await FitKit.read(DataType.STEP_COUNT,
                dateFrom: DateTime.parse(date.toString()),
                dateTo: DateTime.now());
            for (j = 0; j < results.length; j++) {
              st = results[j].value + st;
            }
          } else {
            results = await FitKit.read(DataType.ENERGY,
                dateFrom: DateTime.parse(date.toString()),
                dateTo: DateTime.now());
            for (j = 0; j < results.length; j++) {
              cl = results[j].value + cl;
            }
          }
        }
      }
    } catch (e) {
      result = 'readAll: $e';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            splashColor: Colors.amber[400],
            onPressed: () => read(),
            child: Icon(Icons.check)),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              
              Container(
                  height: 50,
                  color: Colors.amber[200],
                  child: Row(children: <Widget>[
                    Icon(Foundation.foot),
                    Text("Steps   $st")
                  ])),
              Container(
                height: 50,
                color: Colors.amber[200],
                child: Row(children: <Widget>[
                  Icon(MaterialCommunityIcons.fire),
                  Text("Calories   $cl")
                ]),
              ),
              Container(
                  height: 400.0,
                  child: CircularProgressIndicator(
                    value: st / 10000.0,
                    backgroundColor: Colors.white,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurple[900]),
                  ))
            ],
          ),
        ),
        // child: Text("steps        $st")
      ),
    );
  }
}
