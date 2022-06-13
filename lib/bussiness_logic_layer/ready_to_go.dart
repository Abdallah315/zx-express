import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zx_express/bussiness_logic_layer/auth.dart';
import 'package:http/http.dart' as http;
import 'package:zx_express/presentation_layer/widgets/app_popup.dart';

class ReadyToGo with ChangeNotifier {
  String? authToken;
  int? driverId;
  bool? active;

  void update(Auth auth) {
    authToken = auth.token;
    driverId = auth.driverId;
  }

  Future<void> ready(
      {required BuildContext context,
      required String emptyPlace,
      required String preferedDestination,
      required String date,
      String? note}) async {
    final url = Uri.parse('https://zx-express.herokuapp.com/api/trailerstogo/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token $authToken'
        },
        body: json.encode(
          {
            'driver': driverId,
            'emptyplace': emptyPlace,
            'prefered_destination': preferedDestination,
            'from_date': date,
            'to_date': '2022-03-31T01:31',
            'ready': true,
            'note': note,
            'active': true
          },
        ),
      );
      print(response.statusCode);
      final responseData = json.decode(response.body);
      if (response.statusCode == 201) {
        print('successs');
        print(responseData);
        notifyListeners();
        // }
      } else {
        AppPopup.showMyDialog(
            context, (responseData['error'] as List<dynamic>?)?.first);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> driverState(BuildContext context) async {
    print('created');
    final url = Uri.parse('https://zx-express.herokuapp.com/api/trailerstogo/');

    try {
      final response =
          await http.get(url, headers: {'Authorization': 'token $authToken'});
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(extractedData[0]['active']);
        active = extractedData[0]['active'];
      } else {
        AppPopup.showMyDialog(context,
            (json.decode(response.body)['error'] as List<dynamic>?)?.first);
      }
    } catch (e) {
      rethrow;
    }
  }
}
