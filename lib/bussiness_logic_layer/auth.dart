import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zx_express/presentation_layer/widgets/app_popup.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userName;
  int? _dirverId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    return _token;
  }

  String? get userName {
    return _userName;
  }

  int? get driverId {
    return _dirverId;
  }

  Future<void> login(
      BuildContext context, String username, String password) async {
    final url = Uri.parse('https://zx-express.herokuapp.com/auth-token/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {'username': username, 'password': password},
        ),
      );
      final responseData = json.decode(response.body);
      print(response.statusCode);
      print(token);
      if (response.statusCode == 200) {
        if (responseData['role'] != 'driver') {
          AppPopup.showMyDialog(
              context, 'You Aren\'t a driver,Please Enter a driver data');
          return;
        }
        _token = responseData['token'];
        _userName = username;
        _dirverId = responseData['driver_id'];
        print('$_token deh token gdeeeeeeeeeeda');
        Navigator.of(context).pop();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {'token': _token, 'username': _userName, 'driverId': _dirverId},
        );
        prefs.setString('userData', userData);
        // }
      } else {
        AppPopup.showMyDialog(
            context, (responseData['error'] as List<dynamic>?)?.first);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData') && token != null) {
      return false;
    }
    final exrtractedUserdata =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    _token = exrtractedUserdata['token'];
    _userName = exrtractedUserdata['username'];
    _dirverId = exrtractedUserdata['driverId'];
    print(_dirverId);
    notifyListeners();
    return true;
  }

  Future<void> logout(BuildContext context) async {
    final url =
        Uri.parse('https://zx-express.herokuapp.com/auth-token/logout/');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'token $token',
        },
      );
      final responseData = json.decode(response.body);
      print('$responseData deh mn logout');
      print('${response.statusCode} deh mn logout');
      print(token);

      if (response.statusCode == 200) {
        _token = null;

        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
      } else {
        AppPopup.showMyDialog(
            context, (responseData['error'] as List<dynamic>?)?.first);
      }
    } catch (e) {
      rethrow;
    }
  }
}
