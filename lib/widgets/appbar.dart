import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:traveler_app/screens/profile.dart';
import 'package:traveler_app/utils/tourists_place.dart';

// A simple SearchDelegate that searches `touristsPlace` by name or city.
class PlaceSearchDelegate extends SearchDelegate<Map<String, dynamic>?> {
  PlaceSearchDelegate() : super(searchFieldLabel: 'Search places...');

  List<Map<String, dynamic>> _filter(String query) {
    final q = query.toLowerCase();
    return touristsPlace.where((p) {
      final name = (p['name'] ?? '').toString().toLowerCase();
      final city = (p['city'] ?? '').toString().toLowerCase();
      return name.contains(q) || city.contains(q);
    }).toList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Try searching for "Taj Mahal"'));
    }
    final results = _filter(query);
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: item['imageUrl'] != null
              ? SizedBox(
                  width: 56,
                  height: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      item['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                )
              : null,
          title: Text(item['name'] ?? ''),
          subtitle: Text(item['city'] ?? ''),
          onTap: () => close(context, item),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _filter(query);
    if (results.isEmpty) return Center(child: Text('No results for "$query"'));
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, __) => Divider(height: 1),
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: item['imageUrl'] != null
              ? SizedBox(
                  width: 72,
                  height: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      item['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) =>
                          Container(color: Colors.grey[300]),
                    ),
                  ),
                )
              : null,
          title: Text(item['name'] ?? ''),
          subtitle: Text(item['description'] ?? item['city'] ?? ''),
          onTap: () => close(context, item),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = '',
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }
}

AppBar header(context) {
  return AppBar(
    elevation: 0.0,
    leading: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Icon(Icons.subject),
    ),
    title: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Profile(),
                ),
              );
            },
            child: CircleAvatar(
              radius: 23,
              backgroundColor: Colors.red,
              backgroundImage: AssetImage('assets/images/story/cm1.jpeg'),
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Container(
              height: 35.0,
              // width: 200.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    SizedBox(width: 3),
                    Icon(
                      Iconsax.search_normal,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: () async {
                          final result =
                              await showSearch<Map<String, dynamic>?>(
                            context: context,
                            delegate: PlaceSearchDelegate(),
                          );
                          if (result != null) {
                            // Open a simple detail page or show a dialog with info
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(result['name'] ?? ''),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (result['imageUrl'] != null)
                                      SizedBox(
                                        height: 120,
                                        width: double.infinity,
                                        child: Image.network(result['imageUrl'],
                                            fit: BoxFit.cover,
                                            errorBuilder: (c, e, s) =>
                                                Container(
                                                    color: Colors.grey[300])),
                                      ),
                                    SizedBox(height: 8),
                                    Text(result['city'] ?? ''),
                                    SizedBox(height: 8),
                                    Text(result['description'] ?? ''),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Close')),
                                ],
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Search...',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.black54),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    actions: [
      InkWell(
        onTap: () => print('tapped!'),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 10),
          child: Stack(
            children: <Widget>[
              Icon(
                Iconsax.notification,
                size: 30,
                //  color: Colors.black,
              ),
              Positioned(
                top: 5,
                right: 1,
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
                    padding: const EdgeInsets.all(0.5),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
