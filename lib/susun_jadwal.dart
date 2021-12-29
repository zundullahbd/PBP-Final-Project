import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'package:http/http.dart' as http;

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
  runApp(const SusunJadwal());
}

class SusunJadwal extends StatelessWidget {
  const SusunJadwal({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color.fromRGBO(235, 240, 242, 100),

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,
              color: Colors.teal),
          headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
              color: Color.fromRGBO(16, 130, 88, 100)),
          bodyText2: TextStyle(fontSize: 15.0),
        ),
      ),
      home: new MyCard(),
    );
  }
}

class MyCard extends StatelessWidget{
  const MyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Susun Jadwal"),
      ),
      body: const MyCostumCard(),
    );
  }
}

class MyCostumCard extends StatefulWidget{
  const MyCostumCard({Key? key}) : super(key: key);

  @override
  MyCostumCardState createState(){
    return MyCostumCardState();
  }
}

class MyCostumCardState extends State<MyCostumCard>{
  final List hari = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];

  String matkulSenin = "";
  String matkulSelasa = "";
  String matkulRabu = "";
  String matkulKamis = "";
  String matkulJumat = "";

  String setMatkulSenin(){
    for (int i = 0; i < matkulInMonday.length; i++) {
      matkulSenin = matkulSenin + matkulInMonday[i] + " "; }
    return matkulSenin;
  }

  String setMatkulSelasa(){
    for (int i = 0; i < matkulInTuesday.length; i++) {
      matkulSelasa = matkulSelasa + matkulInTuesday[i] + " "; }
    return matkulSelasa;
  }

  String setMatkulRabu(){
    for (int i = 0; i < matkulInWednesday.length; i++) {
      matkulRabu = matkulRabu + matkulInWednesday[i] + " "; }
    return matkulRabu;
  }

  String setMatkulKamis(){
    for (int i = 0; i < matkulInThursday.length; i++) {
      matkulKamis = matkulKamis + matkulInThursday[i] + " "; }
    return matkulKamis;
  }

  String setMatkulJumat(){
    for (int i = 0; i < matkulInFriday.length; i++) {
      matkulJumat= matkulJumat + matkulInFriday[i] + " "; }
    return matkulJumat;
  }

  @override
  Widget build(BuildContext context){
    return Center(
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(hari[0], style: TextStyle(fontSize: 20)),
              subtitle: Text(
                  (matkulInMonday.length > 1 ? setMatkulSenin() : ""), style: TextStyle(fontSize: 12)),
              leading: CircleAvatar(
                child: Text(hari[0][0], style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(hari[1], style: TextStyle(fontSize: 20)),
              subtitle: Text(setMatkulSelasa(), style: TextStyle(fontSize: 12)),
              leading: CircleAvatar(
                child: Text(hari[1][0], style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(hari[2], style: TextStyle(fontSize: 20)),
              subtitle: Text(setMatkulRabu(), style: TextStyle(fontSize: 12)),
              leading: CircleAvatar(
                child: Text(hari[2][0], style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(hari[3], style: TextStyle(fontSize: 20)),
              subtitle: Text(setMatkulKamis(), style: TextStyle(fontSize: 12)),
              leading: CircleAvatar(
                child: Text(hari[3][0], style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(hari[4], style: TextStyle(fontSize: 20)),
              subtitle: Text(setMatkulJumat(), style: TextStyle(fontSize: 12)),
              leading: CircleAvatar(
                child: Text(hari[4][0], style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          ElevatedButton(
              child: const Text("Tambah jadwal matkul"),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyForm()));
              }
          ),
        ],
      ),
    );
  }
}

class MyForm extends StatelessWidget{
  const MyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambahkan mata kuliah"),
      ),
      body: const MyCostumForm(),
    );
  }
}

class MyCostumForm extends StatefulWidget{
  const MyCostumForm ({Key? key}) : super(key: key);

  @override
  MyCostumFormState createState(){
    return MyCostumFormState();
  }
}

class MyCostumFormState extends State<MyCostumForm>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'PILIH HARI MATKUL DIADAKAN';

  void kirimData(){
    AlertDialog alertDialog = new AlertDialog(
      content: new Container(
        height: 170.0,
        child: new Column(
          children: [
            new Text("Nama matkul: ${controllerNama.text}"),
            new Text("Hari matkul diadakan: $dropdownvalue"),
            new Text("Pukul matkul dimulai: ${controllerPukulMulai.text}"),
            new Text("Pukul matkul selesai: ${controllerPukulSelesai.text}"),
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

  void processData(){
    if (dropdownvalue == "Monday"){
      String namaMatkul = "${controllerNama.text}";
      String pukulMulai = "${controllerPukulMulai.text}";
      String pukulSelesai = "${controllerPukulSelesai.text}";
      String temp = "$pukulMulai - $pukulSelesai | $namaMatkul";
      // String temp = "$_pukulMulai - $_pukulSelesai | $_nama";
      matkulInMonday.add(temp);
      print(matkulInMonday);
    }
    else if (dropdownvalue == "Tuesday"){
      String namaMatkul = "${controllerNama.text}";
      String pukulMulai = "${controllerPukulMulai.text}";
      String pukulSelesai = "${controllerPukulSelesai.text}";
      String temp = "$pukulMulai - $pukulSelesai | $namaMatkul";
      // String temp = "$_pukulMulai - $_pukulSelesai | $_nama";
      matkulInTuesday.add(temp);
      print(matkulInTuesday);
    }
    else if (dropdownvalue == "Wednesday"){
      String namaMatkul = "${controllerNama.text}";
      String pukulMulai = "${controllerPukulMulai.text}";
      String pukulSelesai = "${controllerPukulSelesai.text}";
      String temp = "$pukulMulai - $pukulSelesai | $namaMatkul";
      // String temp = "$_pukulMulai - $_pukulSelesai | $_nama";
      matkulInWednesday.add(temp);
      print(matkulInWednesday);
    }
    else if (dropdownvalue == "Thursday"){
      String namaMatkul = "${controllerNama.text}";
      String pukulMulai = "${controllerPukulMulai.text}";
      String pukulSelesai = "${controllerPukulSelesai.text}";
      String temp = "$pukulMulai - $pukulSelesai | $namaMatkul";
      // String temp = "$_pukulMulai - $_pukulSelesai | $_nama";
      matkulInThursday.add(temp);
      print(matkulInThursday);
    }
    else {
      String namaMatkul = "${controllerNama.text}";
      String pukulMulai = "${controllerPukulMulai.text}";
      String pukulSelesai = "${controllerPukulSelesai.text}";
      String temp = "$pukulMulai - $pukulSelesai | $namaMatkul";
      // String temp = "$_pukulMulai - $_pukulSelesai | $_nama";
      matkulInFriday.add(temp);
      print(matkulInFriday);
    }
  }

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Center(
            child: Text(
              "Masukkan nama matkul",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Center(
            child: TextFormField(
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
                  setState(() {
                    _nama = value;
                  });
                  return null;
                }
            ),
          ),
          Center(
            child: Text(
              "Masukkan hari matkul diadakan",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Center(
            child: DropdownButtonFormField<String>(
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
                  return 'Pilih hari matkul diadakan';
                }
                return null;
              },
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
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
          ),
          Center(
            child: Text(
              "Masukkan pukul berapa matkul berlangsung",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Center(
            child: DateTimeField(
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
              onSaved: (val) => setState(() {
                _pukulMulai = (val);
              }),
            ),
          ),
          Center(
            child: Text(
              "Masukkan pukul berapa matkul berakhir",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Center(
            child: DateTimeField(
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
              onSaved: (val) => setState(() {
                _pukulSelesai = (val);
              }),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  kirimData();
                  processData();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Data is processing")));
                }
              },
              child: const Text('Submit'),
            ),
          ),

        ],
      ),
    );
  }
}