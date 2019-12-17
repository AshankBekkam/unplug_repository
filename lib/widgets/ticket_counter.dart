import 'package:flutter/material.dart';

class TicketCounter extends StatefulWidget {
  int ticketNumber = 1;
  @override
  _TicketCounterState createState() => _TicketCounterState();
}

class _TicketCounterState extends State<TicketCounter> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        children: <Widget>[
          LimitedBox(
            maxWidth: width / 10,
            child: RaisedButton(
              child: Center(child: Text('-')),
              onPressed: () {
                setState(() {
                  if (widget.ticketNumber > 1) widget.ticketNumber--;
                });
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: Text(
              '  ' + widget.ticketNumber.toString() + '  ',
              style: TextStyle(
                  color: Colors.purple, fontFamily: 'BebasNeue', fontSize: 27),
            ),
          ),
          LimitedBox(
            maxWidth: width / 10,
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  if (widget.ticketNumber < 7) widget.ticketNumber++;
                });
              },
              child: Text('+'),
            ),
          ),
        ],
      ),
    );
  }
}
