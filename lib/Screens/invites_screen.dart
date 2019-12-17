import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learning/Screens/expanded_qr_screen.dart';
import 'package:learning/Screens/payment_confirm_screen.dart';
import 'package:learning/widgets/grid_card.dart';
import 'package:learning/widgets/qr_card.dart';

class InviteGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inviteBox = Hive.box('qr');

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    //Hive.box('qr').clear();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(width, height / 10),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 1,
            title: Text(
              '         Invites',
              style: TextStyle(
                  color: Colors.lightGreenAccent,
                  fontFamily: 'Monoton',
                  fontSize: 41),
            ),
          )),
      body: Container(
          child: WatchBoxBuilder(
              box: inviteBox,
              builder: (context, box) {
                Map<dynamic, dynamic> raw = box.toMap();
                List valList = raw.values.toList();
                List keyList = raw.keys.toList();

                return ListView.builder(
                    itemCount: valList.length,
                    itemBuilder: (context, index) {
                      var name = valList[index];
                      String link = keyList[index];
                      return GestureDetector(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  name.isEvent
                                      ? FavouriteCard(true, event: name)
                                      : FavouriteCard(
                                          false,
                                          club: name,
                                        ),
                                  Column(
                                    children: <Widget>[
                                      Text(name.name),
                                      //Text(name.city),
                                    ],
                                  )
                                ],
                              ),
                              //Text(name)
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                  context,
                                ) =>
                                        name.isEvent
                                            ? ExpandedQrScreen(
                                                link,
                                                true,
                                                eventName: name,
                                              )
                                            : ExpandedQrScreen(
                                                link,
                                                false,
                                                clubName: name,
                                              )));
                          });
                    });
              })),
    );
  }
}
