import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tugas_akhir_f03/task.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ToDoListPage extends StatelessWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoListList(),
    );
  }
}

class ToDoListList extends StatefulWidget {
  const ToDoListList({Key? key}) : super(key: key);

  @override
  _ToDoListListState createState() => _ToDoListListState();
}

class _ToDoListListState extends State<ToDoListList> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<ToDoData> lst = [];

    return Scaffold(
      body: Column(
        children: <Widget>[
          NavApp(current: "To-Do List", currContext: context),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.assignment_rounded),
                hintText: "Add task..."),
            onSubmitted: (text) {
              setState(() {
                addToDoItem(text, lst);
              });
              controller.clear();
            },
          ),
          Expanded(
            // margin: const EdgeInsets.all(20),
            child: FutureBuilder(
              future: ToDoData.getToDos(),
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
                        // lst.add(snapshot.data[index]);
                        return Column(children: [ToDoCard(
                            title: snapshot.data[index].title)
                        ],);
                      });
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}

class ToDoCard extends StatefulWidget {
  String title;
  final TextEditingController controller = TextEditingController();

  ToDoCard({Key? key, required this.title}) : super(key: key);

  @override
  _ToDoCardState createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color(0xffa9d4d9),
        child: InkWell(
          splashColor: Colors.lightBlue.withAlpha(30),
          onTap: () {
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  children: [
                    Form(child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8), child: TextFormField(
                          initialValue: widget.title , decoration: const InputDecoration(labelText: "To Do:"),
                        ),),
                        Padding(padding: EdgeInsets.all(8),
                          child: TextFormField(decoration: const InputDecoration(
                              labelText: "Description"),),),
                        Padding(padding: EdgeInsets.all(8),
                            child: MyCheckBox()),
                        Padding(padding: EdgeInsets.all(8),
                          child: TextButton(
                            child: const Text("Save"), onPressed: () {
                            Navigator.pop(context);
                            // close alert dialog
                          },),)
                      ],
                    ))
                  ],
                ),
              );
            });
          },
          child: SizedBox(height: 50, child: Center(child: Text(widget.title),),),
        ),
      ),
    );
  }
}

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({Key? key}) : super(key: key);

  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      // if (states.any(interactiveStates.contains)) {
      //   return Colors.blue;
      // }
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}



Future<void> addToDoItem(String title, List<ToDoData> lst) async {
  // newData ngga berhasil ke-add ke django karena
  // kayaknya pengecekan is_valid() nya false.
  final newData = ToDoData(author: 0, title: title, description: "...", is_completed: false);

  // const url = "http://10.0.2.2:8000/to-do-list/from-dart/";
  const url = "http://pbp-midtermproject-f03.herokuapp.com/to-do-list/from-dart/";

  final response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(newData));

  if (response.statusCode == 200) {
    if (response.body.isNotEmpty) {
      newData.author = json.decode(response.body)['author'];
      // print(response.body);
    }
    // lst.add(newData);
  }
  // print(lst);
}

/*
Sources:
References:
- https://medium.com/@DakshHub/flutter-displaying-dynamic-contents-using-listview-builder-f2cedb1a19fb
- https://stackoverflow.com/questions/54480641/flutter-how-to-create-forms-in-popup
- https://api.flutter.dev/flutter/widgets/ListView-class.html
- https://api.flutter.dev/flutter/material/Card-class.html
- https://www.youtube.com/watch?v=qp9KtPQBa8Y
- https://www.youtube.com/watch?v=aHT7v_4UBtA
- https://www.youtube.com/watch?v=O7yaoGRNY2E
- https://api.flutter.dev/flutter/material/Checkbox-class.html
- https://stackoverflow.com/questions/50287995/passing-data-to-statefulwidget-and-accessing-it-in-its-state-in-flutter
- https://github.com/ReeceRose/django-flutter-todo
 */
