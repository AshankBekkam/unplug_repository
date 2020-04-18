import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



part 'event.g.dart';

@HiveType()
class Event {


  @HiveField(0)
  String name;
  @HiveField(1)
  bool hasPrice;
  @HiveField(2)
  String price;
  @HiveField(3)
  String city;
  @HiveField(4)
  bool hasAgeRestriction;
  @HiveField(5)
  int ageRestriction;
  @HiveField(6)
  int likes;
  @HiveField(7)
  bool isStarred;
  @HiveField(8)
  bool isInviteOnly;
  @HiveField(9)
  bool hasAlcohol;
  @HiveField(10)
  bool byob;
  @HiveField(11)
  String genre;
  @HiveField(12)
  String venue;
  @HiveField(13)
  List<String> dj;
  @HiveField(14)
  String faq;
  @HiveField(15)
  String description;
  @HiveField(16)
  String imageURL;
  @HiveField(17)
  bool verified;
  @HiveField(18)
  DateTime dateTime;
  @HiveField(19)
  bool isEvent;

  Event(
      this.name,
      this.hasPrice,
      this.price,
      this.city,
      this.hasAgeRestriction,
      this.ageRestriction,
      this.likes,
      this.isStarred,
      this.isInviteOnly,
      this.hasAlcohol,
      this.byob,
      this.genre,
      this.venue,
      this.dj,
      this.faq,
      this.description,
      this.imageURL,
      this.verified,/*this.dateTime*/){this.isEvent = true;}

  Map<String, dynamic> toJson() => {
        'name': name,
        'hasPrice': hasPrice,
        'price': price,
        'city': city,
        'hasAgeRestriction': hasAgeRestriction,
        'ageRestriction': ageRestriction,
        'likes': likes,
        'isStarred': isStarred,
        'isInviteOnly': isInviteOnly,
        'hasAlcohol': hasAlcohol,
        'byob': byob,
        'genre': genre,
        'venue': venue,
        'dj': dj,
        'faq': faq,
        'description': description,
        'imageURL': imageURL,
        'verified': verified,
        'dateTime': dateTime
      };


}
Event fromJson(Map<String, dynamic> json) {
  Event e = new Event(
      json['name'],
      json['hasPrice'],
      json['price'],
      json['city'],
      json['hasAgeRestriction'],
      json['ageRestriction'],
      json['likes'],
      json['isStarred'],
      json['isInviteOnly'],
      json['hasAlcohol'],
      json['byob'],
      json['genre'],
      json['venue'],
      json['dj'],
      json['faq'],
      json['description'],
      json['imageURL'],
      json['verified'],/*json['dateTime']*/);

  return e;
}
