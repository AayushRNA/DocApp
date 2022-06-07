
import 'package:doctor_app/screens/account_screen.dart';
import 'package:doctor_app/screens/appointment_screen.dart';
import 'package:doctor_app/screens/first_screen.dart';
import 'package:doctor_app/screens/member_profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {

  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const FirstScreen(),
    const AppointmentScreen(),
    const MemberProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          ],
        ),
      ),
    );
  }
}




