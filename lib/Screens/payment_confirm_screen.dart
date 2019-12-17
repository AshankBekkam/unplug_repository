import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learning/provider/club_details.dart';
import 'package:learning/provider/event.dart';
import 'package:learning/provider/user_details.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatefulWidget {
  final Event pEvent;
  final Club pClub;
  final bool _isEvent;
  QRScreen(this._isEvent, {this.pEvent, this.pClub});

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  Box qrBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openBox();
  }

  final UserDetails _user = details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: qrImageGen(),
          ),
          Text(
            'Show this at the entrance',
            style: TextStyle(
                fontSize: 42,
                fontFamily: 'BebasNeue',
                color: Colors.deepPurple),
          ),
          Text(
            _user.userName,
            style: TextStyle(
                fontSize: 42, fontFamily: 'Raleway', color: Colors.deepPurple),
          ),
          Text(
            widget._isEvent ? widget.pEvent.name : widget.pClub.name,
            style: TextStyle(
                fontSize: 20, fontFamily: 'Raleway', color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }

  Widget qrImageGen() {
    QrImage qrImage = new QrImage(
      data: widget._isEvent
          ? '/events/${widget.pEvent.name}/guestList/${_user.userName}'
          : '/clubs/${widget.pClub.name}/guestList/${_user.userName}',
      version: QrVersions.auto,
      size: 320,
      gapless: true,
      embeddedImage: AssetImage('images/u.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(size: Size(150, 150)),
    );
    widget._isEvent
        ? Hive.box('qr').put(
            '/events/${widget.pEvent.name}/guestList/${_user.userName}',
            widget.pEvent)
        :Hive.box('qr').put(
            '/clubs/${widget.pClub.name}/guestList/${_user.userName}',
            widget.pClub);

    return qrImage;
  }

  Future _openBox() async {
    qrBox = await Hive.openBox('qr');
    return;
  }
}
