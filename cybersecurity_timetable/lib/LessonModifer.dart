import 'package:cybersecurity_timetable/Lesson.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LessonModifier extends StatefulWidget {
  final Lesson lesson;

  const LessonModifier({Key key, this.lesson}) : super(key: key);

  @override
  _LessonModifierState createState() => _LessonModifierState();
}

class _LessonModifierState extends State<LessonModifier> {

  TextEditingController lessonController;
  TextEditingController acronimoController;

  @override
  void initState() {
    lessonController = TextEditingController();
    lessonController.text = widget.lesson.name;
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
          title: Text(widget.lesson.nHour)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // "orario" - start - end
            buildTimeRow(context),
            buildLessonName(),
            buildAcronimo(),
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 8),
              child: Text("Seleziona un colore per la materia"),
            ),
            buildLessonColor()
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Builder(
          builder: (context) => _buildButton("Salva", context),
        ),
      ) ,
    );
  }

  /// builg login button
  _buildButton(String text, BuildContext context) {
    return FlatButton(
        color: Colors.blue,
        onPressed: ()  {
          if (lessonController.text.isEmpty) {
            final snackBar = SnackBar(content: Text('Dimentichi qualcosa...'));
            // Find the Scaffold in the widget tree and use it to show a SnackBar.
            Scaffold.of(context).showSnackBar(snackBar);
          } else {
            Lesson lesson = Lesson(widget.lesson.nHour,
                lessonController.text, widget.lesson.start,
                widget.lesson.end, widget.lesson.abbreviazione,
                widget.lesson.color);
            // The Yep button returns "Yep!" as the result.
            Navigator.pop(context, lesson);
          }
        },
        child: Text(text, style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
        )
    );
  }

  Row buildTimeRow(BuildContext context) {
    return Row(
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
            timePicker(context, "Inizio " + widget.lesson.nHour.toLowerCase())
          },
          child: Text(widget.lesson.start, style: TextStyle(fontSize: 24)),
        ),

        Spacer(),

        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text("Fine:", style: TextStyle(fontSize: 16),),
        ),
        InkWell(
          onTap: () =>
          {
            timePicker(context, "Fine " + widget.lesson.nHour.toLowerCase())
          },
          child: Text(widget.lesson.end, style: TextStyle(fontSize: 24)),
        ),
        Spacer(),
      ],
    );
  }


  timePicker(BuildContext context, String message) async {
    final TimeOfDay newTime = await showTimePicker(
      helpText: message,
      context: context,
      initialTime: TimeOfDay(hour: 08, minute: 00),
    );
    setState(() {
      message.startsWith("Inizio") ?
      widget.lesson.start = newTime.format(context) : widget.lesson.end =
          newTime.format(context);
    });
  }

  buildLessonName() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24),
      child: TextFormField(
          onChanged: (value) {
            setState(() {
              if (value.length <= 1) {
                setState(() {
                  widget.lesson.abbreviazione = "Abbreviazione";
                });
              } else {
                widget.lesson.abbreviazione = value.substring(0, 3).toUpperCase();
              }
            });
          },
          controller: lessonController,
          decoration: InputDecoration(
            errorText: lessonController.text.isEmpty ? '' : null,
            labelText: "Materia",
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
              labelText: widget.lesson.abbreviazione,
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
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 5),
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(child: colors[index].color == widget.lesson.color ?
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
                  widget.lesson.color = colors[index].color;
                })
              });
        }
    );
  }
}
