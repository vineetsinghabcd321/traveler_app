import 'dart:math';

//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:traveler_app/utils/data.dart';

class Whishlist extends StatefulWidget {
  @override
  _WhishlistState createState() => _WhishlistState();
}

class _WhishlistState extends State<Whishlist> {
  @override
  Widget build(BuildContext context) {
    // Show two completed trips (take last two items if available)
    final int total = data.length;
    final int start = total >= 2 ? total - 2 : 0;
    final items = data.sublist(start, total);

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final Map datar = items[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with overlay icons
              Stack(
                children: [
                  SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: datar['saved'] != null &&
                            datar['saved'].toString().isNotEmpty
                        ? Image.asset(
                            datar['saved'],
                            fit: BoxFit.cover,
                          )
                        : Container(color: Colors.grey[300]),
                  ),

                  // Top-left: location pill
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            datar['places'] ?? datar['city'] ?? '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Ubuntu-Regular'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Top-right: likes and share
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            Random().nextInt(2000).toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Ubuntu-Regular'),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.favorite,
                              size: 16, color: Colors.redAccent),
                          SizedBox(width: 8),
                          Icon(Icons.share, size: 16, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      datar['name'] ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Ubuntu-Regular'),
                    ),
                    SizedBox(height: 4),
                    Text(
                      datar['city'] ?? '',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: 'Ubuntu-Regular'),
                    ),
                    SizedBox(height: 8),
                    Text(
                      datar['location'] ?? datar['places'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 13, fontFamily: 'Ubuntu-Regular'),
                    ),

                    SizedBox(height: 12),
                    // People who visited
                    Text('People who visited',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ubuntu-Regular')),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 48,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: min(5, data.length),
                        itemBuilder: (ctx, i) {
                          final visitor = data[i];
                          final img = visitor['story'] ?? visitor['dp'] ?? '';
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage:
                                      img != '' ? AssetImage(img) : null,
                                  backgroundColor: Colors.grey[200],
                                ),
                                SizedBox(height: 4),
                                SizedBox(
                                  width: 56,
                                  child: Text(
                                    visitor['name'] ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Ubuntu-Regular'),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
