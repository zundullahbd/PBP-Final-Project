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
  runApp(const SusunJadwalScreen());
}

class SusunJadwalScreen extends StatelessWidget {
  const SusunJadwalScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyCostumPage(title: "Susun Jadwal");
  }
}

class MyCostumPage extends StatefulWidget{
  const MyCostumPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyCostumPageState createState(){
    return MyCostumPageState();
  }
}

class MyCostumPageState extends State<MyCostumPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'PILIH HARI MATKUL DIADAKAN';
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
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: [
              NavApp(
                current: "SusunJadwal",
                currContext: context,
              ),
              Card(
                child: ListTile(
                  title: Text(hari[0], style: TextStyle(fontSize: 20)),
                  subtitle: Text(
                      (matkulInMonday.length > 1 ? setMatkulSenin() : ""), style: TextStyle(fontSize: 12)),
                  leading: CircleAvatar(
                    backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                    child: Text(hari[0][0], style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(hari[1], style: TextStyle(fontSize: 20)),
                  subtitle: Text(setMatkulSelasa(), style: TextStyle(fontSize: 12)),
                  leading: CircleAvatar(
                    backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                    child: Text(hari[1][0], style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(hari[2], style: TextStyle(fontSize: 20)),
                  subtitle: Text(setMatkulRabu(), style: TextStyle(fontSize: 12)),
                  leading: CircleAvatar(
                    backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                    child: Text(hari[2][0], style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(hari[3], style: TextStyle(fontSize: 20)),
                  subtitle: Text(setMatkulKamis(), style: TextStyle(fontSize: 12)),
                  leading: CircleAvatar(
                    backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                    child: Text(hari[3][0], style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(hari[4], style: TextStyle(fontSize: 20)),
                  subtitle: Text(setMatkulJumat(), style: TextStyle(fontSize: 12)),
                  leading: CircleAvatar(
                    backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                    child: Text(hari[4][0], style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Masukkan nama matkul",
                  style: TextStyle(fontSize: 20, color: Color.fromRGBO(10, 98, 107, 100)),
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
                  }
              ),
              Center(
                child: Text(
                  "Masukkan hari matkul diadakan",
                  style: TextStyle(fontSize: 20, color: Color.fromRGBO(10, 98, 107, 100)),
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
              Center(
                child: Text(
                  "Masukkan pukul berapa matkul berlangsung",
                  style: TextStyle(fontSize: 20, color: Color.fromRGBO(10, 98, 107, 100)),
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
                onSaved: (DateTime? val) {
                  _pukulMulai = (val);
                },
              ),
              Center(
                child: Text(
                  "Masukkan pukul berapa matkul berakhir",
                  style: TextStyle(fontSize: 20, color: Color.fromRGBO(10, 98, 107, 100)),
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
                onSaved: (DateTime? val) {
                  _pukulSelesai = (val);
                },
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
                      processData();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Data is processing")));
                    }
                  },
                  child: const Text('Submit')
              ),
            ],
          ),
        ),
      ),
    );
  }
}