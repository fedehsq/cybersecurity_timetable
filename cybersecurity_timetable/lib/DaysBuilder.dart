import 'package:cybersecurity_timetable/HoursBuilder.dart';
import 'package:cybersecurity_timetable/Lesson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DaysBuilder extends StatelessWidget {
  final List<String> days = ["Lunedì", "Martedì", "Mercoledì", "Giovedì",
    "Venerdì", "Sabato"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Giorni')
      ),
      body: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: SvgPicture.asset(
                'images/schedule.svg'),
            ),
            ListView(
                children: [
                  for (var day in days)
                    ListTile(
                      leading: Icon(Icons.today),
                      title: Text(day),
                      trailing: Icon(Icons.chevron_right_outlined),
                      onTap: () => waitForLessonsInDay(context, day),
                    )
                ]),
          ]),
    );
  }

  waitForLessonsInDay(BuildContext context, String day) async {
    List<Lesson> lessons = await Navigator
        .push(context, MaterialPageRoute(
        builder: (BuildContext context) => HoursBuilder(day: day)
    ));
    print("coming back");
  }
}
