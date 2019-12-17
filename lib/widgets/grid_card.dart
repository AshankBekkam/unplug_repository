import 'package:flutter/material.dart';
import 'package:learning/provider/club_details.dart';
import '../provider/event.dart';

class FavouriteCard extends StatelessWidget {

  Event event;
  Club club;
  bool _isEvent;


  FavouriteCard(this._isEvent,{Key key, this.event,this.club}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    return Container(margin: EdgeInsets.all(10),
      height: height * .2,
      width: width * .4,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[ Container(child: Image.network(_isEvent?event.imageURL:club.imageURL,fit: BoxFit.cover,)),

          ],

        ),
      ),
    );
  }
}
