import 'package:flutter/material.dart';
import 'package:fit_kit/fit_kit.dart';

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

  Future<void> read() async {
    bool permissions;
    int st = 0;
    int i;
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    // permissions = await FitKit.requestPermissions(DataType.values);

    // // await FitKit.requestPermissions([DataType.STEP_COUNT])
    // if (permissions) {
    //   // var results = await FitKit.read(DataType.SLEEP,
    //   //     dateFrom: DateTime.now().subtract(Duration(days: 9)).toLocal(),
    //   //     dateTo: DateTime.now().subtract(Duration(days: 8)).toLocal())
    //   var results = await FitKit.read(DataType.STEP_COUNT,
    //       dateFrom: DateTime.now().subtract(Duration(days: 1)),
    //       dateTo: DateTime.now());

    //   print(results.toString());
    //   mySteps = results.toString();
    // } else {
    //   print("request not granted");
    // }

    try {
      permissions = await FitKit.requestPermissions(DataType.values);
      print(date);
      if (!permissions) {
        result = 'requestPermissions: failed';
      } else {
        var results = await FitKit.read(DataType.STEP_COUNT,
            dateFrom: DateTime.parse(date.toString()), dateTo: DateTime.now());

        result = 'readAll: success';
        // steps = results;
        print(results.length);
        // print(results);
        for (i = 0; i < results.length; i++) {
          st = st + results[i].value;
        }
        // print(i);
        // print(results[50].value);
        // print(results);
        print(st);
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
            onPressed: () => read(), child: Icon(Icons.check)),
        body: Center(child: Text("steps")),
      ),
    );
  }
}

/*Future<void> read() async {
    results.clear();

    try {
      permissions = await FitKit.requestPermissions(DataType.values);
      if (!permissions) {
        result = 'requestPermissions: failed';
      } else {
        for (DataType type in DataType.values) {
          results[type] = await FitKit.read(
            type,
            dateFrom: _dateFrom,
            dateTo: _dateTo,
            limit: _limit,
          );
        }

        result = 'readAll: success';
      }
    } catch (e) {
      result = 'readAll: $e';
    }

    setState(() {});
  }*/
/*void readAll() async {
  
  bool permissions;
  try {
      permissions = await FitKit.requestPermissions(DataType.values);
      if (!permissions) {
        print( 'requestPermissions: failed');
      } else {
        for (DataType type in DataType.values) {
          print( await FitKit.read(
            type,
            dateFrom:DateTime.now().subtract(Duration(days:1)),dateTo: DateTime.now()
          ).toString());
        }

        print( 'readAll: success');
      }
    } catch (e) {
      print('readAll: $e');
    }
*/

/*if (await FitKit.requestPermissions([DataType.STEP_COUNT])) {
    for (DataType type in DataType.values) {
      final results = await FitKit.read(
        type,
        dateFrom: DateTime.now().subtract(Duration(days: 5)),
        dateTo: DateTime.now(),
      );
    }
    //print(results.);
    }*/
