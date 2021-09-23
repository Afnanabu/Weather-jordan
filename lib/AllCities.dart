
import 'CityData.dart';
import 'package:flutter/material.dart';
 import 'FavoriteCities.dart';
import 'WeatherData.dart';
class CityWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Cities(),
    );}}
class Cities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FavoriteCity())), icon: Icon(Icons.star_border,color: Colors.yellow))


      ],),
       body: FutureBuilder(
        future:getCities(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text('${data.error}'));
          } else if (data.hasData) {
            var items = data.data as List<City>;
            return ListView.builder(itemBuilder: (context, index) {
              return InkWell(
                onTap: () =>
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            DetailScreen(items[index].id))),
                child: Card(
                  color: Colors.black45.withOpacity(0.4),
                  elevation: 70,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                      child:
                          Container(
                            child: Column(
                              children: [
                                Text(items[index].name.toString(),
                                  style: TextStyle(color: Colors.red,
                                       fontSize: 20),),
                                SizedBox(height: 10,),

                                Text('Latitude:    ${items[index].coord.lat}',
                                  style: TextStyle(color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),), Text('Longitude:    ${items[index].coord.lon}',
                                  style: TextStyle(color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),),

                              ],),)

                      ),

              );
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

}