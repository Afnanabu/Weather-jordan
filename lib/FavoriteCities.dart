import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
  class FavoriteCity extends StatefulWidget {
  @override
  _FavoriteCityState createState() => _FavoriteCityState();
}

class _FavoriteCityState extends State<FavoriteCity> {
  final Favorite favoriteCities = Favorite();
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('CityFavorite').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              var weatherInformation = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Card(
                        color: Colors.black,
                         elevation: 29,
                        child: Center(
                          child: Column(
                            children: [
                            IconButton(onPressed: null, icon: Icon(Icons.wb_sunny,color: Colors.yellow,)),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance.collection('CityFavorite').doc( weatherInformation[index].id).delete();
                                          deletedToast( weatherInformation, index);
                                        },
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Text(
                                  'Name: ${ weatherInformation[index].data().toString().split(',')[1].split(':')[1]}',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ) ,
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  'Temperature : ${ weatherInformation[index].get('Temp').toString()} C',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Text(
                                  'Weather Pressure: ${ weatherInformation[index].data().toString().split(',')[2].split(':')[1]}',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                              ) ,
                              Padding(
                                  padding: EdgeInsets.only(bottom: 15, left: 140),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'DateOfAdding : ${ weatherInformation[index].data().toString().split(',')[1].split(':')[1]}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 15),
                                      ),
                                    ],
                                  ))
                              ],
                          ),
                        ),
                      ),);
                  });
            }
          }
          return Center(
            child: Column(children: [
              Text(
                'You don\'t added cities to favorite yet',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ], mainAxisAlignment: MainAxisAlignment.center),
          );
        },
      ),
    );
  }

  void deletedToast(List<QueryDocumentSnapshot<Object?>> weatherInfo , int index) {
    Fluttertoast.showToast(
        msg:
        '${weatherInfo [index]['name']} Deleted',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM);
  }
}


class Favorite {
  Favorite(
      {
        this.temp,
         this. humidity,
        this.pressure,
        this.dateOfAdding
      });
  int? pressure;
  int? humidity;
  double?temp;
   String?dateOfAdding;
  }


