import 'package:flutter/material.dart';

class StatusTrips extends StatelessWidget {
  final String title;
  final Widget? child;

  const StatusTrips({Key? key, required this.title, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontFamily: 'Ubuntu-Regular')),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: child ?? Center(child: Text(title)),
    );
  }
}
