import 'package:flutter/material.dart';
import 'package:sql_flutter/Model/TableModel.dart';
import 'package:sql_flutter/helper.dart';

class AllTablesPage extends StatefulWidget {
  AllTablesPage({Key? key}) : super(key: key);

  @override
  State<AllTablesPage> createState() => _AllTablesPageState();
}

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
    print(_tablesName[1].tableCreationDate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Tables"),
        elevation: 0,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _tablesName.length,
            shrinkWrap: true,
            itemBuilder: (itemBuilder, index) {
              return ListTile(
                title: Text(_tablesName[index].tableName.toString()),
              );
            }),
      ),
    );
  }
}
