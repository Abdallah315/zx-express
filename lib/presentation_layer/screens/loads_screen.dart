import 'package:flutter/material.dart';

class LoadsScreen extends StatelessWidget {
  const LoadsScreen({Key? key}) : super(key: key);
  static const routeName = '/loads-screen';

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Text('Loads Screen'),
    ));
  }
}
