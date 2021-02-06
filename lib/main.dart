import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imperoitdemo/Global/mycolors.dart';
import 'package:imperoitdemo/pages/productlistfile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

      statusBarColor:MyColors.primaryColor

    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Impero Demo Mayank',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        primaryColor: MyColors.primaryColor,
        dividerColor: MyColors.primaryColor,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:ProductListFile(),
    );
  }
}

