import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zx_express/bussiness_logic_layer/auth.dart';
import 'package:zx_express/constants/colors.dart';
import 'package:zx_express/constants/sizes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = '/auth-screen';
  @override
  State<AuthScreen> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    // if (!_formKey.currentState!.validate()) {
    //   // Invalid!
    //   return;
    // }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).login(
        context,
        _authData['username'].toString(),
        _authData['password'].toString(),
      );
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myBlue,
        elevation: 0,
      ),
      body: Container(
        color: MyColors.myBlue,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Sign In',
                style: TextStyle(
                    color: MyColors.myWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            SizedBox(
              height: setHeight(context) * 0.02,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: MyColors.myWhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: setHeight(context) * 0.03,
                        ),
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                              color: Color(0xff0A2A56),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: setHeight(context) * 0.01,
                        ),
                        Text(
                          'Hello there,Sign In to continue!',
                          style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: setHeight(context) * 0.04,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'UserName',
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                height: setHeight(context) * 0.015,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xffEDEFF2),
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color(0xffEDEFF2),
                                    ),
                                  ),
                                  hintText: 'Enter your username',
                                  fillColor: const Color(0xffEDEFF2),
                                  filled: true,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.bold),
                                ),
                                onSaved: (value) {
                                  _authData['username'] = value!;
                                },
                              ),
                              SizedBox(
                                height: setHeight(context) * 0.04,
                              ),
                              Text(
                                'Password',
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                height: setHeight(context) * 0.015,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xffEDEFF2),
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color(0xffEDEFF2),
                                    ),
                                  ),
                                  hintText: 'Enter your password',
                                  fillColor: const Color(0xffEDEFF2),
                                  filled: true,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.bold),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is too short!';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _authData['password'] = value!;
                                  print(_authData);
                                },
                              ),
                              SizedBox(
                                height: setHeight(context) * 0.1,
                              ),
                              GestureDetector(
                                onTap: _submit,
                                child: Container(
                                  width: double.infinity,
                                  height: setHeight(context) * 0.07,
                                  decoration: BoxDecoration(
                                    color: MyColors.myBlue,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: _isLoading
                                        ? const CircularProgressIndicator(
                                            color: MyColors.myWhite,
                                          )
                                        : const Text(
                                            'Sign In',
                                            style: TextStyle(
                                                color: MyColors.myWhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
