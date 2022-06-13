import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zx_express/bussiness_logic_layer/announcements.dart';
import 'package:zx_express/constants/colors.dart';
import 'package:zx_express/constants/sizes.dart';
import 'package:zx_express/presentation_layer/widgets/announcement_item.dart';

import '../../bussiness_logic_layer/auth.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);
  static const routeName = '/announcement-screen';

  Future<void> _refreshAnnouncements(BuildContext context) async {
    await Provider.of<Announcements>(context, listen: false)
        .fetchAndSetAnnouncements(context);
  }

  @override
  Widget build(BuildContext context) {
    String? userName = Provider.of<Auth>(context).userName;
    print('announcement builded');
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _refreshAnnouncements(context),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(color: MyColors.myBlue),
                )
              : RefreshIndicator(
                  onRefresh: () => _refreshAnnouncements(context),
                  child: Consumer<Announcements>(
                    builder: (ctx, announcementsData, _) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: setWidth(context),
                              height: setHeight(context) * 0.06,
                              child: Text(
                                'Hello ${userName!.toUpperCase()}\nAnnouncements',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: announcementsData.items.length,
                              itemBuilder: (_, i) => AnnouncementItem(
                                dispatcher:
                                    announcementsData.items[i].dispatcher,
                                date: announcementsData.items[i].date,
                                title: announcementsData.items[i].title,
                                content: announcementsData.items[i].content,
                              ),
                            ),
                            GestureDetector(
                                onTap: () =>
                                    Provider.of<Auth>(context, listen: false)
                                        .logout(context),
                                child: const Text('sign out'))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
