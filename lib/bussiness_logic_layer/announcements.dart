import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:zx_express/bussiness_logic_layer/announcement.dart';
import 'package:http/http.dart' as http;

import '../presentation_layer/widgets/app_popup.dart';
import 'auth.dart';

class Announcements with ChangeNotifier {
  late List<Announcement> _items = [];

  List<Announcement> get items {
    return [..._items];
  }

  String? authToken;

  void update(Auth auth) {
    authToken = auth.token;
  }

  // Announcements(this.authToken, this._items);

  Future<void> fetchAndSetAnnouncements(BuildContext context) async {
    const baseUrl = 'https://zx-express.herokuapp.com/api/announcement/';
    var url = Uri.parse(baseUrl);
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'token $authToken'});

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        List<Announcement> loadedAnnouncement = [];
        extractedData['results'].forEach(
          (announcedata) {
            loadedAnnouncement.add(Announcement(
                dispatcher: announcedata['dispatcher'],
                content: announcedata['content'],
                title: announcedata['title'],
                date: announcedata['created_at']));
          },
        );
        _items = loadedAnnouncement;
      } else {
        AppPopup.showMyDialog(context,
            (json.decode(response.body)['error'] as List<dynamic>?)?.first);
        _items = [];
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
