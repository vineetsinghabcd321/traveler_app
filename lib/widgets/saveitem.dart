import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:traveler_app/utils/data.dart';
import 'package:traveler_app/utils/tourists_place.dart' as tp;
import 'package:traveler_app/google_map/tourists_place.dart' as place_map;

class SavedItem extends StatefulWidget {
  const SavedItem({Key? key}) : super(key: key);

  @override
  _SavedItemState createState() => _SavedItemState();
}

class _SavedItemState extends State<SavedItem> {
  double currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final totalDots = data.length;

    return SizedBox(
      height: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                final Map datar = data[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: AssetImage(datar['saved']),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              child: Center(
                                child: Icon(
                                  Ionicons.bookmark_outline,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 12,
                            bottom: 12,
                            right: 12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  datar['city'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Ubuntu-Regular',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  datar['places'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu-Regular',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () async {
                                    Map<String, dynamic>? match;
                                    try {
                                      match = tp.touristsPlace.firstWhere(
                                        (p) {
                                          final cityMatch = (p['city'] ?? '')
                                                  .toString()
                                                  .toLowerCase()
                                                  .trim() ==
                                              (datar['city'] ?? '')
                                                  .toString()
                                                  .toLowerCase()
                                                  .trim();
                                          final nameMatch = (p['name'] ?? '')
                                                  .toString()
                                                  .toLowerCase()
                                                  .trim() ==
                                              (datar['places'] ?? '')
                                                  .toString()
                                                  .toLowerCase()
                                                  .trim();
                                          return cityMatch || nameMatch;
                                        },
                                      ) as Map<String, dynamic>?;
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
                                        const SnackBar(
                                            content: Text(
                                                'Location details not available')),
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Iconsax.location,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        datar['location'] ?? '',
                                        style: const TextStyle(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0, left: 12.0),
            child: DotsIndicator(
              dotsCount: totalDots > 0 ? totalDots : 1,
              position: currentPosition,
              decorator: DotsDecorator(
                activeColor: Colors.red,
                size: const Size.square(8.0),
                spacing: const EdgeInsets.only(left: 6),
                activeSize: const Size(16.0, 8.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
