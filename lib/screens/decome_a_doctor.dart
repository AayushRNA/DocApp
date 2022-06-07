import 'dart:convert';

import 'package:doctor_app/helper/fade_animation.dart';
import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
class BecomeADoctor extends StatefulWidget {
  const BecomeADoctor({Key? key}) : super(key: key);

  @override
  State<BecomeADoctor> createState() => _BecomeADoctorState();
}

class _BecomeADoctorState extends State<BecomeADoctor> {
  var name = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var speciality = TextEditingController();
  var qualification = TextEditingController();
  var experience = TextEditingController();
  var address = TextEditingController();
  var phone = TextEditingController();

  register() async{

    var url =  Uri.parse(baseUrl+'/register/doctor');
    var response = await http.post(url,body:{
      'email':email.text,
      'password':pass.text,
      'role':'doctor',
      'name':name.text,
      'speciality':speciality.text,
      'qualification':qualification.text,
      'experience':experience.text,
      'address':address.text,
      'phone':phone.text,
    });

    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body}.');
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['result'] == true){
        //store data


        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      }else{
        Fluttertoast.showToast(
            msg: "${jsonResponse['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Doctor Registration",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.notifications,
                    color: Colors.black)),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert,
                  color:  Colors.black),
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width / 2.2,maxHeight: 140 ),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/logo.png')),
                    ),
                  ),
                ),
                Column(
                  children: const <Widget>[
                    Text("Sign up", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 20,),
                    Text("Become a doctor, It's free", style: TextStyle(
                        fontSize: 15
                    )),
                  ],
                ),
                const SizedBox(height: 20,),
                Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Username', style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: name,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Email', style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: email,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Password', style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: pass,
                          obscureText: true,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('speciality', style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: speciality,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('qualification', style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: qualification,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('experience', style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: experience,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('address', style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: address,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('phone', style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: phone,
                          obscureText: false,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
                  ],
                ),
                FadeAnimation(
                    1.4,
                    GestureDetector(
                        onTap: (){
                          register();
                        },
                        child: const Text(
                            'Registration',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                backgroundColor: Colors.black,
                                color: Colors.white,
                              ),
                        )
                    )
                ),


                const SizedBox(height: 20,),
                FadeAnimation(1.6, Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                      },
                      child:const Text(" Login", style:  TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18
                      ),),
                    ),
                  ],
                )),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),),
        const SizedBox(height: 5,),
        TextField(
          obscureText: obscureText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
          ),
        ),
        const SizedBox(height: 30,),
      ],
    );
  }
}
