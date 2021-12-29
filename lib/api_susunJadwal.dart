import 'dart:convert';
import 'package:tugas_akhir_f03/models/matkul.dart';
import 'package:http/http.dart' as http;

Future<List<Matkul>?> fetchMatkul() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/susun-jadwal-matkul/matkul-list/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseItem(response.body);
  } else {
    // If the server did not return a 200 OK response,d
    // then throw an exception.
    throw Exception('Failed to load Get');
  }
}

List<Matkul>? parseItem(String responseBody) {
  final List<Matkul> matkuls = [];
  final parsed = jsonDecode(responseBody) as List<dynamic>;
  for (var e in parsed) {
    matkuls.add(Matkul.fromJson(e));
  }

  return matkuls;
}
