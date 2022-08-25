import 'package:flutter/material.dart';
import 'package:sql_flutter/CustomUi.dart';
import 'package:sql_flutter/helper.dart';

class CreateTablePage extends StatefulWidget {
  CreateTablePage({Key? key}) : super(key: key);
  @override
  State<CreateTablePage> createState() => _CreateTablePageState();
}

class _CreateTablePageState extends State<CreateTablePage> {
  var table_name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (table_name.isEmpty) {
            showInSnackBar("Enter table name", context);
            return;
          }
          addTable();
        },
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: Text(
          "Create new table",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        child: Column(children: [
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
                    table_name = value.toString();
                  });
                },
                decoration: const InputDecoration(
                    hintText: "What's table name",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 10, right: 10)),
              )),
        ]),
      ),
    );
  }

  addTable() async {
    await SqlHelper.createTable(table_name.toString());
    print("----------------------");
    Navigator.pop(context);
  }
}
