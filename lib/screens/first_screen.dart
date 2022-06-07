import 'dart:convert';

import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/models/doctors_model.dart';
import 'package:doctor_app/screens/doctors_screen.dart';
import 'package:doctor_app/screens/login_screen.dart';
import 'package:doctor_app/widgets/cat_card.dart';
import 'package:doctor_app/widgets/doctor_card_one.dart';
import 'package:doctor_app/widgets/doctor_card_tow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int id = 0;
  String name = 'name';
  String token = 'token';
  String email = 'email';
  String role = 'role';
  List<Doctors> doctors = [];

  featchDataSF() async {
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
    setState(() {});
  }

  fetchDoctors() async {
    var url = Uri.parse(baseUrl + '/all-doctors');
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
    featchDataSF();
    fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 2),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Text(name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ))
            ]),
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/img.png"),
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
        // Padding(
        //   padding: EdgeInsets.only(top: 20, bottom: 10),
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const DoctorScreens()));
        //     },
        //     child: Container(
        //       height: 60,
        //       decoration: BoxDecoration(
        //           color: Colors.white70,
        //           borderRadius: BorderRadius.circular(16.0),
        //           border: Border.all(color: Colors.black45, width: 2)),
        //       child: Row(
        //         children: [
        //           IconButton(
        //               onPressed: () {},
        //               icon: const Icon(Icons.search, color: Colors.black54)),
        //           const Text(
        //             'Search By The Doctor Name',
        //             style: TextStyle(
        //               color: Colors.black54,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 100,
          child: ListView.builder(
              shrinkWrap: false,
              itemCount: doctors.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return CatCard(
                  title: doctors[index].speciality,
                );
              }),
        ),
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'My Appointments',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        // DoctorCardTwo(),
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Top Rated Doctors',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          child: Scrollbar(
            child: ListView.builder(
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
          height: 1000,
        ),
      ],
    );
  }
}
