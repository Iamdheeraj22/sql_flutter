// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sql_flutter/Model/DatabaseModel.dart';
import 'package:sql_flutter/Pages/AddStudentPage.dart';
import 'package:sql_flutter/Pages/AllTablesPage.dart';
import 'package:sql_flutter/CustomUi.dart';
import 'package:sql_flutter/Pages/StudentDetailsPage.dart';
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
      home: AllTablesPage(title: 'Database Manager'),
    );
  }
}
