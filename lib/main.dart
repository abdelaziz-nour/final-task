import 'package:final_task/casesPage.dart';
import 'package:final_task/firebase_options.dart';
import 'package:final_task/loginPage.dart';
import 'package:final_task/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

 void main() {
   
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home:  Welcome(),
    );
  }
}

