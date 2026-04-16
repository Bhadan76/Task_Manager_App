
import 'package:flutter/material.dart';
import 'package:flutter_practic/alert.dart';
import 'package:flutter_practic/home.dart';
import 'package:flutter_practic/icon.dart';
import 'package:flutter_practic/image_login_form.dart';
import 'package:flutter_practic/input_filed_create.dart';
import 'package:flutter_practic/list_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: alert(),

    
    );
  }
}