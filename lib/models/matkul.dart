import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Matkul {
  int author;
  String name;
  String day;
  String start_time;
  String end_time;

  Matkul ({
    required this.author,
    required this.name,
    required this.day,
    required this.start_time,
    required this.end_time,
  });

  factory Matkul.fromJson(Map<String, dynamic> json) {
    return Matkul(
      author: json['author'] == null ? 0 : json['author'],
      name: json['name'],
      day: json['day'],
      start_time: json['start_time'],
      end_time: json['end_time'],
    );
  }

  dynamic toJson() => {
    'author': author, 'name': name, 'day': day, 'start_time': start_time, 'end_time' : end_time,
  };


  static Future<List<Matkul>> getMatkuls() async {
    var data = await http.get(Uri.parse('https://pbp-midtermproject-f03.herokuapp.com/susun-jadwal-matkul/json/'));
    var jsonData = json.decode(data.body);

    List<dynamic> jsonObject = jsonData as List<dynamic>;

    List<Matkul> matkuls = [];
    for (int i = 0; i <jsonObject.length; i++){
      matkuls.add(Matkul.fromJson(jsonObject[i]["fields"]));
    }

    print(matkuls.length);
    print("Text");

    return matkuls;
  }
}