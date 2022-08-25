import 'package:flutter/material.dart';
import 'package:sql_flutter/CustomUi.dart';
import 'package:sql_flutter/Model/TableModel.dart';
import 'package:sql_flutter/Pages/CreateTablePage.dart';
import 'package:sql_flutter/Pages/TableAllRowsDetailsPage.dart';
import 'package:sql_flutter/helper.dart';

class AllTablesPage extends StatefulWidget {
  String title = "";
  AllTablesPage({Key? key, required this.title}) : super(key: key);

  @override
  State<AllTablesPage> createState() => _AllTablesPageState();
}

//TableAllRowsDetailsPage.dart
class _AllTablesPageState extends State<AllTablesPage> {
  List<TableModel> _tablesName = [];
  @override
  void initState() {
    super.initState();
    getTables();
  }

  getTables() async {
    final getAllTableName = await SqlHelper.getAllTableNames();
    _tablesName = getAllTableName;
    setState(() {});
  }

  //CreateTablePage.dart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //CreateTablePage
          Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => CreateTablePage()))
              .then((value) => getTables());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
            itemCount: _tablesName.length,
            shrinkWrap: true,
            itemBuilder: (itemBuilder, index) {
              return Container(
                  margin:
                      EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Stack(
                    children: [
                      Text(
                        _tablesName[index].tableName.toString().toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      _tablesName[index].tableName.toString() ==
                                  "android_metadata" ||
                              _tablesName[index].tableName.toString() ==
                                  "sqlite_sequence"
                          ? Container()
                          : Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  TableAllRowsDetailsPage(
                                                    tableName:
                                                        _tablesName[index]
                                                            .tableName
                                                            .toString(),
                                                  )));
                                    },
                                    child: const Text(
                                      "Show",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      deleteDialogBox(
                                        _tablesName[index].tableName.toString(),
                                      );
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ))
                    ],
                  ));
            }),
      ),
    );
  }

  deleteDialogBox(String title) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Delete caution"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Do you want to be " + title.toString() + " table?",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            deleteStudentDetail(title);
                          },
                          child: Text("Delete")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel")),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void deleteStudentDetail(String title) async {
    await SqlHelper.deleteTableItem(title.toString());
    Navigator.pop(context);
    showInSnackBar("Student deleted successfully", context);
    getTables();
    setState(() {});
  }
}
