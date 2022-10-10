import 'package:android_mac_file_transfer/list_devices.dart';
import 'package:flutter/material.dart';
import 'find_devices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: const Color(0x00282830),
      ),
      home: const FindDevices(),
    );
  }
}
