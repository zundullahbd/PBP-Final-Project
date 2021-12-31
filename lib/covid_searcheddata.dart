// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: prefer_const_constructors

// inspirasi Card dan penampilan data dari JSON : https://www.youtube.com/watch?v=Fo04xk9gIFo
import 'package:flutter/material.dart';
import 'package:tugas_akhir_f03/covid_data.dart';

void main() {
  runApp(SearchedData(
    data: {'': ''},
    length: 2,
  ));
}

class DataCard {
  late String provinsi;
  late int positif;
  late int sembuh;
  late int meninggal;

  DataCard(this.provinsi, this.positif, this.sembuh, this.meninggal);
  DataCard.fromJson(Map<String, dynamic> json) {
    provinsi = json['provinsi'];
    positif = json['kasus_positif'];
    sembuh = json['kasus_sembuh'];
    meninggal = json['kasus_meninggal'];
  }
}

class SearchedData extends StatefulWidget {
  int length;
  var data;
  SearchedData({Key? key, this.length = 0, required this.data})
      : super(key: key);

  @override
  _SearchedDataState createState() => _SearchedDataState();
}

class _SearchedDataState extends State<SearchedData> {
  List<DataCard> _datacards = [];

  @override
  void initState() {
    _datacards.add(DataCard.fromJson(widget.data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Searched Covid Data'),
        ),
        body: ListView.builder(
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
                        Text(
                            "Positif: " + _datacards[index].positif.toString()),
                        Text("Sembuh: " + _datacards[index].sembuh.toString()),
                        Text("Meninggal: " +
                            _datacards[index].meninggal.toString()),
                      ],
                    )));
          },
          itemCount: _datacards.length,
        ));
  }
}
