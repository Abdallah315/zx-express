import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zx_express/constants/colors.dart';
import 'package:zx_express/presentation_layer/screens/announcement_screen.dart';
import 'package:zx_express/presentation_layer/screens/form_screen.dart';
import 'package:zx_express/presentation_layer/screens/loads_screen.dart';
import 'package:zx_express/presentation_layer/screens/profile_screen.dart';

class PagesScreen extends StatefulWidget {
  const PagesScreen({Key? key}) : super(key: key);
  static const routeName = '/pages';

  @override
  State<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  int selected_index = 0;
  List pages = [
    const AnnouncementScreen(),
    const LoadsScreen(),
    const FormScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          selectedItemColor: MyColors.myBlue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.shifting,
          backgroundColor: MyColors.myBlue,
          onTap: (index) {
            setState(() {
              selected_index = index;
            });
          },
          currentIndex: selected_index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              label: 'Loads',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.angular,
              ),
              label: 'Form',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.edit,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: pages[selected_index],
    ));
  }
}
