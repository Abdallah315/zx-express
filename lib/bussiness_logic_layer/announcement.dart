import 'package:flutter/cupertino.dart';

class Announcement with ChangeNotifier {
  late String dispatcher;
  late String title;
  late String content;
  late String date;

  Announcement(
      {required this.content,
      required this.dispatcher,
      required this.title,
      required this.date});
}
