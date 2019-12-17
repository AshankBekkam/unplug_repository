import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String selectedType = '';
  String selectedSort = '';
  String selectedOnly = '';
  Map filter = {'selectedType':'','selectedSort':'','selectedOnly':''};
  double height;
  double width;


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(width, height / 10),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 1,
            title: Text(
              '            Filter',
              style: TextStyle(
                  color: Colors.amberAccent,
                  fontFamily: 'Monoton',
                  fontSize: 41),
            ),
          )),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: height * .1,
            child: Text(
              'Type',
              style: TextStyle(fontFamily: 'BebasNeue', fontSize: 70),
            ),
          ),
          getRow(filter['selectedType'],'typesOfEvents'),
      SizedBox(
        height: height * .62,)

        ],
      ),
    );
    
    
    
    
    
    
  }
  Widget getCard(DocumentSnapshot document)
  {
    return Card(
      color: Colors.black38,
      child: Center(
          child: Column(
            children: <Widget>[
              Container(
                  height: height * .09,
                  child: Center(
                      child: Image.network(
                        document['iconURL'],
                      ))),
              Text(
                document['Types'],
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Raleway'),
              ),
            ],
          )),
    );
  }

  Widget getRow(String selected,String collection)
  {
    return Expanded(
      child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection(collection)
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
                                  selected = document['Types'];
                                  Navigator.pop(context, selected);
                                },
                                child: getCard(document)
                            ),
                          );
                        }).toList(),
                      ),
                    );
                }
              })),
    );
  }
  
  
  
 
  
  
}
