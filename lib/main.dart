import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutapha/screen/category.dart';
import 'package:mutapha/screen/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MaterialApp(
      title: 'Team Muphtah',
      debugShowCheckedModeBanner: false,
      home: Splash(),
    ),
  );

}
