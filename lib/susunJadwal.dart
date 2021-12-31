import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

TextEditingController controllerNama = new TextEditingController();
TextEditingController controllerPukulMulai = new TextEditingController();
TextEditingController controllerPukulSelesai = new TextEditingController();

// liatlah console itu :)
void main() => runApp(SusunJadwal());

class SusunJadwal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Susun Jadwal',
      theme: ThemeData(
        backgroundColor: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  static const appTitle = 'Susun Jadwal';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePageSusunJadwal(),
    );
  }
}

class MyHomePageSusunJadwal extends StatelessWidget {
  const MyHomePageSusunJadwal({Key? key}) : super(key: key);

  final String title = 'Susun Jadwal';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyCostumCard(),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Menambahkan matkul"),
        ),
        body: const MyCostumForm());
  }
}

class MyCostumForm extends StatefulWidget {
  const MyCostumForm({Key? key}) : super(key: key);

  @override
  MyCostumFormState createState() {
    return MyCostumFormState();
  }
}

class MyCostumFormState extends State<MyCostumForm> {
  // final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'PILIH HARI MATKUL DIADAKAN';

  String name = "";
  String day = "";
  String start_time = "";
  String end_time = "";

  Future<void> _processData() async {
    final response = await http.post(Uri.parse('https://pbp-midtermproject-f03.herokuapp.com/susun-jadwal-matkul/json/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'day': day,
        'start_time': start_time,
        'end_time': end_time,
      }),
    );
  }

  void kirimData(){
    AlertDialog alertDialog = new AlertDialog(
      content: new Container(
        height: 170.0,
        child: new Column(
          children: [
            new Text("Nama matkul: " + name),
            new Text("Hari matkul diadakan: " + day),
            new Text("Pukul matkul dimulai: ${controllerPukulMulai.text}"),
            new Text("Pukul matkul selesai: ${controllerPukulSelesai.text}" + " " + end_time),
            new RaisedButton(
              child: new Text("Close"),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: ListView(
          children:[
            Center(
              child: Text(
                "Masukkan nama matkul",
                style: TextStyle(fontSize: 15, color: Color.fromRGBO(10, 98, 107, 100)),
              ),
            ),
            TextFormField(
                controller: controllerNama,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Masukan nama matkul',
                  labelText: 'Nama matkul',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return "Please fill out this field.";
                  }
                  return null;
                },
                onChanged: (value) {
                  name = value;
                },
            ),
            Center(
              child: Text(
                "Masukkan hari matkul diadakan",
                style: TextStyle(fontSize: 15, color: Color.fromRGBO(10, 98, 107, 100)),
              ),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: const OutlineInputBorder(),
              ),
              value: dropdownvalue,
              isDense: true,
              icon: const Icon(Icons.arrow_drop_down_sharp),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              validator: (String? value) {
                if (value == 'PILIH HARI MATKUL DIADAKAN') {
                  return 'Please fill out this field.';
                }
                // return null;
              },
              onChanged: (String? newValue) {
                dropdownvalue = newValue!;
                day = dropdownvalue;
              },
              items: <String>[
                'PILIH HARI MATKUL DIADAKAN',
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Center(
              child: Text(
                "Masukkan pukul berapa matkul berlangsung",
                style: TextStyle(fontSize: 15, color: Color.fromRGBO(10, 98, 107, 100)),
              ),
            ),
            DateTimeField(
              controller: controllerPukulMulai,
              decoration: const InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Masukan pukul berapa matkul diadakan',
              ),
              format: DateFormat("HH:mm"),
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
              validator: (value) {
                if (value == null){
                  return 'Please fill out this field.';
                }
              },
              onSaved: (DateTime? val) {
                // start_time = (val).toString();
                start_time = controllerPukulSelesai.text;
              },
            ),
            Center(
              child: Text(
                "Masukkan pukul berapa matkul berakhir",
                style: TextStyle(fontSize: 15, color: Color.fromRGBO(10, 98, 107, 100)),
              ),
            ),
            DateTimeField(
              controller: controllerPukulSelesai,
              decoration: const InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Masukan pukul berapa matkul berakhir',
              ),
              format: DateFormat("HH:mm"),
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
              validator: (value) {
                if (value == null){
                  return 'Please fill out this field.';
                }
              },
              onSaved: (DateTime? val) {
                // end_time = (val).toString();
                end_time = controllerPukulSelesai.text;
              },
            ),
            ElevatedButton(
                // style: ButtonStyle(
                //   backgroundColor: Color.fromRGBO(r, g, b, 100),
                // ),
                onPressed: () {
                  _processData();
                  kirimData();
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Data is processing")));
                  }
                },
                child: const Text('Submit')
              ),
            ],
          ),
        ),
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
  String matkulSenin = "";
  String matkulSelasa = "";
  String matkulRabu = "";
  String matkulKamis = "";
  String matkulJumat = "";

  Future<Widget> fetchData() async {
    const url = 'https://pbp-midtermproject-f03.herokuapp.com/susun-jadwal-matkul/json/';
    try {
      final http.Response response = await http.get(Uri.parse(url));

      // var jsonData = jsonDecode(response.body);
      // List<dynamic> jsonObject = jsonData as List<dynamic>;
      Map<String, dynamic> extractedData = jsonDecode(response.body);

      // yg iniii
      List<Widget> childrens = [];

      extractedData.forEach((key, value) {
        // karena data sebelumnya dict of array
        for (var i = 0; i < value.length; i++) {
          if (value[i]['day'] == "Monday"){
            matkulSenin = matkulSenin + (value[i]['start_time'] + ' - ' +
                value[i]['end_time'] + ' | ' +
                value[i]['name'].toString() + '\n');
          }
          else if (value[i]['day'] == "Tuesday"){
            matkulSelasa = matkulSelasa + (value[i]['start_time'] + ' - ' +
                value[i]['end_time'] + ' | ' +
                value[i]['name'].toString() + '\n');
          }
          else if (value[i]['day'] == "Wednesday"){
            matkulRabu = matkulRabu + (value[i]['start_time'] + ' - ' +
                value[i]['end_time'] + ' | ' +
                value[i]['name'].toString() + '\n');
          }
          else if (value[i]['day'] == "Thursday"){
            matkulKamis = matkulKamis + (value[i]['start_time'] + ' - ' +
                value[i]['end_time'] + ' | ' +
                value[i]['name'].toString() + '\n');
          }
          else if (value[i]['day'] == "Friday"){
            matkulJumat = matkulJumat + (value[i]['start_time'] + ' - ' +
                value[i]['end_time'] + ' | ' +
                value[i]['name'].toString() + '\n');
          }
        }
      });

      childrens.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Padding(padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 15.0),
                  child: ListTile(
                    title: Text("Monday" + '\n'),
                    subtitle: Text(matkulSenin),
                    leading: CircleAvatar(
                      backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                      child: Text("Mon", style: TextStyle(fontSize: 20)),
                    ),
                  )
                ),
              ),
          ),
        ));

      childrens.add(
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Padding(padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 15.0), child: ListTile(
                  title: Text("Tuesday" + '\n'),
                  subtitle: Text(matkulSelasa),
                  leading: CircleAvatar(
                    backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                    child: Text("Tue", style: TextStyle(fontSize: 20)),
                  ),
                )),
              ),
            ),
          ));

      childrens.add(
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Padding(padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 15.0), child: ListTile(
                  title: Text("Wednesday" + '\n'),
                  subtitle: Text(matkulRabu),
                  leading: CircleAvatar(
                    backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                    child: Text("Wed", style: TextStyle(fontSize: 20)),
                  ),

                )),
              ),
            ),
          ));

      childrens.add(
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Padding(padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 15.0), child: ListTile(
                  title: Text("Thursday" + '\n'),
                  subtitle: Text(matkulKamis),
                  leading: CircleAvatar(
                    backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                    child: Text("Thu", style: TextStyle(fontSize: 20)),
                  ),
                )),
              ),
            ),
          ));

      childrens.add(
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Padding(padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 15.0), child: ListTile(
                  title: Text("Friday" + '\n'),
                  subtitle: Text(matkulJumat),
                  leading: CircleAvatar(
                    backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                    child: Text("Fri", style: TextStyle(fontSize: 20)),
                  ),
                )),
              ),
            ),
          ));

      childrens.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: ElevatedButton(
              child: const Text("Add matkul"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              }),
        ),
      ));

      Widget wrapper = Column(
        //thisone
        crossAxisAlignment: CrossAxisAlignment.center,
        children: childrens,
      );

      return wrapper;
    } catch (err) {
      // err -> error
      print(err);

      return const Text("Belum ada Matkul");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          //thisone
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
                ),
              ],
            ),
        ),
    );
  }
}
