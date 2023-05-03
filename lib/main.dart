import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'drag_drop_text/drag_drop_text_view.dart';
import 'screens/getx_map_drop/classification_view.dart';
import 'screens/map_drag_drop/map_drag_drop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const TextDragandDrop(),
      home: const ClassificationTextDragandDrop(),
      //home: const MapDragDropTextDragandDrop(),
    );
  }
}
