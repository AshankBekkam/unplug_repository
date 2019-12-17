import 'package:flutter/material.dart';
import 'package:learning/Screens/payment_confirm_screen.dart';
import 'package:learning/provider/club_details.dart';
import 'package:learning/provider/event.dart';
import 'package:learning/provider/user_details.dart';
import 'package:learning/widgets/grid_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:math';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  final UserDetails _user = details;
  bool _isEvent;
  final Event bEvent;
  final Club bClub;
  PaymentPage(this._isEvent, {this.bEvent, this.bClub});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int ticketNumber = 1;
  Razorpay _razorpay;

  @override
  void initState() {
    print('debug');
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_NgXgaWpaHvjFez',
      'amount': widget._isEvent
          ? int.parse(widget.bEvent.price) * ticketNumber * 100
          : int.parse(widget.bClub.entryFee) * ticketNumber * 100,
      'name': 'Unplug',
      'description': ' Event Payment',
      'prefill': {},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void firestoreUpload(bool isEvent) {
    Firestore.instance
        .collection(isEvent ? 'events' : 'clubs')
        .document(isEvent ? widget.bEvent.name : widget.bClub.name)
        .collection('guestList')
        .document(widget._user.userName)
        .setData({'name': widget._user.userName, 'qrValid': ticketNumber});
  }

  void upAndNav(isEvent) {
    firestoreUpload(isEvent);
    isEvent
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => QRScreen(
                      true,
                      pEvent:widget.bEvent,
                    )))
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => QRScreen(
                      false,
                      pClub: widget.bClub,
                    )));
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    firestoreUpload(widget._isEvent);

    Fluttertoast.showToast(msg: 'SUCCESS' + response.paymentId);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: widget._isEvent
                ? (context) => QRScreen(true, pEvent: widget.bEvent)
                : QRScreen(
                    false,
                    pClub: widget.bClub,
                  )));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'ERROR' + response.code.toString() + ' - ' + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: 'External Wallet' + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(width, height / 10),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 1,
            title: Text(
              'Checkout',
              style: TextStyle(
                  color: Colors.cyanAccent,
                  fontFamily: 'Monoton',
                  fontSize: 43),
            ),
          )),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              widget._isEvent
                  ? FavouriteCard(
                      true,
                      event: widget.bEvent,
                    )
                  : FavouriteCard(false, club: widget.bClub),
              Column(
                children: <Widget>[
                  Text(
                    widget._isEvent ? widget.bEvent.name : widget.bClub.name,
                    style: TextStyle(fontSize: 25, fontFamily: 'BebasNeue'),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        LimitedBox(
                          maxWidth: width / 10,
                          child: RaisedButton(
                            child: Center(child: Text('-')),
                            onPressed: () {
                              setState(() {
                                if (ticketNumber > 1) ticketNumber--;
                              });
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Text(
                            '  ' + ticketNumber.toString() + '  ',
                            style: TextStyle(
                                color: Colors.purple,
                                fontFamily: 'BebasNeue',
                                fontSize: 27),
                          ),
                        ),
                        LimitedBox(
                          maxWidth: width / 10,
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                if (ticketNumber < 7) ticketNumber++;
                              });
                            },
                            child: Text('+'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          widget._isEvent
              ? Text(
                  'Subtotal   ₹${int.parse(widget.bEvent.price) * ticketNumber}',
                  style: TextStyle(fontSize: 30, fontFamily: 'BebasNeue'),
                )
              : (widget.bClub.hasEntryFee
                  ? Text(
                      'Subtotal   ₹${int.parse(widget.bClub.entryFee) * ticketNumber}',
                      style: TextStyle(fontSize: 30, fontFamily: 'BebasNeue'),
                    )
                  : Text("Entry Free",
                      style: TextStyle(fontSize: 30, fontFamily: 'BebasNeue'))),
          Container(
              height: height / 12,
              width: width * .9,
              child: RaisedButton(
                onPressed: () {
                  widget._isEvent
                      ? (widget.bEvent.price == '0')
                          ? upAndNav(true)
                          : openCheckout()
                      : (!widget.bClub.hasEntryFee)
                          ? upAndNav(false)
                          : openCheckout();
                },
                child: widget._isEvent
                    ? (widget.bEvent.price != '0')
                        ? Text(
                            'Make Pament',
                            style: TextStyle(
                                fontFamily: 'BebasNeue', fontSize: 35),
                          )
                        : Text(
                            'Get on GuestList',
                            style: TextStyle(
                                fontFamily: 'BebasNeue', fontSize: 35),
                          )
                    : (widget.bClub.hasEntryFee)
                        ? Text(
                            'Make Pament',
                            style: TextStyle(
                                fontFamily: 'BebasNeue', fontSize: 35),
                          )
                        : Text(
                            'guestList',
                            style: TextStyle(
                                fontFamily: 'BebasNeue', fontSize: 35),
                          ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ))
        ],
      ),
    );
  }
}
