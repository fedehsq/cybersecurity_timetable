import 'package:cybersecurity_timetable/Lesson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gson/gson.dart';

// todo: controllare alla fine che le ore siano corrette => start < end e altro
class LessonBuilder extends StatefulWidget {
  final String day;

  const LessonBuilder({Key key, this.day}) : super(key: key);

  @override
  _LessonBuilderState createState() => _LessonBuilderState();
}

class _LessonBuilderState extends State<LessonBuilder> {
  String _abbreviazione = 'Abbreviazione';
  TextEditingController lessonController;
  TextEditingController acronimoController;
  Color _lessonColor;

  final List<String> _startStringHours = <String> ["08:00"];
  final List<String> _endStringHours = <String> ["09:00"];

  final List<int> _startHours = [8];
  final List<int> _endHours = [9];


  @override
  void initState() {
    lessonController = TextEditingController();
    acronimoController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    lessonController.dispose();
    acronimoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.day)
      ),
      body: ListView(
        children: [
          buildLessonName(),
          buildAcronimo(),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 8),
            child: Center(child: Text("Seleziona un colore per la materia")),
          ),
          buildLessonColor(),
          // "orario" - start - end
          buildTimeRows(context),
        ],
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Builder(
          builder: (context) => _buildButton("Salva", context),
        ),
      ) ,
    );
  }

  _buildButton(String text, BuildContext context) {
    return FlatButton(
        color: Colors.blue,
        onPressed: ()  {
          if (lessonController.text.isEmpty || _lessonColor == null) {
            final snackBar = SnackBar(content: Text('Dimentichi qualcosa...'));
            // Find the Scaffold in the widget tree and use it to show a SnackBar.
            Scaffold.of(context).showSnackBar(snackBar);
          } else {
            Gson gson = Gson();
            Lesson lesson = Lesson(widget.day, lessonController.text,
                gson.encoder.encode(_startStringHours),
                gson.encoder.encode(_endStringHours),
                _abbreviazione, _lessonColor);
            // The Yep button returns "Yep!" as the result.
            Navigator.pop(context, lesson);
          }
        },
        child: Text(text, style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
        )
    );
  }

   buildTimeRows(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: _startStringHours.length + 1,
      itemBuilder: (BuildContext context, int index) {
         return index == _startStringHours.length ?
         ListTile(
           leading: Icon(Icons.add),
           title: Text("Voce elenco"),
           onTap: () {
             addHour(context, _endHours[index - 1] + 1);
           },
         ) :
         Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // show "orario"
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text("Inizio:", style: TextStyle(fontSize: 16),),
            ),
            InkWell(
              onTap: () =>
              {
                modifyHour(context, "Inizio", _startHours[index], index)
              },
              child: Text(_startStringHours[index], style: TextStyle(fontSize: 24)),
            ),

            Spacer(),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text("Fine:", style: TextStyle(fontSize: 16),),
            ),
            InkWell(
              onTap: () =>
              {
                modifyHour(context, "Fine", _endHours[index], index)
              },
              child: Text(_endStringHours[index], style: TextStyle(fontSize: 24)),
            ),
            Spacer(),
          ],
        );
      },
    );
  }

  modifyHour(BuildContext context, String message, int hour, int i) async {
    final TimeOfDay newTime = await showTimePicker(
      helpText: message,
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: 00),
    );
    if (newTime != null) {
      setState(() {
        if (message == 'Inizio') {
          _startStringHours.removeAt(i);
          _startStringHours.insert(i, newTime.format(context));

          _startHours.removeAt(i);
          _startHours.insert(i, newTime.hour);
        } else {
          _endStringHours.removeAt(i);
          _endStringHours.insert(i, newTime.format(context));

          _endHours.removeAt(i);
          _endHours.insert(i, newTime.hour);
        }
      });
    }
  }

  addHour(BuildContext context, int hour) async {
    final TimeOfDay newTime = await showTimePicker(
      helpText: "Inizio",
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: 00),
    );
    if (newTime != null) {
      setState(() {
        _startStringHours.add(newTime.format(context));
        _endStringHours.add(
            newTime.replacing(hour: newTime.hour + 1).format(context));

        _startHours.add(newTime.hour);
        _endHours.add(newTime.hour + 1);
      });
    }
  }

  buildLessonName() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24),
      child: TextFormField(
          onChanged: (value) {
            setState(() {
              if (value.length <= 1) {
                setState(() {
                  _abbreviazione = "Abbreviazione";
                });
              } else {
                _abbreviazione = value.substring(0, 3).toUpperCase();
              }
            });
          },
          controller: lessonController,
          decoration: InputDecoration(
            errorText: lessonController.text.isEmpty ? '' : null,
            labelText: 'Materia',
          )
      ),
    );
  }

  buildAcronimo() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24),
      child: TextFormField(
          controller: acronimoController,
          decoration: InputDecoration(
              labelText: _abbreviazione,
              helperText: "Un'abbreviazione facilita la visualizzazione nella tabella"
          )
      ),
    );
  }


  buildLessonColor() {
    List<Container> colors = [
      Container(height: 32, width: 32, color: Colors.red),
      Container(height: 32, width: 32, color: Colors.blue),
      Container(height: 32, width: 32, color: Colors.green),
      Container(height: 32, width: 32, color: Colors.yellow),
      Container(height: 32, width: 32, color: Colors.orange),
      Container(height: 32, width: 32, color: Colors.pink),
      Container(height: 32, width: 32, color: Colors.purpleAccent),
      Container(height: 32, width: 32, color: Colors.tealAccent),
      Container(height: 32, width: 32, color: Colors.blueGrey),
      Container(height: 32, width: 32, color: Colors.brown),
    ];
    return GridView.builder(
      physics: ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 5),
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(child: colors[index].color == _lessonColor ?
          Stack(
              fit: StackFit.expand,
              children: [
                Opacity(opacity: 0.6, child: colors[index]),
                Icon(Icons.verified)
              ])
              : colors[index],
              onTap: () =>
              {
                setState(() {
                  _lessonColor = colors[index].color;
                })
              });
        }
    );
  }

  void startAndEndHour() async {
    final TimeOfDay start = await showTimePicker(
      helpText: "Inizio",
      context: context,
      initialTime: TimeOfDay(hour: 08, minute: 00),
    );
    int startH = start.hour;
    final TimeOfDay end = await showTimePicker(
      helpText: "Fine",
      context: context,
      initialTime: TimeOfDay(hour: startH + 1, minute: 00),
    );
    // check if hours are already chosen
    String s = start.format(context);
    String e = end.format(context);
    if (_startStringHours.contains(s)) {
      await _showMyDialog(s, 'inizio');
    } else if (_endStringHours.contains(e)) {
      await _showMyDialog(e, 'fine');
    } else {
      setState(() {
        _startStringHours.add(s);
        _endStringHours.add(e);
      });
    }
  }

  Future<void> _showMyDialog(String hour, String how) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Attenzione'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Hai già inserito $hour come ora di $how.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ho capito'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
