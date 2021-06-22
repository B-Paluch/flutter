import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:moor/moor.dart' as m;
//import 'event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'utils.dart';
import 'database.dart';
MyDatabase database;
void main() {
  database = MyDatabase();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kalendarz Flutter",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Calendar(),
    );
  }
}
final des=database.getAllAppointments();

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  ValueNotifier<List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDay = focusedDay;
    selectedEvents = ValueNotifier(_getEventsfromDay(selectedDay));
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return kEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalendarz Flutter"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'pl_PL',
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              selectedEvents.value = _getEventsfromDay(selectedDay);
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: new FutureBuilder<List<Appointment>>(
            future: database.getAllAppointments(),
            builder: (context, value) {
              return ListView.builder(
              itemCount:value.data.length,
              itemBuilder: (context, index) {
                //if(value.hasData&&(value.data[index].czas.compareTo(selectedDay))!=0)
              return Container(
              margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0,
              ),
              decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
              onTap: () {
              database.deleteAppointment(selectedDay, '${value.data[index].title}');
              kEvents[selectedDay].removeWhere((item) => item.title =='${value.data[index].title}');
              //print(kEvents[selectedDay]);
              //print('${value[index]}');
              //kEvents[selectedDay].remove();
              },
              title: Text('${value.data[index].title} '+'${value.data[index].czas.year}-'+'${value.data[index].czas.month}-'+'${value.data[index].czas.day} '),
              ),
              );
              },
              );
              }


/*            child: ValueListenableBuilder<List<Event>>(
              valueListenable: selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          database.deleteAppointment(selectedDay, '${value[index]}');
                          kEvents[selectedDay].removeWhere((item) => item.title =='${value[index]}');
                          //print(kEvents[selectedDay]);
                          //print('${value[index]}');
                          //kEvents[selectedDay].remove();
                          },
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),*/
          )
          /*..._getEventsfromDay(selectedDay).map(
                (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          )*/,
          )],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Dodaj wydarzenie"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("anuluj"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {

                  } else {
                    database.addAppointment(AppointmentsCompanion(czas: m.Value(selectedDay),title:m.Value(_eventController.text)));
                    if (kEvents[selectedDay] != null) {
                      kEvents[selectedDay].add(
                        Event(_eventController.text),
                      );
                    } else {
                      kEvents[selectedDay] = [
                        Event(_eventController.text)
                      ];
                    }

                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState((){});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("dodaj wydarzenie"),
        icon: Icon(Icons.add),
      ),
    );
  }
}