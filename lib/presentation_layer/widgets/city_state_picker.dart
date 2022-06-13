import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

class CityStatePicker extends StatefulWidget {
  CityStatePicker({Key? key, this.callback}) : super(key: key);
  Function(String)? callback;

  @override
  State<CityStatePicker> createState() => _CityStatePickerState();
}

class _CityStatePickerState extends State<CityStatePicker> {
  String? countryValue = "United States";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";
  final GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Adding CSC Picker Widget in app
        CSCPicker(
          ///Enable disable state dropdown [OPTIONAL PARAMETER]
          showStates: true,

          /// Enable disable city drop down [OPTIONAL PARAMETER]
          showCities: true,

          ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
          flagState: CountryFlag.ENABLE,

          ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
          dropdownDecoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300, width: 1)),

          ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
          disabledDropdownDecoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.grey.shade300,
              border: Border.all(color: Colors.grey.shade300, width: 1)),

          ///placeholders for dropdown search field
          stateSearchPlaceholder: "State",
          citySearchPlaceholder: "City",

          ///labels for dropdown
          stateDropdownLabel: "*State",
          cityDropdownLabel: "*City",

          ///Default Country
          //defaultCountry: DefaultCountry.India,

          ///Disable country dropdown (Note: use it with default country)
          disableCountry: true,
          currentCountry: 'United State',
          defaultCountry: DefaultCountry.United_States,

          ///selected item style [OPTIONAL PARAMETER]
          selectedItemStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),

          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
          dropdownHeadingStyle: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),

          ///DropdownDialog Item style [OPTIONAL PARAMETER]
          dropdownItemStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),

          ///Dialog box radius [OPTIONAL PARAMETER]
          dropdownDialogRadius: 10.0,

          ///Search bar radius [OPTIONAL PARAMETER]
          searchBarRadius: 10.0,

          ///triggers once country selected in dropdown

          ///triggers once state selected in dropdown
          ///
          onCountryChanged: (value) {
            setState(() {
              ///store value in state variable
              countryValue = 'United States';
            });
          },

          onStateChanged: (value) {
            setState(() {
              ///store value in state variable
              stateValue = value;
            });
          },

          ///triggers once city selected in dropdown
          onCityChanged: (value) {
            setState(() {
              ///store value in city variable
              cityValue = value;
              address = "$stateValue, $cityValue";
            });
            widget.callback!(address.toString());
          },
        ),

        ///print newly selected country state and city in Text Widget
        // TextButton(
        //   onPressed: () {
        //     setState(() {
        //       address = "$stateValue, $cityValue";
        //     });
        //     // Provider.of<ReadyToGo>(context, listen: false).ready(
        //     //     context: context,
        //     //     emptyPlace: 'michigan',
        //     //     preferedDestination: 'mand',
        //     //     date: '2022-03-30T01:31',
        //     //     note: 'no way out');
        //     print(address);
        //   },
        //   child: const Text("Print Data"),
        // ),
      ],
    );
  }
}
