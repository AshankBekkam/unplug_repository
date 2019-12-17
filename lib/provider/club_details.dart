import 'package:hive/hive.dart';

part 'club_details.g.dart';

@HiveType()
class Club {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  String faq;
  @HiveField(3)
  bool hasGuestList;
  @HiveField(4)
  String imageURL;
  @HiveField(5)
  bool isStarred;
  @HiveField(6)
  bool hasEntryFee;
  @HiveField(7)
  String city;
  @HiveField(8)
  bool verified;
  @HiveField(9)
  String entryFee;
  @HiveField(10)
  bool isEvent;

  Club(
      this.name,
      this.description,
      this.faq,
      this.hasGuestList,
      this.imageURL,
      this.isStarred,
      this.hasEntryFee,
      this.entryFee,
      this.city,
      this.verified) {
    this.isEvent = false;
  }
}
