// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, annotate_overrides, use_key_in_widget_constructors, unused_local_variable, unnecessary_this
import 'package:flutter/material.dart';
import 'package:tugas_akhir_f03/universal/navbar.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const AddTipsKesehatan());
}

Color c = const Color(0xFF5F9EA0);

class AddTipsKesehatan extends StatelessWidget {
  const AddTipsKesehatan({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Covid-19 Data',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     colorScheme: ColorScheme.fromSwatch(
    //       primarySwatch: Colors.teal,
    //     ).copyWith(
    //       secondary: Colors.green,
    //     ),
    //     canvasColor: const Color(0xFFF0F8FF),
    //     textTheme: const TextTheme(
    //       bodyText2: TextStyle(color: Color(0xFF000000), fontSize: 30),
    //       headline4: TextStyle(color: Color(0xFF800000), fontSize: 17),
    //       headline6: TextStyle(color: Color(0xFF000000), fontSize: 15),
    //     ),
    //   ),
    //   home: const MyHomePage(title: 'Covid-19 Data'),
    // );
    return const MyHomePage(title: 'Forum Pandemi');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = 'PILIH FORUM';
  EdgeInsets top = const EdgeInsets.only(top: 20.0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Form(
      key: _formKey,
      child: ListView(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          NavApp(
            current: "Forum Pandemi",
            currContext: context,
          ),
          const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Pilih Sebuah Forum!',
            textAlign: TextAlign.center,
            // ignore: unnecessary_const
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:15, bottom: 20, right: 20, top:10), //apply padding to some sides only
            child: Text(
              "Your local Date and Time: \n ${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}:${now.second}",
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: new ButtonBar(
                    buttonMinWidth: 300.0,
                    buttonHeight: 75.0,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height:60, //height of button
                        width:300, //width of button
                        child: ElevatedButton(
                        child: new Text('Add Info Pandemi'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyanAccent.shade700, //background color of button
                          side: BorderSide(width:0.5, color:Colors.black),
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(13),
                          ),
                          padding: EdgeInsets.all(20) //content padding inside button
                        ),
                        onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyCustomForm()),
                        );
                        final snackBar = SnackBar(
                          content: const Text('#INFOPANDEMINIHGAN'),
                          // action: SnackBarAction(
                          //   label: 'Undo',
                          //   onPressed: () {
                          //     // Some code to undo the change.
                          //   },
                          // ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },                        
                        ),
                      ),
                      SizedBox(
                        height:60, //height of button
                        width:300, //width of button
                        child: ElevatedButton(
                        child: new Text('Add Tips Kesehatan'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyanAccent.shade700, //background color of button
                          side: BorderSide(width:0.5, color:Colors.black),
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(20) //content padding inside button
                        ),
                        onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyCustomForm()),
                        );
                        final snackBar = SnackBar(
                          content: const Text('#NIHTIPSKESEHATAN'),
                          // action: SnackBarAction(
                          //   label: 'Undo',
                          //   onPressed: () {
                          //     // Some code to undo the change.
                          //   },
                          // ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },                        
                        ),  
                      ),
                      SizedBox(
                        height:60, //height of button
                        width:300, //width of button
                        child: ElevatedButton(
                        child: new Text('Add Curahan Hati'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyanAccent.shade700, //background color of button
                          side: BorderSide(width:0.5, color:Colors.black),
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(20) //content padding inside button
                        ),
                        onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyCustomForm()),
                        );
                        final snackBar = SnackBar(
                          content: const Text('#MAUCURHATDONGKAK'),
                          // action: SnackBarAction(
                          //   label: 'Undo',
                          //   onPressed: () {
                          //     // Some code to undo the change.
                          //   },
                          // ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },                        
                        ),  
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    ));
  }
}

class MyCustomForm extends StatefulWidget {  
  @override  
  MyCustomFormState createState() {  
    return MyCustomFormState();  
  }  
}  
// Create a corresponding State class. This class holds data related to the form.  
class MyCustomFormState extends State<MyCustomForm> {  
  // Create a global key that uniquely identifies the Form widget  
  // and allows validation of the form.  
  final _formKey = GlobalKey<FormState>();  
  
  @override  
  Widget build(BuildContext context) {  
    // Build a Form widget using the _formKey created above.  
    DateTime now = new DateTime.now();
    return Form(  
      key: _formKey,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: <Widget>[  
          Padding(
            padding: EdgeInsets.only(left:15, bottom: 20, right: 20, top:10), //apply padding to some sides only
            child: Text(
              "Your local Date and Time: \n ${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}:${now.second}",
              textAlign: TextAlign.center,
            ),
          ),
          TextFormField(  
            decoration: const InputDecoration(  
              icon: const Icon(Icons.person),  
              hintText: 'Enter your name',  
              labelText: 'Name',  
            ),  
            validator: (value) {  
              if (value!.isEmpty) {  
                return 'Please enter some text';  
              }  
              return null;  
            },  
          ),  
          TextFormField(  
            decoration: const InputDecoration(  
              icon: const Icon(Icons.phone),  
              hintText: 'Enter a phone number',  
              labelText: 'Phone',  
            ),
            validator: (value) {  
              if (value!.isEmpty) {  
                return 'Please enter some text';  
              }  
              return null;  
            },    
          ),  
          TextFormField(  
            decoration: const InputDecoration(  
            icon: const Icon(Icons.calendar_today),  
            hintText: 'Enter your date of birth',  
            labelText: 'Dob',  
            ), 
            validator: (value) {  
              if (value!.isEmpty) {  
                return 'Please enter some text';  
              }  
              return null;  
            },   
          ),  
          new Container(  
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),  
              child: new RaisedButton(  
                child: const Text('Submit'),  
                  onPressed: null,  
              )),  
        ],  
      ),  
    );  
  }  
}  