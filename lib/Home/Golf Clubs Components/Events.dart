import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  String title;
  String host;
  String format;
  String entryFee;
  String signUpDue;
  String moreInfo;

  Events(
    this.title,
    this.host,
    this.format,
    this.entryFee,
    this.signUpDue,
    this.moreInfo,
  );

  factory Events.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Events(
      data['Event Name'],
      data['Club Host'],
      data['Formate'],
      data['Entry Fee'],
      data['Sign up due'],
      data['More info'],
    );
  }
}
