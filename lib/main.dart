import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_akhir_f03/forum_pandemi/forum_pandemi.dart';
import 'package:tugas_akhir_f03/info_pendidikan.dart';
import 'package:tugas_akhir_f03/susunJadwal.dart';
import 'package:tugas_akhir_f03/to_do_list.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
<<<<<<< HEAD
import 'package:date_field/date_field.dart';
=======
import 'package:tugas_akhir_f03/covid_data.dart';
>>>>>>> 90cb4dd62237df984ec7c2618d45fc197eb2cbc0

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P.B.P',
      theme: ThemeData(
        fontFamily: 'Poppins',
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: const Color(0xfff0f8ff),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ).copyWith(
          secondary: Colors.green,
        ),
        canvasColor: const Color(0xFFF0F8FF),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color(0xFF000000), fontSize: 25),
          headline4: TextStyle(color: Color(0xFF800000), fontSize: 17),
          headline6: TextStyle(color: Color(0xFF000000), fontSize: 15),
        ),
      ),
      home: const MyHomePage(title: 'P . B . P'),
    );
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
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     // _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          NavApp(
            currContext: context,
          ),
          Text(
            'Corona, apa itu?',
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Text(
            "Corona merupakan virus yang menyebabkan penyakit pada manusia dan hewan. Biasanya menyebabkan penyakit infeksi saluran pernapasan pada manusia, mulai flu biasa hingga penyakit yang serius seperti MERS (Middle East Respiratory Syndrome) dan SARS (Severe Acute Respiratory Syndrome).",
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.headline6,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Menu: ',
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25)),
                  // maximumSize: MaterialStateProperty.all<Size>(Size.fromWidth(5)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.teal.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.teal.shade200.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                        color: Colors.teal,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForumPandemi()),
                  );
                },
                child: const Text(
                  'Forum Pandemi',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25)),
                  // maximumSize: MaterialStateProperty.all<Size>(Size.fromWidth(5)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal.shade100),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.teal.shade100.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.teal.shade200.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.teal.shade100,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CovidData()),
                  );
                },
                child: const Text(
                  'Covid-19 Data',
                  style: TextStyle(color: Color(0xFF000000), fontSize: 15),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25)),
                  // maximumSize: MaterialStateProperty.all<Size>(Size.fromWidth(5)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.teal.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.teal.shade200.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                        color: Colors.teal,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InfoPendidikan()),
                  );
                },
                child: const Text(
                  'Recent Education',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25)),
                  // maximumSize: MaterialStateProperty.all<Size>(Size.fromWidth(5)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal.shade100),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.teal.shade100.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.teal.shade200.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.teal.shade100,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ToDoListPage()),
                  );
                },
                child: const Text(
                  'To-Do List',
                  style: TextStyle(color: Color(0xFF000000), fontSize: 15),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25)),
                  // maximumSize: MaterialStateProperty.all<Size>(Size.fromWidth(5)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.teal.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.teal.shade200.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                        color: Colors.teal,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Pandemic Quiz',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25)),
                  // maximumSize: MaterialStateProperty.all<Size>(Size.fromWidth(5)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal.shade100),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.teal.shade100.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.teal.shade200.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.teal.shade100,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                },
                child: const Text(
                  'Scheduler',
                  style: TextStyle(color: Color(0xFF000000), fontSize: 15),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25)),
                  // maximumSize: MaterialStateProperty.all<Size>(Size.fromWidth(5)),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.teal.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.teal.shade200.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.teal,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SusunJadwal()),
                  );
                },
                child: const Text(
                  'Susun Jadwal',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15),
                )),
          ),
        ],
      ),
    ));
  }
}
