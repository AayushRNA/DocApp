
import 'dart:convert';

import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/models/appoinment.dart';
import 'package:doctor_app/screens/histrory2_screen.dart';
import 'package:doctor_app/screens/login_screen.dart';
import 'package:doctor_app/widgets/doctor_card_tow.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class AppointMentRequest extends StatefulWidget {
  const AppointMentRequest({Key? key}) : super(key: key);

  @override
  State<AppointMentRequest> createState() => _AppointMentRequestState();
}

class _AppointMentRequestState extends State<AppointMentRequest> {


  int id = 0;
  String name = 'name';
  String token = 'token';
  String email = 'email';
  String role = 'role';
  List<Appointments> appointments = [];



  fetchDoctors() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    name = prefs.getString('name')!;
    email = prefs.getString('email')!;
    role = prefs.getString('role')!;
    // await prefs.getString('device_token');
    id = prefs.getInt('id')!;
    if (token == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    setState(() {

    });

    var url = Uri.parse(baseUrl + '/appointment-list-doctor/'+prefs.getInt('id')!.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('appointment-list-doctor: ${response.body}.');
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        if (jsonResponse['appointments'] != null) {
          appointments = [];
          jsonResponse['appointments'].forEach((v) {
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
    fetchDoctors();
    _saveDeviceToken();
  }

  _saveDeviceToken() async {
    // String? token = '';
    // FirebaseMessaging.instance.getToken().then((value) {
    //   token = value;
    // });
    String? token = await FirebaseMessaging.instance.getToken();
    print('firebase message token $token');
    final prefs = await SharedPreferences.getInstance();
    var url =  Uri.parse(baseUrl+'/toke');
    var response = await http.post(url,body:{
      'id':prefs.getInt('id').toString(),
      'token':token,

    });

    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body}.');
      var jsonResponse = jsonDecode(response.body);
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

    // /toke/{id}/{token}

  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        return await fetchDoctors();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Appointments request lists'),
            actions: [
              GestureDetector(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const History2Screen()));
                },
                child: Center(

                  child: Text('History'),
                ),
              )
            ],
          ),
          body: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(
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
