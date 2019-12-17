import 'package:share/share.dart';
import 'event.dart';
import 'package:flutter/material.dart';

void share(BuildContext context, Event event) {
  final RenderBox box = context.findRenderObject();
  final String text =
      "Hey!,Im came across this ${event.name} happening at ${event.venue}. It sounds fun, wanna head?";
  Share.share(
    text,
    subject: (event.name),
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}
