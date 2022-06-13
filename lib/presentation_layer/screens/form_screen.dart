import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zx_express/bussiness_logic_layer/ready_to_go.dart';
import 'package:zx_express/constants/colors.dart';
import 'package:zx_express/constants/sizes.dart';
import 'package:zx_express/presentation_layer/widgets/city_state_picker.dart';
import 'package:zx_express/presentation_layer/widgets/date_time_picker.dart';

import '../widgets/app_popup.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);
  static const routeName = '/form-screen';

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  Future<void> _refreshAnnouncements(BuildContext context) async {
    await Provider.of<ReadyToGo>(context, listen: false).driverState(context);
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _refreshAnnouncements(context);
    }
  }

  final Map<String, String> _formData = {
    'emptyplace': '',
    'prefered_destination': '',
    'from_date': DateTime.now().toIso8601String(),
    'note': ''
  };
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isLoading = false;

  Future<void> _submit() async {
    if (_formData['emptyplace']!.contains('null')) {
      AppPopup.showMyDialog(context, 'You must Enter Your Empty Location');
      return;
    }
    if (_formData['prefered_destination']!.contains('null')) {
      AppPopup.showMyDialog(context, 'You must Enter Your Prefered Location');
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<ReadyToGo>(context, listen: false).ready(
        context: context,
        date: _formData['from_date'].toString(),
        emptyPlace: _formData['emptyplace'].toString(),
        preferedDestination: _formData['prefered_destination'].toString(),
        note: _formData['note'].toString(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Request Sent Successfully'),
          duration: Duration(seconds: 3),
        ),
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.myBlue,
          title: const Text(
            'Pick Up New Load',
            style: TextStyle(color: MyColors.myWhite),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _refreshAnnouncements(context),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(color: MyColors.myBlue),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshAnnouncements(context),
                    child: Consumer<ReadyToGo>(
                      builder: (ctx, activeState, _) => Padding(
                        padding: const EdgeInsets.all(15),
                        child: activeState.active == true
                            ? const Center(
                                child: Text(
                                  'please finish your current load',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              )
                            : SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: setHeight(context) * 0.001,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 7),
                                        width: setWidth(context),
                                        child: Text(
                                          'Empty Location',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(
                                        height: setHeight(context) * 0.01,
                                      ),
                                      CityStatePicker(
                                        callback: (data) {
                                          print(data);
                                          _formData['emptyplace'] = data;
                                          print(_formData);
                                        },
                                      ),
                                      SizedBox(
                                        height: setHeight(context) * 0.01,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 7),
                                        width: setWidth(context),
                                        child: Text(
                                          'Prefered Location',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(
                                        height: setHeight(context) * 0.01,
                                      ),
                                      CityStatePicker(
                                        callback: (data) {
                                          _formData['prefered_destination'] =
                                              data;
                                          print(_formData);
                                        },
                                      ),
                                      SizedBox(
                                        height: setHeight(context) * 0.03,
                                      ),

                                      //  '${dateTime.year}-${dateTime.month}-${dateTime.day}T${dateTime.hour}:${dateTime.minute}'
                                      DateTimePicker(
                                          date: DateTime.parse(
                                              _formData['from_date']
                                                  .toString()),
                                          callback: (p0) {
                                            _formData['from_date'] = p0;
                                          }),
                                      SizedBox(
                                        height: setHeight(context) * 0.03,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 7),
                                        width: setWidth(context),
                                        child: Text(
                                          'ُNotes',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: setHeight(context) * 0.015,
                                      // ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xffEDEFF2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: const BorderSide(
                                              color: Color(0xffEDEFF2),
                                            ),
                                          ),
                                          hintText: 'Enter Your Note',
                                          fillColor: const Color(0xffEDEFF2),
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onSaved: (value) {
                                          _formData['note'] = value!;
                                        },
                                      ),
                                      SizedBox(
                                        height: setHeight(context) * 0.03,
                                      ),
                                      GestureDetector(
                                        onTap: _submit,
                                        child: Container(
                                          width: setWidth(context),
                                          height: setHeight(context) * 0.08,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: MyColors.myBlue),
                                          child: Center(
                                            child: _isLoading
                                                ? const CircularProgressIndicator(
                                                    color: MyColors.myWhite,
                                                  )
                                                : const Text(
                                                    'Send Your Informations',
                                                    style: TextStyle(
                                                        color: MyColors.myWhite,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  )),
      ),
    );
  }
}
