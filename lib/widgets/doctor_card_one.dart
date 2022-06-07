
import 'package:doctor_app/screens/account_screen.dart';
import 'package:doctor_app/screens/doctor_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorCardOne extends StatefulWidget {
   DoctorCardOne({Key? key,required this.name,required this.speciality,required this.id}) : super(key: key);
  String name;
  String speciality;
  int id = 0;

  @override
  State<DoctorCardOne> createState() => _DoctorCardOneState();
}

class _DoctorCardOneState extends State<DoctorCardOne> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AccoutnScreen(id: widget.id,)));
      },
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ), //Border.all
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage:
                AssetImage('assets/doctor.png'),
                // backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text('${widget.name}',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                Text('${widget.speciality}',style: TextStyle(color: Colors.black45,fontSize: 14),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
