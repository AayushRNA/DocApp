
import 'dart:convert';
import 'dart:math';

import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../helper/helper.dart';

class AppointmentCreate extends StatefulWidget {
   AppointmentCreate({Key? key,required this.doctorId}) : super(key: key);
 int doctorId;
  @override
  State<AppointmentCreate> createState() => _AppointmentCreateState();
}

class _AppointmentCreateState extends State<AppointmentCreate> {

  var items = [
    '7 am',
    '8 am',
    '9.30 am',
    '10 am ',
    '11 am ',
    '12 pm',
    '1 pm',
  ];

  int id = 0;
  String token = 'token';
  String device_token = 'device_token';
  final _addTitle = TextEditingController();
  final _description = TextEditingController();
  DateTime selectedDate = DateTime.now();
  // Initial Selected Value
  String dropdownvalue = '8 am';

  submit() async{
    print(widget.doctorId.toString());
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    device_token = prefs.getString('device_token')!;
    // await prefs.getString('device_token');
    id = prefs.getInt('id')!;
    if (token == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    if(_addTitle.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Subject not be empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(_description.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Descriptions not be empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      var url =  Uri.parse(baseUrl+'/make-appointment');
      var response = await http.post(url,body:{
        'doctor_id':widget.doctorId.toString(),
        'user_id':prefs.getInt('id')!.toString(),
        'subject':_addTitle.text,
        'desc':_description.text,
        'date':selectedDate.toString(),
        'time':dropdownvalue.toString(),
      });

      print(prefs.getInt('id')!.toString());

      if (response.statusCode == 200) {
        print('Number of books about http: ${response.body}.');
        var jsonResponse = jsonDecode(response.body);
        Fluttertoast.showToast(
            msg: "${jsonResponse['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        Fluttertoast.showToast(
            msg: "Request failed with status: ${response.statusCode}.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
    }

  }

  _selectDate(BuildContext context) async {

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 5)),
      lastDate: DateTime(2025),
      locale: const Locale('en', 'US'),
      selectableDayPredicate: (DateTime val) =>
      val.weekday == 3 || val.weekday == 6 ? false : true,
    );
    if (selected != null && selected != selectedDate)

    selectedDate = selected;
    items.shuffle();

    Random rnd = new Random();
    // Define min and max value
    int min = 3, max = 4;
    //Getting range
    var num = min + rnd.nextInt(max - min);

    items.take(num);

      setState(() {

      });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    print(widget.doctorId.toString());
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Appointment create'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16,right: 16,top: 20),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              TextField(
                controller: _addTitle,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: "Write the subject",
                  labelText: 'Subjects',
                  floatingLabelBehavior: FloatingLabelBehavior.always,

                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: _description,
                maxLines: 5,
                decoration: InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(15.0),
                    // borderSide: BorderSide(color: blackSemiColor),
                  ),
                  hintText: "Description*",
                  labelText: 'Description*',
                  floatingLabelBehavior: FloatingLabelBehavior.always,

                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GFButton(
                onPressed: () {
                  _selectDate(context);
                },
                color: Colors.lightGreen,
                text: "Change the date",
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                icon: const Icon(FontAwesomeIcons.clock, size: 16),
                shape: GFButtonShape.pills,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: DropdownButton(
                        // Initial Value
                        value: dropdownvalue,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),




                        // Array list of items
                        items: items.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                      width: 100,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text("The selected date is :${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,wordSpacing: 1.4),),
              const SizedBox(
                height: 25,
              ),
              GFButton(
                onPressed: () {
                  submit();
                },
                text: "Submit appointment",
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                icon: const Icon(FontAwesomeIcons.solidSave, size: 16),
                shape: GFButtonShape.standard,
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
