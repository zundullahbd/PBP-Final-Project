import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tugas_akhir_f03/universal/navbar.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String questions = '';
  final String answers = '';

  Future<void> addDataIP() async {
    const url =
        'https://pbp-midtermproject-f03.herokuapp.com/quiz-of-pandemic/1/data';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'Questions': questions,
            'answer': answers,
          }));
      print(jsonDecode(response.body));
      Map<String, dynamic> data = jsonDecode(response.body);

      print(data['message']);
    } catch (p) {
      print(p);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        title: const Text('Quiz List'),
        backgroundColor: const Color(0xFF5F9EA0),
      ),
      body: Center(
        child: FutureBuilder<void>(
          //future: quizes,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return const CircularProgressIndicator();
            // Render employee lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      data.ename,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
