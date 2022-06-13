import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:zx_express/constants/colors.dart';
import 'package:zx_express/constants/sizes.dart';

class AnnouncementDetialScreen extends StatelessWidget {
  const AnnouncementDetialScreen({Key? key}) : super(key: key);
  static const routeName = '/announcement-detail-screen';

  @override
  Widget build(BuildContext context) {
    dynamic argsList = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          utf8.decode(argsList[1].runes.toList()),
          style: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: MyColors.myBlue,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: setWidth(context),
          child: Text(
            utf8.decode(argsList[0].runes.toList()),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
