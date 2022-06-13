import 'package:flutter/material.dart';
import 'package:zx_express/constants/colors.dart';
import 'package:zx_express/constants/sizes.dart';
import 'package:zx_express/presentation_layer/screens/auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const routeName = '/welcome-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: setHeight(context),
        color: MyColors.myBlue,
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              child: Image.asset('assets/images/images.png'),
            ),
            SizedBox(
              height: setHeight(context) * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                          color: MyColors.myWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 38),
                    ),
                    SizedBox(
                      height: setHeight(context) * 0.03,
                    ),
                    const Text(
                      'Manage your expenses',
                      style: TextStyle(color: MyColors.myWhite, fontSize: 18),
                    ),
                    SizedBox(
                      height: setHeight(context) * 0.02,
                    ),
                    const Text(
                      'Seamlessly & intuitively',
                      style: TextStyle(
                          color: MyColors.myWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: setHeight(context) * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(AuthScreen.routeName),
                child: Container(
                  width: double.infinity,
                  height: setHeight(context) * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: MyColors.myWhite,
                  ),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: MyColors.myBlue,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
