import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_page.dart';

void main() async {
  //init Hive
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //await/reference box
  var box = await Hive.openBox('mybox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 107, 44, 218),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 107, 44, 218)),
      ),
      home: homePage(),
    );
  }
}
