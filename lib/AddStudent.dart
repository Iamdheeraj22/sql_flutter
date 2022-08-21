import 'package:flutter/material.dart';
import 'package:sql_flutter/CustomUi.dart';
import 'package:sql_flutter/helper.dart';

class AddStudentPage extends StatefulWidget {
  AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudentPage> {
  var student_name = "";
  var student_class = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (student_name.isEmpty) {
            showInSnackBar("What's student name", context);
            return;
          }
          if (student_class.isEmpty) {
            showInSnackBar("Which class standred", context);
            return;
          }
          _addItem();
        },
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Add new student",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(children: [
          //student name
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    student_name = value.toString();
                  });
                },
                decoration: const InputDecoration(
                    hintText: "What's student name",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 10, right: 10)),
              )),
          //Student class
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    student_class = value.toString();
                  });
                },
                decoration: const InputDecoration(
                    hintText: "Which class standred",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 10, right: 10)),
              )),
        ]),
      ),
    );
  }

  Future<void> _addItem() async {
    await SqlHelper.createItem(student_name, student_class);
    print("----------------------");
    Navigator.pop(context);
  }
}
