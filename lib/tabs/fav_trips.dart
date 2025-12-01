import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
//import 'package:traveler_app/utils/data.dart';
import 'package:traveler_app/utils/tourists_place.dart';

class FavoriteTrips extends StatefulWidget {
  @override
  _FavoriteTripsState createState() => _FavoriteTripsState();
}

class _FavoriteTripsState extends State<FavoriteTrips> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(Icons.sentiment_very_satisfied),
        iconSize: 100,
        onPressed: () {},
      ),
    );
  }
}

// Moved MyTrips implementation here (copied from lib/tabs/mytrips.dart)
class MyTrips extends StatefulWidget {
  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: touristsPlace.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> datar = touristsPlace[index];
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 30,
                  color: Colors.grey[200],
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Network image with loading and error handling
                      Image.network(
                        datar['imageUrl'] ?? '',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: SizedBox(
                              width: 36,
                              height: 36,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          // show a placeholder and log the error
                          debugPrint(
                              'Image load error: ${datar['imageUrl']} -> $error');
                          return Container(
                            color: Colors.grey[300],
                            alignment: Alignment.center,
                            child: Icon(Icons.broken_image,
                                size: 48, color: Colors.grey[600]),
                          );
                        },
                      ),

                      // overlay content (top-left, top-right, bottom-right)
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.location,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      datar['name'] ?? '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontFamily: 'Ubuntu-Regular',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    Random().nextInt(2000).toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Ubuntu-Regular',
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'likes',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Ubuntu-Regular',
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Ionicons.heart,
                                    size: 15,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.share,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    datar['city'] ?? '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Ubuntu-Regular',
                                    ),
                                  ),
                                  Text(
                                    '13 DAYS / 14 NIGHTS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Ubuntu-Regular',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                datar['name'] ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu-Regular',
                ),
              ),
              Text(
                datar['description'] ?? '',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontFamily: 'Ubuntu-Regular',
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Ubuntu-Regular',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Resort',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Ubuntu-Regular',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Adventure',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Ubuntu-Regular',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'Travellers',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: 'Ubuntu-Regular',
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 50,
                child: ListView.builder(
                  itemCount: min(5, touristsPlace.length),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> visitor = touristsPlace[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(77),
                              offset: new Offset(0.0, 0.0),
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ClipOval(
                            child: visitor['imageUrl'] != null &&
                                    visitor['imageUrl'].toString().isNotEmpty
                                ? Image.network(
                                    visitor['imageUrl'],
                                    width: 36,
                                    height: 36,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) {
                                      debugPrint(
                                          'Avatar load error: ${visitor['imageUrl']} -> $e');
                                      return Container(
                                        width: 36,
                                        height: 36,
                                        color: Colors.grey[300],
                                        child: Icon(Icons.person,
                                            size: 20, color: Colors.grey[700]),
                                      );
                                    },
                                  )
                                : Container(
                                    width: 36,
                                    height: 36,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.person,
                                        size: 20, color: Colors.grey[700]),
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
