import 'dart:convert';

import 'package:doctor_app/models/doctors_model.dart';
import 'package:doctor_app/screens/appointment_create..dart';
import 'package:doctor_app/screens/login_screen.dart';
import 'package:doctor_app/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/helper.dart';
import 'package:http/http.dart' as http;

class AccoutnScreen extends StatefulWidget {
  AccoutnScreen({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<AccoutnScreen> createState() => _AccoutnScreenState();
}

class _AccoutnScreenState extends State<AccoutnScreen> {
  int id = 0;
  late Doctors doctor;
  bool _hasCallSupport = false;
  Future<void>? _launched;

  featchDataSF() async {
    var url = Uri.parse(baseUrl + '/doctor/profile/' + widget.id.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body}.');
      var jsonResponse = jsonDecode(response.body);
      doctor = Doctors.fromJson(jsonResponse);
      setState(() {});
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

    canLaunchUrl(Uri(scheme: 'tel', path: '${doctor.phone}')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });

    canLaunchUrl(Uri(scheme: 'sms', path: '${doctor.phone}')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featchDataSF();


    // canLaunchUrl(Uri(scheme: 'sms', path: doctor.phone)).then((bool result) {
    //   setState(() {
    //     _hasCallSupport = result;
    //   });
    // });

  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeSmsCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        // customAppBar('Profile', 'home',true,context),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 14),
            AvatarWidget(
              editShow: false,
              imagePath: 'assets/doctor.png',
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            buildName(context, size),
            const SizedBox(height: 24),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentCreate(
                                doctorId: doctor.id,
                              )));
                },
                child: Container(
                  height: 40,
                  width: 200,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).indicatorColor,
                  ),
                  child: Center(
                      child: const Text(
                    'Appointments',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 48),
            buildAbout(),
            const SizedBox(height: 16),
            buildAbout2(),
            const SizedBox(height: 16),
            buildAbout3(),
            const SizedBox(height: 16),
            buildAbout4(),
          ],
        ),
      ),
    );
  }

  Widget buildName(context, size) => Column(
        children: [
          Text(
            '${doctor.name}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            '${doctor.email}',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            doctor.phone,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),

          // const Text(
          //   '(765) Rating',
          //   style: TextStyle(color: Colors.grey),
          // ),
          SizedBox(
            height: 50,
            width: size.width / 1.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GFButton(
                  onPressed: _hasCallSupport
                      ? () => setState(() {
                            _launched = _makePhoneCall(doctor.phone);
                          })
                      : null,
                  color: Colors.grey,
                  shape: GFButtonShape.standard,
                  size: GFSize.LARGE,
                  child: Icon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey,
                  ),
                  type: GFButtonType.transparent,
                ),
                GFButton(
                  onPressed: _hasCallSupport
                      ? () => setState(() {
                    _launched = _makeSmsCall(doctor.phone);
                  })
                      : null,
                  color: Colors.grey,
                  shape: GFButtonShape.standard,
                  child: Icon(
                    FontAwesomeIcons.message,
                    color: Colors.grey,
                  ),
                  size: GFSize.LARGE,
                  type: GFButtonType.transparent,
                ),
                GFButton(
                  onPressed: () {},
                  color: Colors.grey,
                  shape: GFButtonShape.standard,
                  size: GFSize.LARGE,
                  child: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.grey,
                  ),
                  type: GFButtonType.transparent,
                ),
              ],
            ),
          )
        ],
      );

  Widget buildAbout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Speciality',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '${doctor.speciality}.',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildAbout2() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Qualification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '${doctor.qualification}.',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildAbout3() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'experience',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '${doctor.experience}.',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildAbout4() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'address',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '${doctor.address}.',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
