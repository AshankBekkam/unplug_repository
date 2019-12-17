import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learning/provider/club_details.dart';
import '../widgets/eventCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../provider/from_snapshot.dart';
import '../provider/event.dart';
import '../widgets/grid_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/app_bar.dart';
import 'expanded_event.dart';

class MyFavourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<bool> _isEvent;
    Event e;
    Club c;
    final favBox = Hive.box('favourites');

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    //favBox.clear();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(width, height / 10),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 1,
            title: Text(
              'Favourites',
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: 'Monoton',
                  fontSize: 41),
            ),
          )),
      body: Container(
          child: WatchBoxBuilder(
              box: favBox,
              builder: (context, box) {
                Map<dynamic, dynamic> raw = box.toMap();
                List list = raw.values.toList();

                return GridView.builder(
                    itemCount: list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      Event e = list[index];

                      return GestureDetector(
                          child: FavouriteCard(
                            true,
                            event: e,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                  context,
                                ) =>
                                        ExpandedEvent(true, event: e)));
                          });
                    });
              })),
    );
  }
}
