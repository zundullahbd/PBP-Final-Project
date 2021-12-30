import 'package:flutter/material.dart';
import 'package:tugas_akhir_f03/models/matkul.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SusunJadwalPage extends StatelessWidget {
  const SusunJadwalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SusunJadwalCard(),
    );
  }
}

class SusunJadwalCard extends StatefulWidget {
  const SusunJadwalCard({Key? key}) : super(key: key);

  @override
  _SusunJadwalCardState createState() => _SusunJadwalCardState();
}

class _SusunJadwalCardState extends State<SusunJadwalCard> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          NavApp(
            current: "SusunJadwal",
            currContext: context,
          ),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.assignment_rounded),
                hintText: "Add task..."),
            onSubmitted: (text) {
              controller.clear();
            },
          ),
          Expanded(
            // margin: const EdgeInsets.all(20),
            child: FutureBuilder(
              future: Matkul.getMatkuls(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                    child: const Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].namaUDD),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SusunJadwalItemCard extends StatelessWidget {
  final String SusunJadwalName;

  const SusunJadwalItemCard({Key? key, required this.SusunJadwalName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      SusunJadwalName,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        color: Color(0xffa9d4d9),
        child: SizedBox(
          height: 50,
          child: Text("Test"),
        ),
      ),
    );
  }
}
