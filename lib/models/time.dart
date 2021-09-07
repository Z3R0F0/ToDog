/*
import 'dart:async';
import 'package:flutter/material.dart';

class FlutterTime extends StatefulWidget {
  @override
  FlutterTimeState createState() => FlutterTimeState();
}

class FlutterTimeState extends State<FlutterTime> {
  static String timeString = '';

  @override
  void initState() {
    timeString = "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
    Timer.periodic(Duration(seconds: 1), (Timer t) => currentTime());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }

  void currentTime() {
    setState(() {
      timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    });
  }
}
*/
