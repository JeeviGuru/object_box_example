import 'package:flutter/material.dart';
import 'package:keep_notes_lite/database/object_box.dart';
import 'package:keep_notes_lite/pages/home_page.dart';

late ObjectBox objectbox;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Keep Notes',
      home: HomePage(),
    );
  }
}
