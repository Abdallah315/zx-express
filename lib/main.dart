import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zx_express/bussiness_logic_layer/announcements.dart';
import 'package:zx_express/bussiness_logic_layer/auth.dart';
import 'package:zx_express/bussiness_logic_layer/ready_to_go.dart';
import 'package:zx_express/constants/routes.dart';
import 'package:zx_express/presentation_layer/screens/pages_screen.dart';
import 'package:zx_express/presentation_layer/screens/splash_screen.dart';
import 'package:zx_express/presentation_layer/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Announcements>(
          create: (_) => Announcements(),
          update: (_, auth, myNotifier) => myNotifier!..update(auth),
        ),
        ChangeNotifierProxyProvider<Auth, ReadyToGo>(
          create: (_) => ReadyToGo(),
          update: (_, auth, myNotifier) => myNotifier!..update(auth),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Zx Express',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth
              ? const PagesScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : const WelcomeScreen(),
                ),
          routes: routes,
        ),
      ),
    );
  }
}
