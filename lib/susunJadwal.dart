import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'package:tugas_akhir_f03/api_susunJadwal.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_f03/models/matkul.dart';
import 'dart:convert';

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

late Future<List<Matkul>?> futureMatkul = fetchMatkul();

void main() => runApp(susunJadwalScreen());

class susunJadwalScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Scheduling")),
      body: Center(
        child: ListView(
          children: [
            susunJadwalScreen(),
            SizedBox(height : 20.0),
            // MyCard(),
            // SizedBox(height : 20.0),
            FormScreen(),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget{
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: ListView(
        children: [
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
        ],
      ),
    );
  }
}

class SusunJadwalListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureMatkul,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Question is Empty'),
          );
        } else if (snapshot.hasData) {
          return _listMatkul(snapshot.data as List<Matkul>);
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _listMatkul(List<Matkul> matkuls) {
    double field = 75;
    return Container(
      height: field * matkuls.length,
      child: ListView.builder(
        itemCount: matkuls.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var matkul = matkuls[index];
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        Text("${matkul.hari}", textAlign: TextAlign.left, style: TextStyle(fontSize: 17, color: Color(0xff374ABE), fontWeight: FontWeight.bold)),
                        Text("${matkul.pukulMulai} - ${matkul.pukulSelesai} | ${matkul.nama} ", textAlign: TextAlign.left, style: TextStyle(fontSize: 17, color: Color(0xff374ABE))),
                      ],
                    ),
                ),
              ),
          );
        },
      ),
    );
  }
}


class FormScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'PILIH HARI MATKUL DIADAKAN';
  String nama = "";
  String hari = "";
  String pukulMulai = "";
  String pukulSelesai = "";

  // void kirimData(){
  //   AlertDialog alertDialog = new AlertDialog(
  //     content: new Container(
  //       height: 170.0,
  //       child: new Column(
  //         children: [
  //           new Text("Nama matkul: ${controllerNama.text}"),
  //           new Text("Hari matkul diadakan: $dropdownvalue"),
  //           new Text("Pukul matkul dimulai: ${controllerPukulMulai.text}"),
  //           new Text("Pukul matkul selesai: ${controllerPukulSelesai.text}"),
  //           new RaisedButton(
  //             child: new Text("Close"),
  //             onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //   showDialog(context: context, builder: (_) => alertDialog);
  // }

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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: ListView(
        children: [
          Text(
            "Masukkan nama matkul",
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
            }
          ),
          Text(
            "Masukkan hari matkul diadakan",
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
                return 'Pilih hari matkul diadakan';
              }
              return null;
            },
            onChanged: (String? newValue) {
              dropdownvalue = newValue!;
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
          Text(
              "Masukkan pukul berapa matkul berlangsung",
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
            onSaved: (DateTime? val) {
              _pukulMulai = (val);
            },
          ),
          Text(
            "Masukkan pukul berapa matkul berakhir",
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
            onSaved: (DateTime? val) {
              _pukulSelesai = (val);
            },
          ),
          ElevatedButton(
            // onPressed: () {
            //   if (_formKey.currentState!.validate()) {
            //     // kirimData();
            //     processData();
            //     ScaffoldMessenger.of(context)
            //         .showSnackBar(SnackBar(content: Text("Data is processing")));
            //   }
            // },
            onPressed: () async {
              final response = await http.post(Uri.parse('http://127.0.0.1:8000/susun-jadwal-matkul/matkul-list/'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8'
                  },
                  body: jsonEncode(<String, String> {
                    'name': nama,
                    'day': hari,
                    'pukul_mulai': pukulMulai,
                    'pukul_selesai': pukulSelesai,
                  }));
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => susunJadwalScreen()),
              );
              futureMatkul = fetchMatkul();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}