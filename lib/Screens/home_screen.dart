import 'package:flutter/material.dart';
import 'package:learning/Screens/location_screen.dart';
import '../widgets/side_drawer.dart';
import '../widgets/app_bar.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/eventCard.dart';
import '../Screens/expanded_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../provider/from_snapshot.dart';
import 'filter_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  var selectedType = '';
  Map selected = {'selectedType':'','selectedSort':'','selectedOnly':''};

  

  Position _currentPosition;
  String currentAddress;
  String selectedAddress = '';
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: UnplugAppBar('Find Parties', selectedAddress==''?currentAddress:selectedAddress),
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1)),
        body: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[Align(alignment: Alignment.centerRight,
                child: Container(width:MediaQuery.of(context).size.width * 0.5 ,
                  child: FlatButton(
                      onPressed: (){
                        selectedAddress = navigateAndGetLocation(context);



                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.location_city,color: Colors.greenAccent,),
                          Text(
                            'Location',
                            style: TextStyle(fontSize: 20,color: Colors.greenAccent,),
                          ),
                        ],
                      )),
                ),
              ),
                Align(alignment: Alignment.centerLeft,
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
              ],
            ),
            Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.87,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: (selectedType == '')?Firestore.instance
                          .collection('events')
                          .orderBy('isStarred', descending: true)
                          .snapshots():Firestore.instance
                          .collection('events')
                          .where('city',isEqualTo: selectedAddress == ''?currentAddress:selectedAddress)
                          .where('genre',isEqualTo: selectedType )
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
                                            builder: (context) => ExpandedEvent(true,
                                                event:fromSnapshot(document))));
                                  },
                                  child: EventCard(true,
                                    event: fromSnapshot(document),
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
    selectedType = await Navigator.push(context,MaterialPageRoute(builder: (context)=>Filter()));
    
    
  }
  navigateAndGetLocation(BuildContext context) async
  {

    selectedAddress = await Navigator.push(context,MaterialPageRoute(builder: (context)=>ChooseLocation()));


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
        currentAddress = "${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }
  
}
