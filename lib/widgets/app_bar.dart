import 'package:flutter/material.dart';
import 'package:learning/Screens/location_screen.dart';
import '../provider/search_delegate.dart';

List<String> e = [
  'Mad House party',
  'New Years eve',
  'Cocaine Party',
  'StonersAnonymous',
  'party1',
  'party2',
  'party3'
];

class UnplugAppBar extends StatelessWidget {
  String location;String mainHeading;

  UnplugAppBar(this.mainHeading,this.location);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 12,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(bottom: Radius.elliptical(50, 20))),
      bottom: PreferredSize(child:Text(
              location ==null?"":"You are in $location",
              style: TextStyle(color: Colors.cyanAccent,
                  fontSize: 20, fontFamily: 'BebasNeue', letterSpacing: 1),
            ),

          preferredSize: null),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            color: Colors.cyan,
            iconSize: 50,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate(e));
            })
      ],
      title: Center(
          child: Text(
        mainHeading,
        style:
            TextStyle(color: Colors.purpleAccent,fontSize: 30, letterSpacing: 0.5, fontFamily: 'Monoton'),
      )),
      backgroundColor: Colors.white10,
    );
  }


}
