import 'package:cybersecurity_timetable/Lesson.dart';
import 'package:cybersecurity_timetable/LessonModifer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Database.dart';
import 'LessonBuilder.dart';

class HoursBuilder extends StatefulWidget {
  @override
  _HoursBuilderState createState() => _HoursBuilderState();
}

class _HoursBuilderState extends State<HoursBuilder> {

  final MyDatabase database = MyDatabase();

  final List<String> startHours = <String> [
    "08:00", "09:00", "10:00", "11:00", "12:00",
    "13:00", "14:00", "15:00", "16:00", "17:00", "18:00",
  ];

  final List<String> endHours = <String> [
    "09:00", "10:00", "11:00", "12:00", "13:00",
    "14:00", "15:00", "16:00", "17:00", "18:00", "19:00"
  ];


  final List<String> nHours = <String> [
    "Prima ora", "Seconda ora", "Terza ora", "Quarta ora", "Quinta ora",
    "Sesta ora", "Settima ora", "Ottava ora", "Nona ora", "Decima ora",
    "Undicsesima ora"
  ];

  // this screen hours
  final List<Lesson> lessons = <Lesson>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Costruisci l'orario")
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: SvgPicture.asset(
                'images/teaching.svg',),
            ),
            ListView.builder(
              itemCount: lessons.length + 1,
              itemBuilder: (context, index) {
                return index == lessons.length ?
                ListTile(
                  onTap: () => waitForHour(context, nHours[index],
                      startHours[index], endHours[index]),
                  leading: Icon(Icons.add),
                  title: Text("Voce elenco")
                ) :
                ListTile(
                  onTap: () async =>
                      modifyHour(index, context),
                  trailing: Container(
                    color: lessons[index].color,
                    height: 24,
                    width: 24,
                    child: Icon(Icons.chevron_right_outlined),
                  ),
                  leading: Icon(Icons.access_time_outlined),
                  title: Text(lessons[index].name),
                  subtitle: Text(lessons[index].start + " - " + lessons[index].end),
                );

               // hours[index];
              },
            ),
          ],
        ),
      floatingActionButton: FlatButton(
        color: Colors.blue,
        child: Text("TERMINA"),
        onPressed: () async {
          await database.runDatabase();
          database.insertLessons(lessons);
        },
      ),
    );
  }

  waitForHour(BuildContext context, String hour, String start, String end) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Lesson lesson = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) =>
          LessonBuilder(nHour: hour, start: start, end: end)),
    );
    if (lesson != null) {
      setState(() {
        lessons.add(lesson);
      });
    }
  }

  modifyHour(int index, BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Lesson modifyLesson = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => LessonModifier(lesson: lessons[index])),
    );
    if (modifyLesson != null) {
      setState(() {
        lessons.removeAt(index);
        lessons.insert(index, modifyLesson);
      });
    }
  }
}
