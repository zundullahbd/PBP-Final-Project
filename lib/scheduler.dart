import 'package:flutter/material.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:date_field/date_field.dart';
import 'dart:convert';
import './models/event.dart';

List<List<Event>> daftarEvent = [];
void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Django',
      initialRoute: '/',
      routes: {
        '/': (context) => Scheduler(),
      },
    );
  }
}

class Scheduler extends StatelessWidget {
  const Scheduler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(child: MyHomePage(), alignment: Alignment.topCenter),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddForm()));
            // Add your onPressed code here!
          },
        ),
      ),
    );
    //return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      NavApp(
        current: "Scheduler",
        currContext: context,
      ),
      DataTable(columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Nama',
          ),
        ),
        DataColumn(
          label: Text(
            'Tanggal',
          ),
        ),
        DataColumn(
          label: Text(
            'Description',
          ),
        ),
      ], rows: <DataRow>[
        // DataRow(
        //   cells: <DataCell>[
        //     DataCell(Text(daftarEvent[0][0].toString())),
        //     DataCell(Text(daftarEvent[0][1].toString())),
        //     DataCell(Text(daftarEvent[0][2].toString()), showEditIcon: true),
        //   ],
        // )

        DataRow(
          cells: <DataCell>[
            DataCell(Text('Kumpul Tugas PBP')),
            DataCell(Text('18, November')),
            DataCell(Text('kumpulin di git'), showEditIcon: true),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('MPPI E Dedline')),
            DataCell(Text('26, November')),
            DataCell(Text('kerjain woi'), showEditIcon: true),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Quiz OS')),
            DataCell(Text('22, November')),
            DataCell(Text('Belajar woi'), showEditIcon: true),
          ],
        ),
      ]),
    ]);
  }
}

class AddForm extends StatefulWidget {
  AddForm({Key? key}) : super(key: key);

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
            child: Column(children: <Widget>[
          NavApp(
            current: "AddForm",
            currContext: context,
          ),
          TextField(
              decoration: InputDecoration(
                  hintText: "Nama event", labelText: "Nama Event")),
          DateTimeField(
              decoration: const InputDecoration(
                  hintText: 'Please select your birthday date and time'),
              selectedDate: selectedDate,
              onDateSelected: (DateTime value) {
                setState(() {
                  selectedDate = value;
                });
              }),
          TextField(
              decoration:
                  InputDecoration(hintText: "", labelText: "Description"))
        ])),
      ],
    ));
  }
}

Future<List<List<Event>>> getEvent() async {
  var url = "http://127.0.0.1:8000/EventApp/eventdetails?format=json";
  var result = await http.get(Uri.parse(url));
  var jsonObj = json.decode(result.body);

  List<dynamic> jsonObjList = jsonObj as List<dynamic>;

  List<List<Event>> events =
      []; //[[nama, waktu, deskripsi], [nama, waktu, deskripsi]]

  for (int i = 0; i < jsonObjList.length; i++) {
    events.add([
      Event.fromJson(jsonObjList[i]["Name"]),
      Event.fromJson(jsonObjList[i]["Time"]),
      Event.fromJson(jsonObjList[i]["Description"])
    ]);
  }
  daftarEvent = events;
  return events;
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: DataTable(
//           columns: const <DataColumn>[
//             DataColumn(
//               label: Text(
//                 'Nama',
//               ),
//             ),
//             DataColumn(
//               label: Text(
//                 'Tanggal',
//               ),
//             ),
//             DataColumn(
//               label: Text(
//                 'Description',
//               ),
//             ),
//           ],
//           rows: const <DataRow>[
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('Kumpul Tugas PBP')),
//                 DataCell(Text('18, November')),
//                 DataCell(Text('kumpulin di git'), showEditIcon: true),
//               ],
//             ),
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('MPPI E Dedline')),
//                 DataCell(Text('26, November')),
//                 DataCell(Text('kerjain woi'), showEditIcon: true),
//               ],
//             ),
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('Quiz OS')),
//                 DataCell(Text('22, November')),
//                 DataCell(Text('Belajar woi'), showEditIcon: true),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
