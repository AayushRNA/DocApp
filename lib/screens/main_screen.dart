
// ignore_for_file: unnecessary_this

import 'dart:convert';

import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/screens/account_screen.dart';
import 'package:doctor_app/screens/appointment_request.dart';
import 'package:doctor_app/screens/appointment_screen.dart';
import 'package:doctor_app/screens/first_screen.dart';
import 'package:doctor_app/screens/history_screen.dart';
import 'package:doctor_app/screens/member_profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;
 int id = 0;
 String  name = 'name';
String  token = 'token';
String  email = 'email';
String  role = 'role';


  featchDataSF() async{
     final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
       name = prefs.getString('name')!;
   email =  prefs.getString('email')!;
    role =  prefs.getString('role')!;
          // await prefs.getString('device_token');
    id =  prefs.getInt('id')!;
     if(role == 'doctor'){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AppointMentRequest()));
     }else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainScreen()));
     }
    setState(() {

    });

  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _saveDeviceToken();
    // featchDataSF();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  final List<Widget> _pages = <Widget>[
    const FirstScreen(),
    const AppointmentScreen(),
    const MemberProfile(),
    const HistoryScreen(),
  ];


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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, //
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_add),
              label: 'Appointment',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: 'Account',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.list),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}




