import 'package:flutter/material.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tugas_akhir_f03/models/matkul.dart';

void main() => runApp(UDDApp());

class UDDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Susun Jadwal',
      theme: ThemeData(
        backgroundColor: Colors.red,
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nama UDD',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Golongan Darah yang Tersedia',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Jumlah Stok',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nomor Telepon',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Alamat',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: ElevatedButton(
                  child: const Text("Submit"), // disini kayaknya harus diubah
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Berhasil menambahkan jadwal")),
                      );
                    }
                  }),
            ),
          ),
        ],
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

  Future<Widget> fetchData() async {
    const url = 'https://pbp-midtermproject-f03.herokuapp.com/susun-jadwal-matkul/json/';
    try {
      final http.Response response = await http.get(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
          },
      );

      var jsonData = jsonDecode(response.body);
      List<dynamic> jsonObject = jsonData as List<dynamic>;
      // Map<String, dynamic> extractedData = jsonDecode(response.body);

      List<Widget> childrens = [];
      
      jsonObject.forEach((element) {
        for(var i = 0; i < jsonObject.length; i++){
          childrens.add(
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 15.0), child: ListTile(
                    title: Text(jsonObject[i]['fields']['day'].toString() + '\n'),
                    subtitle: Text(jsonObject[i]['fields']['start_time'].toString() + ' - ' +
                        jsonObject[i]['fields']['end_time'].toString() + ' | ' +
                        jsonObject[i]['fields']['name'].toString()),
                  )),
                ),
              ),
            ),
          );
        }
      });

      // extractedData.forEach((key, value) {
      //   // karena data sebelumnya dict of array
      //   for (var i = 0; i < value.length; i++) {
      //     childrens.add(
      //       Center(
      //         child: Padding(
      //           padding: const EdgeInsets.all(10.0),
      //           child: Card(
      //             child: Padding(padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 15.0), child: ListTile(
      //               title: Text(value[i]['day'] + '\n'),
      //               subtitle: Text(value[i]['start_time'] + ' - ' +
      //                   value[i]['end_time'] + ' | ' +
      //                   value[i]['name'].toString()),
      //             )),
      //           ),
      //         ),
      //       ),
      //     );
      //   }
      // });

      childrens.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: ElevatedButton(
              child: const Text("Submit"),
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

      print("text");

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
                  // future: Matkul.getMatkuls(),
                  // builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //   print(snapshot.data);
                  //   if (snapshot.data == null) {
                  //     return Container(
                  //       child: Center(
                  //         child: Text("Belum ada matkul"),
                  //       ),
                  //     );
                  //   } else {
                  //     return ListView.builder(
                  //       itemCount: snapshot.data.length,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return ListTile(
                  //           leading: CircleAvatar(
                  //             backgroundColor: Color.fromRGBO(10, 98, 107, 100),
                  //             child: Text("${snapshot.data[index].day}",
                  //                 style: TextStyle(fontSize: 20)),
                  //           ),
                  //           title: Text(
                  //             "${snapshot.data[index].start_time} - ${snapshot.data[index].end_time} | ${snapshot.data[index].name}"
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   }
                  // }
                ),
              ],
            ),
        ),
    );
  }
}
