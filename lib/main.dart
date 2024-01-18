import 'package:advance_app/models/expensce.dart';
import 'package:advance_app/pages/expensve.dart';
import 'package:advance_app/server/category_adpter.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenceModelAdapter());
  Hive.registerAdapter(CategoryAdpter());
  await Hive.openBox('expensvebox');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Expensve(),
    );
  }
}
