import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'screens/tabs_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  runApp(MyApp(firstCamera));
}

class MyApp extends StatelessWidget {

  MyApp(this.camera);

  CameraDescription camera;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product_Category',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber,
          primaryColorLight: Colors.white,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: TabsScreen(camera),
    );
  }


}
