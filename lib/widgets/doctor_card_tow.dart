
import 'package:doctor_app/models/appoinment.dart';
import 'package:doctor_app/screens/appointment_details.dart';
import 'package:flutter/material.dart';

class DoctorCardTwo extends StatefulWidget {
   DoctorCardTwo({Key? key,required this.appointments}) : super(key: key);
  Appointments appointments;
  @override
  State<DoctorCardTwo> createState() => _DoctorCardTwoState();
}

class _DoctorCardTwoState extends State<DoctorCardTwo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>APpointmentsDetails(appointments: widget.appointments)));
      },
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.appointments.status == '1' ? Colors.green : Colors.grey,
            width: 2,
          ), //Border.all
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Text('${widget.appointments.subject}',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('${widget.appointments.desc}',style: TextStyle(color: Colors.black45,fontSize: 14),)
                    ],
                  ),
                )
              ],
            ),
            Divider(
              height: 10,
              color: Colors.grey,
            ),
            Padding(padding: EdgeInsets.all(8),child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Icon(Icons.access_time),
                Text('${widget.appointments.date} ${widget.appointments.time}',style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
