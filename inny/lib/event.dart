import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Event {
  final String title;
  DateTime czas_rozpoczecia;

  Event({@required this.title, @required this.czas_rozpoczecia});

  String toString() => DateFormat('kk:mm').format(czas_rozpoczecia)+" "+this.title;

}