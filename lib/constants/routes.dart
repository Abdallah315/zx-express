import 'package:flutter/cupertino.dart';
import 'package:zx_express/presentation_layer/screens/announcement_screen.dart';
import 'package:zx_express/presentation_layer/screens/announcement_detail_screen.dart';
import 'package:zx_express/presentation_layer/screens/auth_screen.dart';
import 'package:zx_express/presentation_layer/screens/form_screen.dart';
import 'package:zx_express/presentation_layer/screens/loads_screen.dart';
import 'package:zx_express/presentation_layer/screens/pages_screen.dart';
import 'package:zx_express/presentation_layer/screens/profile_screen.dart';
import 'package:zx_express/presentation_layer/screens/welcome_screen.dart';

final Map<String, WidgetBuilder> routes = {
  PagesScreen.routeName: (context) => const PagesScreen(),
  AnnouncementScreen.routeName: (context) => const AnnouncementScreen(),
  LoadsScreen.routeName: (context) => const LoadsScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  FormScreen.routeName: (context) => const FormScreen(),
  WelcomeScreen.routeName: ((context) => const WelcomeScreen()),
  AuthScreen.routeName: ((context) => const AuthScreen()),
  AnnouncementDetialScreen.routeName: (context) =>
      const AnnouncementDetialScreen()
};
