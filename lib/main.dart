import 'package:flutter/material.dart';
import 'package:untitled/page/HomePage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(), // หรือหน้าที่คุณต้องการใช้เป็นหน้าเริ่มต้น
    );
  }
}
