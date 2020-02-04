import 'package:flutter/material.dart';
import 'package:fit_kit/fit_kit.dart';

void main() => runApp(MyApp());

void read() async{
    if(await FitKit.requestPermissions([DataType.SLEEP])){
    var results = await FitKit.read(DataType.SLEEP,dateFrom:DateTime.now().subtract(Duration(days:9)).toLocal(),dateTo: DateTime.now().subtract(Duration(days:8)).toLocal());
  //var r=await FitKit.read(DataType.STEP_COUNT,dateFrom:DateTime.now().subtract(Duration(days: 1)),dateTo:DateTime.now());
   print(results.toString());
  }
    else{
      print("request not granted");
    }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
       floatingActionButton: FloatingActionButton(onPressed:()=>read(),
       child: Icon(Icons.check)
       ),  
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