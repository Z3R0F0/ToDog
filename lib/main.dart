import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled7/view/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFFFFFFFF), // navigation bar color
    statusBarColor: Color(0xFFFFFFFF), // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark, // 2
        ),

        fontFamily: 'Manrope',
      ),
      home: HomeView(),
    );
  }
}
