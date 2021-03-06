import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'AllCities.dart';
import 'WeatherData.dart';
 Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      home: MyHomePage(),
      theme: ThemeData.dark(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Timer(Duration(seconds:3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:

                (context) =>CityWeather()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.black87,
      child: Column(
        children: [
          SizedBox(height: 200,),
          Container(
              child:CircleAvatar(backgroundImage:AssetImage('assets/Image/logo.png'),radius: 100,)

          )
          , SizedBox(height: 60,)
          ,Text('Done By Afnan Abu-saleem',
            style: TextStyle(
              inherit: false,
              color: Colors.blue,
              fontSize: 20,
            ),)
        ],
      ),
    );
  }
}