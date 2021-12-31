import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:accordion/accordion.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(const InfoPendidikan());
}

Color c = const Color(0xFF5F9EA0);

class InfoPendidikan extends StatelessWidget {
  const InfoPendidikan({Key? key}) : super(key: key);
  // static const  = '/infopendidikan';
  // This widget is the root of your application.

  static Map<int, Color> themeColor = {
    // 0xFF24262A
    50: const Color.fromRGBO(95, 158, 160, .1),
    100: const Color.fromRGBO(95, 158, 160, 2),
    200: const Color.fromRGBO(95, 158, 160, .3),
    300: const Color.fromRGBO(95, 158, 160, .4),
    400: const Color.fromRGBO(95, 158, 160, .5),
    500: const Color.fromRGBO(95, 158, 160, .6),
    600: const Color.fromRGBO(95, 158, 160, .7),
    700: const Color.fromRGBO(95, 158, 160, .8),
    800: const Color.fromRGBO(95, 158, 160, .9),
    900: const Color.fromRGBO(95, 158, 160, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Recently on Education',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF5F9EA0, themeColor),
      ),
      home: const MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavApp(current: "InfoPendidikan", currContext: context),
        resizeToAvoidBottomInset: false,
        body: const Accordion(),
        // body: SingleChildScrollView(child: Accordion()),
        appBar: AppBar(title: const Text('Recently on Education')));
  }
}
// class MyPage extends StatefulWidget {
//   const MyPage({Key? key}) : super(key: key);

//   @override
//   State<MyPage> createState() => _MyPageState();
// }

// class _MyPageState extends State<MyPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   static const appTitle = 'Recently on Education';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: appTitle,
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       home: const infoPendidikanHomePage(),
//     );
//   }
// }

// class infoPendidikanHomePage extends StatelessWidget {
//   const infoPendidikanHomePage({Key? key}) : super(key: key);

//   final String title = 'Recently on Education';

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Accordion(),
//     );
//   }
// }

class Accordion extends StatefulWidget {
  const Accordion({Key? key}) : super(key: key);

  @override
  AccordionState createState() {
    return AccordionState();
  }
}

class AccordionState extends State<Accordion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(235, 240, 242, 100),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(left: 70, right: 70, top: 70),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GFAccordion(
                        margin: EdgeInsets.all(0),
                        contentBorder: Border(),
                        collapsedIcon: Icon(Icons.arrow_drop_down),
                        expandedIcon: Icon(Icons.arrow_drop_up),
                        title:
                            "Gojek Founder Makarim Pushes for School Reform in Indonesia",
                        content:
                            "Nadiem Makarim, Minister of Education, Culture, Research, and Technology of the Republic of Indonesia discusses his plans to bridge the digital divide for the nation’s 60 million students."),
                    // ElevatedButton(
                    //     child: Text('More'),
                    //     onPressed: null,
                    //     style: ButtonStyle(
                    //         // backgroundColor: MaterialStateProperty.all(Colors.teal),
                    //         // textStyle: TextStyle(
                    //         //   fontSize: 16,
                    //         //   color: Colors.white
                    //         // ),
                    //         )
                    // style: ElevatedButton.styleFrom(
                    //   primary: Colors.teal,
                    //   textStyle: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.white
                    //   )

                    // style: ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStateProperty.all<Color>(Colors.white)),
                    // child: Text(
                    //   'More',
                    //   style:
                    //     ButtonStyle(),
                    //     TextStyle(color: Colors.teal),),
                    // onPressed: null),
                    GFAccordion(
                        margin: EdgeInsets.all(0),
                        contentBorder: Border(),
                        collapsedIcon: Icon(Icons.arrow_drop_down),
                        expandedIcon: Icon(Icons.arrow_drop_up),
                        title:
                            "1 in 3 Kids in Classes 1, 2 Never Attended School in Person Due to Covid: Survey",
                        content:
                            "One in every three children in classes 1 and 2 has never attended in-person school before due to the COVID-19 pandemic, said a survey report by the Annual Status of Education Report (ASER) 2021."),
                    GFAccordion(
                        margin: EdgeInsets.all(0),
                        collapsedIcon: Icon(Icons.arrow_drop_down),
                        expandedIcon: Icon(Icons.arrow_drop_up),
                        title: "More Young People Choose Work Over College",
                        content:
                            "Higher education enrollment rates dropped for the second straight year, defying predictions of a post-lockdown bounceback and hitting a record low for a two-year span."),
                    GFAccordion(
                        margin: EdgeInsets.all(0),
                        collapsedIcon: Icon(Icons.arrow_drop_down),
                        expandedIcon: Icon(Icons.arrow_drop_up),
                        title:
                            "Covid: Are Schools Back to Normal Yet? Not Quite",
                        content:
                            "It looks like a normal scene in a school playground - pupils arriving with their heavy rucksacks and friends chatting in little groups."),
                    GFAccordion(
                        margin: EdgeInsets.all(0),
                        collapsedIcon: Icon(Icons.arrow_drop_down),
                        expandedIcon: Icon(Icons.arrow_drop_up),
                        title:
                            "'It’s time to be firm': Nadiem Defends Decree on Tackling Sexual Violence on Campuses",
                        content:
                            "Education, Culture, Research and Technology Minister Nadiem Makarim (left, on screen) speaks during a Jakpost Up Close webinar, themed “Educating the nation: 2020 — 2045”, in Jakarta on Wednesday."),
                    GFAccordion(
                        margin: EdgeInsets.all(0),
                        collapsedIcon: Icon(Icons.arrow_drop_down),
                        expandedIcon: Icon(Icons.arrow_drop_up),
                        title:
                            "Academics Say Virtual Learning no Match for Real Thing",
                        content:
                            "While online classes have become the norm amid the COVID-19 pandemic, academics from Japan and Hong Kong believe that online classes cannot truly be a substitute for face-to-face learning despite the merits of technology in communicating with students."),
                    GFAccordion(
                        margin: EdgeInsets.all(0),
                        collapsedIcon: Icon(Icons.arrow_drop_down),
                        expandedIcon: Icon(Icons.arrow_drop_up),
                        title:
                            "Prolonged School Closure Puts Students' Future Earnings at Risk: WB Study",
                        content:
                            "Prolonged school closure due to the COVID-19 pandemic has deepened the learning crisis in Indonesia, as learning loss puts students at risk of notable income loss in the future, reveals a World Bank study published on Sept. 16."),
                    GFAccordion(
                        margin: EdgeInsets.all(0),
                        collapsedIcon: Icon(Icons.arrow_drop_down),
                        expandedIcon: Icon(Icons.arrow_drop_up),
                        title:
                            "Indonesia Launches Book on ASEAN for Elementary, Middle School Students",
                        content:
                            "The government introduced on Wednesday study books on ASEAN for elementary and middle schools in hopes to increase the younger generations’ understanding of the association of 10 Southeast Asian nations."),
                    ElevatedButton(
                        child: Text("Add your own article"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SecondPage()),
                          );
                        }),
                  ])),
        ));
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add your own article!"),
        ),
        body: const MyForm());
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final formKey = GlobalKey<FormState>();
  String title = " ";
  String description = " ";
  // String judul = '';
  // String deskripsi = '';

  // Future<Widget> fetchData() async {
  //   const url =
  //       'https://pbp-midtermproject-f03.herokuapp.com/info-pendidikan/json/';
  //   try {
  //     final http.Response response = await http.get(Uri.parse(url));
  //     List <Widget> info = [];
  // } catch (err) {
  //     print(err);

  //     return const Text("Error");
  //   }
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Form(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              buildTitle(),
              const SizedBox(height: 15),
              buildDesc(),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // _processData();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Processing...")));
                  }
                },
                child: const Text('Add'),
              )
            ],
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     if (formKey.currentState!.validate()) {
          //       _processData();
          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(context: Text("Processing...")));
          //     }
          //   }
          //   child: Text('Add'))
        ),
      );

  Widget buildTitle() => TextFormField(
      decoration: const InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill out this field.";
        } else {
          return null;
        }
      });

  Widget buildDesc() => TextFormField(
      decoration: const InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill out this field.";
        } else {
          return null;
        }
      });
}
