import 'package:flutter/material.dart';
import 'package:zx_express/constants/sizes.dart';
import 'package:zx_express/presentation_layer/screens/announcement_detail_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:convert';

class AnnouncementItem extends StatelessWidget {
  static const routeName = '/announcement-item';

  String dispatcher;
  String title;
  String date;
  String content;
  AnnouncementItem(
      {Key? key,
      required this.title,
      required this.date,
      required this.content,
      required this.dispatcher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Card(
            elevation: 2,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                AnnouncementDetialScreen.routeName,
                arguments: [content, title],
              ),
              child: ListTile(
                  title: Text(
                    utf8.decode(
                      title.runes.toList(),
                    ),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    dispatcher,
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  trailing: Text(
                    timeago.format(
                      DateTime.parse(date),
                    ),
                  )
                  // Text(DateFormat('dd/MM/yyyy   hh:mm')
                  //     .format(DateTime.parse(date))),
                  ),
            ),
          ),
        ),
        SizedBox(
          height: setHeight(context) * 0.01,
        )
      ],
    );
  }
}
