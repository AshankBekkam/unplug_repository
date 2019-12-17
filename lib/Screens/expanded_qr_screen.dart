import 'package:learning/provider/club_details.dart';
import 'package:learning/provider/event.dart';
import 'package:learning/provider/user_details.dart';
import 'package:learning/widgets/qr_card.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class ExpandedQrScreen extends StatelessWidget {
  final String guestListLink;
  final Event eventName;
  final Club clubName;
  final bool _isEvent;

  ExpandedQrScreen(this.guestListLink,this._isEvent, {this.eventName,this.clubName});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Go back',
              style: TextStyle(color: Colors.deepPurple,fontFamily: 'BebasNeue',fontSize: 30),
            )),
        iconTheme: IconThemeData(size: 40, color: Colors.deepPurple),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isEvent?QrCard(guestListLink, eventName.name, 290, true):QrCard(guestListLink, clubName.name, 290, true),
            Text(
              _isEvent?eventName.name:clubName.name,
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 45,
                  fontFamily: 'BebasNeue'),
            ),
            Text(
              details.userName,
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 45,
                  fontFamily: 'Raleway'),
            )
          ],
        ),
      ),
    );
  }
}
