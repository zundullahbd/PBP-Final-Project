import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class ToDoData {
  int author;
  String title;
  String description;
  bool is_completed;

  ToDoData ({
    this.author = 0,
    required this.title,
    this.description = " ",
    this.is_completed = false,
  });

  factory ToDoData.fromJson(Map<String, dynamic> json) {
    return ToDoData(
        author: json['author'] ?? 0,
        title: json['title'],
        description: json['description'],
        is_completed: json['is_completed']);
  }

  dynamic toJson() => {'author': author, 'title': title, 'description': description, 'is_completed': false};

  static Future<List<ToDoData>> getToDos() async {
    // var url = "http://127.0.0.1:8000/to-do-list/json/";
    // var url = "http://10.0.2.2:8000/to-do-list/json/";
    var url = "https://pbp-midtermproject-f03.herokuapp.com/to-do-list/json/";

    var result = await http.get(Uri.parse(url));
    var jsonObj = json.decode(result.body); // list of map? // string?

    List<dynamic> jsonObjList = jsonObj as List<dynamic>;

    List<ToDoData> toDos = [];
    for(int i=0; i<jsonObjList.length; i++){
      toDos.add(ToDoData.fromJson(jsonObjList[i]["fields"]));
    }

    return toDos;
  }
}