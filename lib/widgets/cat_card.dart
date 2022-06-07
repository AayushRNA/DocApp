import 'package:doctor_app/screens/doctors_screen_2.dart';
import 'package:flutter/material.dart';

class CatCard extends StatefulWidget {
  CatCard({Key? key,required this.title}) : super(key: key);
  String title;
  @override
  State<CatCard> createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorScreen2(t: widget.title)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding:
          EdgeInsets.all(8),
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '${widget.title}',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
