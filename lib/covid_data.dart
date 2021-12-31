import 'package:flutter/material.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'package:tugas_akhir_f03/universal/globals.dart' as globals;
import 'package:tugas_akhir_f03/covid_searcheddata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const CovidData());
}

Color c = const Color(0xFF5F9EA0);

class CovidData extends StatelessWidget {
  const CovidData({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
  String userId = '';
  late var searchedData;
  bool shouldEnable = true;

  // sumber : https://stackoverflow.com/questions/52824388/how-do-you-add-query-parameters-to-a-dart-http-request
  Future<void> fetchData() async {
    const url =
        'http://pbp-midtermproject-f03.herokuapp.com/covid-data/data/json';
    Uri uri = Uri.parse(url);
    final finalUri = uri
        .replace(queryParameters: {'search': dropdownValue, 'user_id': userId});
    final response = await http.get(finalUri);
    if (response.statusCode == 200) {
      var extractedData = jsonDecode(response.body);
      print(jsonDecode(response.body));
      searchedData = extractedData['searchedData'];
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchedData(
                  data: searchedData,
                  length: searchedData.length,
                )),
      );
      setState(() {
        shouldEnable = true;
      });
    } else {
      print('unexpected error');
    }
  }

  Widget loggedInView() {
    if (globals.isLoggedIn) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Provinsi: " + _datacards[index].provinsi,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const Divider(
                        height: 10,
                        thickness: 1,
                        indent: 0,
                        endIndent: 10,
                        color: Colors.grey,
                      ),
                      Text("Positif: " + _datacards[index].positif.toString()),
                      Text("Sembuh: " + _datacards[index].sembuh.toString()),
                      Text("Meninggal: " +
                          _datacards[index].meninggal.toString()),
                    ],
                  )));
        },
        itemCount: _datacards.length,
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 0),
      );
    }
  }

  List<DataCard> _datacards = [];
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
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  children: [
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
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'Provinsi :',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: DropdownButtonFormField<String>(
                        value: dropdownValue,
                        isDense: true,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        iconSize: 24,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
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
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          // maximumSize: MaterialStateProperty.all<Size>(Size.fromWidth(5)),
                          backgroundColor: shouldEnable
                              ? MaterialStateProperty.all<Color>(Colors.green)
                              : MaterialStateProperty.all<Color>(
                                  Colors.grey.shade200),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
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
                        onPressed: shouldEnable
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  print('test2');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration: Duration(seconds: 2),
                                          content: Text("Please wait...")));
                                  setState(() {
                                    shouldEnable = false;
                                  });
                                  fetchData();
                                }
                              }
                            : null,
                        child: const Text(
                          'Submit',
                          style:
                              TextStyle(color: Color(0xFFFFFFFF), fontSize: 15),
                        )),
                    loggedInView(),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              ],
            )));
  }
}
