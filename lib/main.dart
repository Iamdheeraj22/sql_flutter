import 'package:flutter/material.dart';
import 'package:sql_flutter/AddStudent.dart';
import 'package:sql_flutter/StudentDetails.dart';
import 'package:sql_flutter/helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Student Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _students = [];
  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  onRefresh() async {
    final data = await SqlHelper.getItems();
    _students = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => AddStudentPage()))
                .then((value) => onRefresh());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  return student(index);
                })));
  }

  student(int index) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      decoration: BoxDecoration(color: Colors.orange),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => StudentDetailsPage()));
        },
        title: Text(
          _students[index]['title'],
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          _students[index]['class'],
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
