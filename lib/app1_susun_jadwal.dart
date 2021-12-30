import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'package:http/http.dart' as http;
// import 'dart:async';
import 'dart:convert';
import 'package:tugas_akhir_f03/models/matkul.dart';

// Referensi :
// https://api.flutter.dev/flutter/material/Card-class.html
// https://github.com/flutter/flutter/issues/15919
// https://gallery.flutter.dev/#/
// https://pub.dev/packages/datetime_picker_formfield
// https://flutter.dev/docs/cookbook/design/themes

String _nama = "";
String _hari = "";
DateTime? _pukulMulai;
DateTime? _pukulSelesai;
TextEditingController controllerNama = new TextEditingController();
TextEditingController controllerHari = new TextEditingController();
TextEditingController controllerPukulMulai = new TextEditingController();
TextEditingController controllerPukulSelesai = new TextEditingController();
List matkulInMonday = [];
List matkulInTuesday = [];
List matkulInWednesday = [];
List matkulInThursday = [];
List matkulInFriday = [];

void main() {
  runApp(const SusunJadwalApp1());
}

class SusunJadwalApp1 extends StatelessWidget {
  const SusunJadwalApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Susun Jadwal',
      theme: ThemeData(
        backgroundColor: Colors.teal,
      ),
      home: const MyCostumPage(),
    );
  }
}

class MyCostumPage extends StatefulWidget {
  const MyCostumPage({Key? key}) : super(key: key);

  @override
  State<MyCostumPage> createState() => _MyCostumPageState();
}

class _MyCostumPageState extends State<MyCostumPage> {
  @override
  void initState() {
    super.initState();
  }

  final String app_title = "Susun Jadwal";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: app_title,
      debugShowCheckedModeBanner: false,
      home: const MyHomePageApp1(),
    );
  }
}

class MyHomePageApp1 extends StatelessWidget {
  const MyHomePageApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyCostumCard(),
    );
  }
}

class MyCostumCard extends StatefulWidget {
  const MyCostumCard({Key? key}) : super(key: key);

  @override
  MyCostumCardState createState() {
    return MyCostumCardState();
  }
}

class MyCostumCardState extends State<MyCostumCard> {
  Future<Widget> fetchData() async {
    const url = 'https://pbp-midtermproject-f03.herokuapp.com/susun-jadwal-matkul/matkul-list/';
    try {
      final http.Response response = await http.get(Uri.parse(url),
          headers: {
            "Access-Control-Allow-Origin" : "*",
          });
      Map<String, dynamic> extractedData = jsonDecode(response.body);

      List<Widget> childrens = [];

      childrens.add(Container(
        margin: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(),
      ));

      extractedData.forEach((key, value) {
        // karena data sebelumnya dict of array
        for (var i = 0; i < value.length; i++) {
          childrens.add(
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 15.0), child: ListTile(
                    title: Text(value[i]['day']),
                    subtitle: Text(
                        "${value[i]['start_time']} - ${value[i]['start_time']} | ${value[i]['name']}\n"
                    ),
                  )),
                ),
              ),
            ),
          );
        }
      });

      Widget wrapper = Column(
        //thisone
        crossAxisAlignment: CrossAxisAlignment.center,
        children: childrens,
      );

      return wrapper;
    } catch (err) {
      // err -> error
      print(err);

      return const Text("Loading...");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            NavApp(
              current: "SusunJadwal",
              currContext: context,
            ),
            FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  Widget childrens = snapshot.data as Widget;
                  return childrens;
                } else{
                  return const Center(child: CircularProgressIndicator());
                }
              }
              // builder: (BuildContext context, AsyncSnapshot snapshot){
              //   // print(snapshot.data);
              //   if(snapshot.data == null){
              //     return Container(
              //       child: Center(
              //         child: Text("Loading..."),
              //       ),
              //     );
              //   } else{
              //     return ListView.builder(
              //       itemCount: snapshot.data.length,
              //       itemBuilder: (BuildContext context, int author_id){
              //         return ListTile(
              //           leading: CircleAvatar(
              //             backgroundColor: Color.fromRGBO(10, 98, 107, 100),
              //             child: Text("${snapshot.data[author_id].day}", style: TextStyle(fontSize: 20)),
              //           ),
              //           title: Text( "${snapshot.data[author_id].start_time} - "
              //               "${snapshot.data[author_id].end_time} | "
              //               "${snapshot.data[author_id].name}"),
              //         );
              //       },
              //     );
              //   };
              // },
            ),
          ],
        ),
      ),
    );
  }
}
