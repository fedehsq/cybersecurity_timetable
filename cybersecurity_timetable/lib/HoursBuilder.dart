import 'package:cybersecurity_timetable/Lesson.dart';
import 'package:cybersecurity_timetable/LessonModifer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gson/gson.dart';

import 'Database.dart';
import 'LessonBuilder.dart';

// todo: controllare prima di tornare indietro che gli orari non si accavallino

class HoursBuilder extends StatefulWidget {
  final String day;

  const HoursBuilder({Key key, this.day}) : super(key: key);

  @override
  _HoursBuilderState createState() => _HoursBuilderState();
}

class _HoursBuilderState extends State<HoursBuilder> {

  final MyDatabase database = MyDatabase();

  // this screen hours
  final List<Lesson> lessons = <Lesson>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Orario di ${widget.day}")
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: SvgPicture.asset(
                'images/teaching.svg'),
            ),
            ListView.builder(
              itemCount: lessons.length + 1,
              itemBuilder: (context, index) {
                return index == lessons.length ?
                ListTile(
                  onTap: () => waitForHour(context, widget.day),
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
                  subtitle: Text(hoursFormat(lessons[index])),
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

  hoursFormat(Lesson lesson) {
    Gson gson = Gson();
    var starts = gson.decode(lesson.start);
    var ends = gson.decode(lesson.end);
    String formatted = '';
    for (int i = 0; i < starts.length; i++) {
      i % 2 == 0 ?
      formatted += starts[i] + " - " + ends[i] + "     " :
      formatted += starts[i] + " - " + ends[i] + " \n";
    }
    return formatted;
  }

  waitForHour(BuildContext context, String day) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Lesson lesson = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) =>
          LessonBuilder(day: day)),
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
