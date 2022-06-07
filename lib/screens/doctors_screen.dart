
import 'package:doctor_app/widgets/doctor_card_one.dart';
import 'package:doctor_app/widgets/doctor_card_tow.dart';
import 'package:flutter/material.dart';

class DoctorScreens extends StatefulWidget {
  const DoctorScreens({Key? key}) : super(key: key);

  @override
  State<DoctorScreens> createState() => _DoctorScreensState();
}

class _DoctorScreensState extends State<DoctorScreens> {

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Doctors'),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Container(
              width: size.width,
              padding: EdgeInsets.only(bottom: 10),
              child: const TextField (
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                    labelText: 'Enter Name',
                    hintText: 'Enter Your Name'
                ),
              ),
            ),
            // DoctorCardOne(),
            SizedBox(
              height: 8,
            ),
          // DoctorCardTwo(),
          ],
        ),
      ),
    );
  }
}
