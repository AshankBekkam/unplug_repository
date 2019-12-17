import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChooseLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String locationSelected;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('locations')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> fsnapshot) {
            if (fsnapshot.hasError)
              return new Text('Error:${fsnapshot.error}');
            switch (fsnapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('loading');
              default:
                return Container(
                  color: Colors.deepPurple,
                  child: new ListView(
                    scrollDirection: Axis.horizontal,
                    children: fsnapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Container(alignment: Alignment.center,
                        width: width * .35,
                        child: GestureDetector(
                            onTap: () {
                              locationSelected = document['city'];
                              Navigator.pop(context, locationSelected);
                            },
                            child: Container(height: height*.3,width: width*.2,child: Card(child:Text( document['city']) ,))
                        ),
                      );
                    }).toList(),
                  ),
                );
            }
          }),
    );
  }
}
