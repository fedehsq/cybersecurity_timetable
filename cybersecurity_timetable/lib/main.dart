import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TablePage()
    );
  }
}

class TablePage extends StatefulWidget {
  TablePage({Key key}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Cybersecurity timetable'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('2M Cybersecurity', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Table(
            columnWidths: {0: FractionColumnWidth(.2)},
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
      // This trailing comma makes auto-formatting nicer for build methods.
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

  firstRow() {
    return <Widget>[
      Center(child: Text('8:30/9:30')),
      languageBasedTechnologyView(),
      hardwareAndEmbeddedSecurityView(),
      languageBasedTechnologyView(),
      Text(''),
      languageBasedTechnologyView(),
    ];
  }

  secondRow() {
    return <Widget>[
      Center(child: Text('9:30/10:30')),
      languageBasedTechnologyView(),
      hardwareAndEmbeddedSecurityView(),
      languageBasedTechnologyView(),
      organScienceInfAndTechLawView(),
      languageBasedTechnologyView(),
    ];
  }

  thirdRow() {
    return <Widget> [
      Text('10:30/11:30'),
      Text(''),
      hardwareAndEmbeddedSecurityView(),
      cryptographyView(),
      organScienceInfAndTechLawView(),
      Text(''),
    ];

  }

  fourthRow() {
    return <Widget> [
      Text('11:30/12:30'),
      Text(''),
      Text(''),
      cryptographyView(),
      Text(''),
      Text(''),
    ];
  }

  fifthRow() {
    return <Widget> [
      Text('12:30/13:30'),
      Text(''),
      Text(''),
      cryptographyView(),
      Text(''),
      Text(''),
    ];
  }

  sixthRow() {
    return <Widget> [
      Text('13:30/14:30'),
      cryptographyView(),
      Text(''),
      Text(''),
      Text(''),
      Text(''),
    ];
  }

  seventhRow() {
    return <Widget> [
      Text('14:30/15:30'),
      cryptographyView(),
      Text(''),
      organScienceInfAndTechLawView(),
      Text(''),
      Text(''),
    ];
  }

  eighthRow() {
    return <Widget> [
      Text('15:30/16:30'),
      cryptographyView(),
      Text(''),
      organScienceInfAndTechLawView(),
      Text(''),
      hardwareAndEmbeddedSecurityView()
    ];
  }

  ninthRow() {
    return <Widget> [
      Text('16:30/17:30'),
      Text(''),
      Text(''),
      Text(''),
      Text(''),
      hardwareAndEmbeddedSecurityView()
    ];
  }

  tenthRow() {
    return <Widget> [
      Text('17:30/18:30'),
      Text(''),
      Text(''),
      Text(''),
      Text(''),
      hardwareAndEmbeddedSecurityView()
    ];
  }




  Container hardwareAndEmbeddedSecurityView() {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text('HES')),
      ),
    );
  }

  Container languageBasedTechnologyView() {
    return Container(
      color: Colors.yellow,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text('LBT')),
      ),
    );
  }

  Container organScienceInfAndTechLawView() {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text('OSI')),
      ),
    );
  }


  cryptographyView() {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text('CRY')),
      ),
    );
  }


}
