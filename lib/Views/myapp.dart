import 'package:flutter/material.dart';
import 'package:google_map/Views/tappedMap.dart';

import 'googleNaksho.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Location(),
    );
  }
}
