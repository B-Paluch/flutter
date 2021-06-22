import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Event {
  final String title;
  DateTime czas_rozpoczecia;
  DateTime czas_zakonczenia;
  Event({@required this.title, @required this.czas_rozpoczecia, @required this.czas_zakonczenia});

  String toString() => DateFormat('kk:mm').format(czas_rozpoczecia)+"-"+DateFormat('kk:mm').format(czas_zakonczenia)+this.title;

}