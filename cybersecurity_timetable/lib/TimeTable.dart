import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeTable extends StatefulWidget {
  final SharedPreferences preferences;
  final double screenWidth;

  TimeTable({Key key, this.preferences,this.screenWidth})
      : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();

}

class _TimeTableState extends State<TimeTable> {
  bool showHES;
  bool showLBT;
  bool showOSI;
  bool showCRY;

  @override
  void initState() {
    super.initState();
    showHES = widget.preferences.getBool('HES') ?? true;
    showLBT = widget.preferences.getBool('LBT') ?? true;
    showOSI = widget.preferences.getBool('OSI') ?? true;
    showCRY = widget.preferences.getBool('CRY') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cybersecurity timetable'),
      ),
      body: InteractiveViewer(
        minScale: 0.1,
        maxScale: 1.6,
        child: Column(
          children: [
            getRowLegend('HES = Hardware and Embedded Security', Colors.red),
            getRowLegend('LBT = Language Based Technology', Colors.yellow),
            getRowLegend('OSI = Organ. Science Inf. and Tech. Law', Colors.blue),
            getRowLegend('CRY = Applied Cryptography', Colors.green),
            getTitle(),
            Table(
              columnWidths: {0: FractionColumnWidth(.21)},
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(children: daysRow()),
                TableRow(children: firstRow()),
                TableRow(children: secondRow()),
                TableRow(children: thirdRow()),
                TableRow(children: fourthRow()),
                TableRow(children: fifthRow()),
                TableRow(children: sixthRow()),
                TableRow(children: seventhRow()),
                TableRow(children: eighthRow()),
                TableRow(children: ninthRow()),
                TableRow(children: tenthRow()),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Center getTitle() {
    return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('2M Cybersecurity',
              style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        );
  }

  Padding getRowLegend(String s, Color color) {
    return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s, style: TextStyle(fontSize: widget.screenWidth / 25),),
              SizedBox(
                height: 40,
                child: Switch(
                  activeColor: color,
                    value: s.startsWith('HES') ? showHES :
                        s.startsWith('LBT') ? showLBT :
                        s.startsWith('OSI') ? showOSI : showCRY,
                  onChanged: (bool newValue) {
                    setState(() {
                      if (s.startsWith('HES')) {
                        showHES = newValue;
                        widget.preferences.setBool('HES', newValue);
                      } else if (s.startsWith('LBT')) {
                        showLBT = newValue;
                        widget.preferences.setBool('LBT', newValue);
                      } else if (s.startsWith('OSI')) {
                        showOSI = newValue;
                        widget.preferences.setBool('OSI', newValue);
                      } else {
                        showCRY = newValue;
                        widget.preferences.setBool('CRY', newValue);
                      }
                    });
                  },
                ),
              )
            ],
          ),
        );
  }

  daysRow() {
    return <Widget>[
      Text(''),
      dayView('Lu'),
      dayView('Ma'),
      dayView('Me'),
      dayView('Gi'),
      dayView('Ve'),
    ];
  }

  Padding dayView(String day) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
          child: Text(day,
              style: TextStyle(
                  fontWeight: FontWeight.bold)
          )
      ),
    );
  }

  getColoredContainer(String text, Color color) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Center(child: Text(text)),
      ),
    );
  }

  hardwareAndEmbeddedSecurityView() {
    return showHES ? getColoredContainer('HES', Colors.red) :
    getColoredContainer('', null);
  }

  Container languageBasedTechnologyView() {
    return showLBT ? getColoredContainer('LBT', Colors.yellow) :
    getColoredContainer('', null);
  }

  Container organScienceInfAndTechLawView() {
    return showOSI ? getColoredContainer('OSI', Colors.blue) :
    getColoredContainer('', null);
  }

  Container cryptographyView() {
    return showCRY ? getColoredContainer('CRY', Colors.green) :
    getColoredContainer('', null);
  }

  firstRow() {
    return <Widget>[
      hourView('8:30/9:30'),
      languageBasedTechnologyView(),
      hardwareAndEmbeddedSecurityView(),
      languageBasedTechnologyView(),
      Text(''),
      languageBasedTechnologyView(),
    ];
  }

  secondRow() {
    return <Widget>[
      hourView('9:30/10:30'),
      languageBasedTechnologyView(),
      hardwareAndEmbeddedSecurityView(),
      languageBasedTechnologyView(),
      organScienceInfAndTechLawView(),
      languageBasedTechnologyView(),
    ];
  }

  thirdRow() {
    return <Widget>[
      hourView('10:30/11:30'),
      Text(''),
      hardwareAndEmbeddedSecurityView(),
      cryptographyView(),
      organScienceInfAndTechLawView(),
      Text(''),
    ];
  }

  fourthRow() {
    return <Widget>[
      hourView('11:30/12:30'),
      Text(''),
      Text(''),
      cryptographyView(),
      Text(''),
      Text(''),
    ];
  }

  fifthRow() {
    return <Widget>[
      hourView('12:30/13:30'),
      Text(''),
      Text(''),
      cryptographyView(),
      Text(''),
      Text(''),
    ];
  }

  sixthRow() {
    return <Widget>[
      hourView('13:30/14:30'),
      cryptographyView(),
      Text(''),
      Text(''),
      Text(''),
      Text(''),
    ];
  }

  seventhRow() {
    return <Widget>[
      hourView('14:30/15:30'),
      cryptographyView(),
      Text(''),
      organScienceInfAndTechLawView(),
      Text(''),
      Text(''),
    ];
  }

  eighthRow() {
    return <Widget>[
      hourView('15:30/16:30'),
      cryptographyView(),
      Text(''),
      organScienceInfAndTechLawView(),
      Text(''),
      hardwareAndEmbeddedSecurityView()
    ];
  }

  ninthRow() {
    return <Widget>[
      hourView('16:30/17:30'),
      Text(''),
      Text(''),
      Text(''),
      Text(''),
      hardwareAndEmbeddedSecurityView()
    ];
  }

  tenthRow() {
    return <Widget>[
      hourView('17:30/18:30'),
      Text(''),
      Text(''),
      Text(''),
      Text(''),
      hardwareAndEmbeddedSecurityView()
    ];
  }

  hourView(String s) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Center(child: Text(s, style: TextStyle(fontWeight: FontWeight.bold),)),
    );
  }
}
