
import 'dart:convert';

import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/models/appoinment.dart';
import 'package:doctor_app/screens/login_screen.dart';
import 'package:doctor_app/widgets/doctor_card_one.dart';
import 'package:doctor_app/widgets/doctor_card_tow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {

  int id = 0;
  String token = 'token';
  String device_token = 'device_token';
  List<Appointments> appointments = [];
  fetchAllData() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    device_token = prefs.getString('device_token')!;
    // await prefs.getString('device_token');
    id = prefs.getInt('id')!;
    if (token == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }

    var url = Uri.parse(baseUrl + '/appointment-list-patient/'+prefs.getInt('id')!.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body}.');
      var json = jsonDecode(response.body);
      setState(() {
        if (json['appointments'] != null) {
          appointments = [];
          json['appointments'].forEach((v) {
            appointments.add(Appointments.fromJson(v));
          });
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "Request failed with status: ${response.statusCode}.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        return await fetchAllData();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My Appointments'),
          ),
          body: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    DoctorCardTwo(appointments: appointments[index]),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
