import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';

String days(int day){
  switch(day) {
    case 1: {
      return "poniedziałek";
    }
    case 2: {
      return "wtorek";
    }
    case 3: {
      return "środa";
    }
    case 4: {
      return "czwartek";
    }
    case 5:
      return "piątek";
    case 6:
      return "sobota";
    case 0:
      return "niedziela";
    default:
      return days(day%7);
  }

  return "kto wie";
}
List<TimePlannerTask> tasks = [];
int page=0;
void main() {
  runApp(MyApp());
}


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time planner Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Time planner'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addObject(BuildContext context) {
    List<Color?> colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.lime[600]
    ];

    setState(() {
      tasks.add(
        TimePlannerTask(
          color: colors[Random().nextInt(colors.length)],
          dateTime: TimePlannerDateTime(
              day: 0,
              hour: 0,
              minutes: Random().nextInt(60)),
          minutesDuration: Random().nextInt(90) + 30,
          daysDuration: 1,
          onTap: () {

            },
          child: Text(
            'this is a test',
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dodano zadanie!')));
  }



  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now().add(new Duration(days:page*7));
    var formatter = new DateFormat('dd/MM/yyyy');
    var day = now.weekday;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: TimePlanner(
          startHour: 1,
          endHour: 24,
          headers: [
            TimePlannerTitle(
              date: formatter.format(now),
              title: days(day),
            ),
            TimePlannerTitle(
              date: formatter.format(now.add(new Duration(days:1))),
              title: days(day+1),
            ),
          ],
          tasks: tasks,
          style: TimePlannerStyle(
            // cellHeight: 60,
            // cellWidth: 60,
              showScrollBar: true),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addObject(context),
        tooltip: 'Add random task',
        child: Icon(Icons.add),
      ),
    );
  }
}