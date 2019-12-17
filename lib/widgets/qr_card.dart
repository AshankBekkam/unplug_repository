import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCard extends StatelessWidget {
  final String guestListLink;
  final double _size;
  final String eventName;
  final bool _expanded;
  QrCard(this.guestListLink, this.eventName, this._size, this._expanded);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.all(10),
        height: _expanded ? 320 : height * .20,
        width: _expanded ? 320 : width * .4,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2))),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              QrImage(
                  data: guestListLink,
                  version: QrVersions.auto,
                  size: _size,
                  gapless: true,
                  embeddedImage: AssetImage('images/u.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80))),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: _expanded
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Text(
                          eventName,
                          style: TextStyle(color: Colors.black,fontFamily: 'BebasNeue',fontSize: 20),
                        )),
            ],
          ),
        ));
  }
}
