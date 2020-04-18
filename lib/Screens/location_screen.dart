import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChooseLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String locationSelected;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(width, height / 10),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 1,
            title: Text(
              '    Location',
              style: TextStyle(
                  color: Colors.amberAccent,
                  fontFamily: 'Monoton',
                  fontSize: 41),
            ),
          )),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('locations').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> fsnapshot) {
            if (fsnapshot.hasError) return new Text('Error:${fsnapshot.error}');
            switch (fsnapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('loading');
              default:
                return Container(
                  child: new GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: fsnapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Container(
                        alignment: Alignment.center,
                        width: width * .45,
                        child: GestureDetector(
                            onTap: () {
                              locationSelected = document['city'];
                              Navigator.pop(context, locationSelected);
                            },
                            child: SizedBox(
                                height: height * .2,
                                width: width * .4,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        document['city'],
                                        style: TextStyle(
                                            fontFamily: 'BebasNeue',
                                            fontSize: 25),
                                      )),
                                ))),
                      );
                    }).toList(),
                  ),
                );
            }
          }),
    );
  }
}
