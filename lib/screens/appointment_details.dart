
import 'dart:convert';

import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/models/Prescription.dart';
import 'package:doctor_app/models/appoinment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class APpointmentsDetails extends StatefulWidget {
   APpointmentsDetails({Key? key,required this.appointments}) : super(key: key);
   Appointments  appointments;
  @override
  State<APpointmentsDetails> createState() => _APpointmentsDetailsState();
}

class _APpointmentsDetailsState extends State<APpointmentsDetails> {
  int id = 0;
  String token = 'token';
  String role = '';
  var medicine = TextEditingController();
  var dosage = TextEditingController();
  var instruction = TextEditingController();
  List<Prescriptions> prescriptions = [];
  bootData() async{
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    role =  prefs.getString('role')!;
    print(role);
  }

  showAllp() async{
    var url = Uri.parse(baseUrl + '/prescription-list/'+widget.appointments.id.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body}.');
      var json = jsonDecode(response.body);
      if (json['prescriptions'] != null) {
        prescriptions = [];
        json['prescriptions'].forEach((v) {
          prescriptions.add(Prescriptions.fromJson(v));
        });
      }
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
    setState(() {

    });
  }


  submit() async{
    var url =  Uri.parse(baseUrl+'/give-prescription');
    var response = await http.post(url,body:{
      'appointment_id':widget.appointments.id.toString(),
      'patient_id':widget.appointments.patientId.toString(),
      'doctor_id':widget.appointments.doctorId.toString(),
      'medicine':medicine.text,
      'dosage':dosage.text,
      'instruction':instruction.text,
    });

    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body}.');
      var jsonResponse = jsonDecode(response.body);

      Fluttertoast.showToast(
          msg: "${jsonResponse['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      showAllp();
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAllp();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bootData();
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: RefreshIndicator(
        onRefresh: () async{
          return await showAllp();
        },
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          children: [
          Container(
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
                  Text('${widget.appointments.date}',style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),)
            ],
          ),
        ),
            SizedBox(
              height: 25,
            ),
            Column(
              children: [
                TextField(
                  controller: medicine,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: "Write the medicine",
                    labelText: 'medicine',
                    floatingLabelBehavior: FloatingLabelBehavior.always,

                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: dosage,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: "Write the dosage",
                    labelText: 'dosage',
                    floatingLabelBehavior: FloatingLabelBehavior.always,

                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: instruction,
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder:  OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(15.0),
                      // borderSide: BorderSide(color: blackSemiColor),
                    ),
                    hintText: "instruction*",
                    labelText: 'instruction*',
                    floatingLabelBehavior: FloatingLabelBehavior.always,

                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GFButton(
                  onPressed: () {
                    submit();
                  },
                  text: "give prescription",
                  textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  icon: const Icon(FontAwesomeIcons.solidSave, size: 16),
                  shape: GFButtonShape.standard,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 600,
              child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: prescriptions.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: size.width,
                      padding: EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Medicine: ${prescriptions[index].medicine}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),

                          Text(
                            'Dosage: ${prescriptions[index].dosage}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),

                          Text(
                            'Instruction: ${prescriptions[index].instruction}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),

            const SizedBox(
              height: 25,
            ),

          ],
        ),
      ),
    ));
  }
}
