import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:traveler_app/utils/data.dart';
<<<<<<< HEAD
import 'package:traveler_app/utils/tourists_place.dart' as tp;
import 'package:traveler_app/google_map/tourists_place.dart' as place_map;
=======
>>>>>>> 0a6ca41 (Initial commit)

class SavedItem extends StatefulWidget {
  @override
  _SavedItemState createState() => _SavedItemState();
}

class _SavedItemState extends State<SavedItem> {
  @override
  Widget build(BuildContext context) {
    final totalDots = 4;
    double currentPosition = 0.0;

    return Container(
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                Map datar = data[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
<<<<<<< HEAD
                      Container(
                        width: 250,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            opacity: 2,
                            filterQuality: FilterQuality.high,
                            image: AssetImage(datar['saved']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Ionicons.bookmark_outline,
                                        size: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 25.0,
                                  horizontal: 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      datar['city'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Ubuntu-Regular',
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      datar['places'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Ubuntu-Regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // try to find a matching place in touristsPlace by city or place name
                                            Map<String, dynamic>? match;
                                            try {
                                              match = tp.touristsPlace
                                                  .firstWhere((p) {
                                                final cityMatch =
                                                    p['city'] != null &&
                                                        p['city']
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim() ==
                                                            datar['city']
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim();
                                                final nameMatch =
                                                    p['name'] != null &&
                                                        p['name']
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim() ==
                                                            datar['places']
                                                                .toString()
                                                                .toLowerCase()
                                                                .trim();
                                                return cityMatch || nameMatch;
                                              }) as Map<String, dynamic>?;
                                            } catch (e) {
                                              match = null;
                                            }

                                            if (match != null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      place_map.PlaceMapPage(
                                                          place: match!),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Location details not available')),
                                              );
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Iconsax.location,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                datar['location'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Ubuntu-Regular',
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
=======
                      Expanded(
                        child: Container(
                          width: 250,
                          height: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              opacity: 2,
                              filterQuality: FilterQuality.high,
                              image: AssetImage(datar['saved']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 30.0,
                                      width: 30.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Ionicons.bookmark_outline,
                                          size: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        datar['city'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Ubuntu-Regular',
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        datar['places'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Ubuntu-Regular',
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(
                                            Iconsax.location,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            datar['location'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Ubuntu-Regular',
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
>>>>>>> 0a6ca41 (Initial commit)
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: DotsIndicator(
              dotsCount: totalDots,
              position: currentPosition,
              decorator: DotsDecorator(
                activeColor: Colors.red,
                size: Size.square(10.0),
                spacing: EdgeInsets.only(left: 5),
                activeSize: Size(20.0, 10.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
