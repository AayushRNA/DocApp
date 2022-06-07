
import 'dart:convert';

import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/models/doctors_model.dart';
import 'package:doctor_app/widgets/doctor_card_one.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class DoctorScreen2 extends StatefulWidget {
   DoctorScreen2({Key? key,required this.t}) : super(key: key);
  String t;

  @override
  State<DoctorScreen2> createState() => _DoctorScreen2State();
}

class _DoctorScreen2State extends State<DoctorScreen2> {

  List<Doctors> doctors = [];

  fetchDoctors() async {
    var url = Uri.parse(baseUrl + '/filter/'+widget.t);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body}.');
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        if (jsonResponse['doctors'] != null) {
          jsonResponse['doctors'].forEach((v) {
            doctors.add(Doctors.fromJson(v));
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Doctors'),
        ),
        body:  ListView.builder(
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            itemCount: doctors.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  DoctorCardOne(
                      id: doctors[index].id,
                      name: doctors[index].name,
                      speciality: doctors[index].speciality),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
