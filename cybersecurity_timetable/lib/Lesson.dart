import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Lesson {
  //todo: add day?
  String nHour;
  String name;
  String start;
  String end;
  String abbreviazione;
  Color color;

  Lesson(this.nHour, this.name, this.start, this.end, this.abbreviazione, this.color);

  toMap() {
    return <String, dynamic> {
      "n_hour": nHour,
      "name": name,
      "start": start,
      "end": end,
      "abbreviazione": abbreviazione,
      "color": color.value
    };
  }


}