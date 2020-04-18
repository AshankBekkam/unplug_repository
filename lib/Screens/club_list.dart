import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import 'package:geolocator/geolocator.dart';
import 'package:learning/provider/from_snapshot.dart';
import 'package:learning/provider/from_snapshot_club.dart';
import 'package:learning/widgets/app_bar.dart';
import 'package:learning/widgets/eventCard.dart';
import 'package:learning/widgets/side_drawer.dart';

import 'expanded_event.dart';
import 'filter_screen.dart';

class ClubScreen extends StatefulWidget {
  @override
  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  var selected = ' ';


  Position _currentPosition;
  String _currentAddress;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: UnplugAppBar('Find Clubs', _currentAddress),
            preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1)),
        body: Column(
          children: <Widget>[
            Align(alignment: Alignment.centerRight,
              child: Container(width:MediaQuery.of(context).size.width * 0.27 ,
                child: FlatButton(
                    onPressed: (){
                      selected = navigateAndGetFilter(context);

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.filter_list,color: Colors.orangeAccent,),
                        Text(
                          'Filter',
                          style: TextStyle(fontSize: 20,color: Colors.orangeAccent,),
                        ),
                      ],
                    )),
              ),
            ),
            Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.87,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: (selected == ' ')?Firestore.instance
                          .collection('clubs')
                          .orderBy('isStarred', descending: true)
                          .snapshots():Firestore.instance
                          .collection('clubs')

                          .orderBy('isStarred', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError)
                          return new Text('Error:${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('loading');
                          default:
                            return new ListView(
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ExpandedEvent(false,
                                                club:fromSnapshotToClub(document))));
                                  },
                                  child: EventCard(false,
                                    club: fromSnapshotToClub(document),
                                  ),
                                );
                              }).toList(),
                            );
                        }
                      })),
            ),
          ],
        ),
        drawer: new SideDrawer());


  }

  navigateAndGetFilter(BuildContext context) async
  {
    selected = await Navigator.push(context,MaterialPageRoute(builder: (context)=>Filter()));


  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }

}