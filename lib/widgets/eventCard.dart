import 'package:flutter/material.dart';
import 'package:learning/provider/club_details.dart';
import '../provider/event.dart';
import '../provider/eu_datetime.dart';

class EventCard extends StatelessWidget {
  EventCard(this._isEvent,{Key key, this.event,this.club}) : super(key: key);

  Event event;
  Club club;
  bool _isEvent;
  //EuDateTime euDateTime;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(margin: EdgeInsets.all(20),
      height: height * .2,
      width: width * .1,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[Hero(child: Container(child: Image.network(_isEvent?event.imageURL:club.imageURL,fit: BoxFit.cover,)),tag: '${_isEvent?event.name:club.name}',),
          Align(child: (_isEvent?event.isStarred:club.isStarred)?Icon(Icons.star,color: Colors.amberAccent,size: 40,):Container(height: 0,width: 0,),alignment: Alignment.topRight,)
          ],

        ),
      ),
    );
  }
}
