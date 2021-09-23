import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'FavoriteCities.dart';
import 'ApiWeather.dart';
class DetailScreen extends StatefulWidget {
  final int cityID;
  DetailScreen(this.cityID);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}
class _DetailScreenState extends State<DetailScreen> {
  String weatherInfo='';
  DateTime selectedDate=DateTime.now();
  Map<String,dynamic>getWeatherSplit(){
    Map<String,dynamic>info=new Map<String,dynamic>();
    List<String>information=weatherInfo.split(',');
    for(String item in information)info.addAll({item.split(':')[0]:item.split(':')[1]});
    return info;}
  @override
  Widget build(BuildContext context) {
    CollectionReference faverites=FirebaseFirestore.instance.collection('CityFavorite');
    return Scaffold(
      appBar: AppBar(

          actions: [
            IconButton(onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FavoriteCity())), icon: Icon(Icons.star_border,color: Colors.yellow))
          ],

      ),
      body: FutureBuilder(
        future: getWeather(this.widget.cityID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text('${snapshot.error} has occurred.'),
            );
          else if (snapshot.hasData) {
            final Weather weather = snapshot.data as Weather;

            return Container(
                width: double.infinity,
                color: Colors.black,
                child: Column(

                    children: [
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(height: 100,
                                  child: Image.asset('assets/Image/logo.png')),
                              SizedBox(height: 100,),
                              IconButton(onPressed: (){faverites.add(getWeatherSplit());},
                                  icon: Icon(Icons.favorite,color: Colors.red,)),
                              SizedBox(height: 10,),
                              ListTile(title: Text(
                                'Name:${weather.name}',),),
                              ListTile(title: Text( 'Temp:${weather.main.temp} ',),leading: Icon(Icons.thermostat_rounded,color: Colors.red,),),
                              ListTile(title: Text(' FeelsLike:${weather.main.feelsLike } ',),leading: Icon(Icons.ac_unit,color: Colors.grey,),),
                              ListTile(title: Text('  Humidity:${weather.main.humidity}',),leading: Icon(Icons.wb_sunny,color: Colors.yellow,),),
                               ListTile(title: Text('DateOfAdding:${selectedDate}',),leading: Icon(Icons.date_range,color: Colors.red,),),

                             ],
                          ),
                        ),
                      )]));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}