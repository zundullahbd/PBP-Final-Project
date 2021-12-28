import 'package:flutter/material.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CovidData());
}

Color c = const Color(0xFF5F9EA0);

class CovidData extends StatelessWidget {
  const CovidData({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Covid-19 Data',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     colorScheme: ColorScheme.fromSwatch(
    //       primarySwatch: Colors.teal,
    //     ).copyWith(
    //       secondary: Colors.green,
    //     ),
    //     canvasColor: const Color(0xFFF0F8FF),
    //     textTheme: const TextTheme(
    //       bodyText2: TextStyle(color: Color(0xFF000000), fontSize: 30),
    //       headline4: TextStyle(color: Color(0xFF800000), fontSize: 17),
    //       headline6: TextStyle(color: Color(0xFF000000), fontSize: 15),
    //     ),
    //   ),
    //   home: const MyHomePage(title: 'Covid-19 Data'),
    // );
    return const MyHomePage(title: 'Covid-19 Data');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = 'PILIH PROVINSI';
  EdgeInsets top = const EdgeInsets.only(top: 20.0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextStyle tableTitle =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300);
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Form(
      key: _formKey,
      child: ListView(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          NavApp(
            current: "Covid-19 Data",
            currContext: context,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Data Sebaran Covid-19 di Indonesia',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: top,
            child: Text(
              'Data provided by data.covid19.go.id API',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Text(
            'Provinsi :',
            style: Theme.of(context).textTheme.headline6,
          ),
          DropdownButtonFormField<String>(
            value: dropdownValue,
            isDense: true,
            icon: const Icon(Icons.arrow_drop_down_sharp),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            // underline: Container(
            //   height: 1,
            //   color: Colors.teal,
            // ),
            validator: (String? value) {
              if (value == 'PILIH PROVINSI') {
                return 'Pilih provinsi yang diinginkan';
              }
              return null;
            },
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>[
              'PILIH PROVINSI',
              'DKI JAKARTA',
              'JAWA BARAT',
              'JAWA TENGAH',
              'JAWA TIMUR',
              'KALIMANTAN TIMUR',
              'DAERAH ISTIMEWA YOGYAKARTA',
              'BANTEN',
              'RIAU',
              'BALI',
              'SULAWESI SELATAN',
              'SUMATERA UTARA',
              'SUMATERA BARAT',
              'KALIMANTAN SELATAN',
              'NUSA TENGGARA TIMUR',
              'SUMATERA SELATAN',
              'KEPULAUAN RIAU',
              'KEPULAUAN BANGKA BELITUNG',
              'LAMPUNG',
              'SULAWESI TENGAH',
              'KALIMANTAN TENGAH',
              'KALIMANTAN BARAT',
              'ACEH',
              'KALIMANTAN UTARA',
              'SULAWESI UTARA',
              'PAPUA',
              'JAMBI',
              'NUSA TENGGARA BARAT',
              'PAPUA BARAT',
              'BENGKULU',
              'SULAWESI TENGGARA',
              'MALUKU',
              'SULAWESI BARAT',
              'MALUKU UTARA',
              'GORONTALO',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
              style: ButtonStyle(
                // maximumSize: MaterialStateProperty.all<Size>(Size.fromWidth(5)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.green.withOpacity(0.04);
                    }
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed)) {
                      return Colors.green.withOpacity(0.12);
                    }
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(dropdownValue)));
                }
              },
              child: const Text('Submit')),
          Column(children: <Widget>[
            Container(
              margin: top,
              child: Table(
                //defaultColumnWidth: const FixedColumnWidth(120.0),
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 1),
                children: [
                  TableRow(children: [
                    Column(children: [Text('Provinsi', style: tableTitle)]),
                    Column(
                        children: [Text('Dalam Perawatan', style: tableTitle)]),
                    Column(children: [Text('Kasus Sembuh', style: tableTitle)]),
                    Column(
                        children: [Text('Kasus Meninggal', style: tableTitle)]),
                  ]),
                ],
              ),
            ),
          ]),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    ));
  }
}
