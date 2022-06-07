

import 'dart:convert';

import 'package:doctor_app/helper/fade_animation.dart';
import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/screens/decome_a_doctor.dart';
import 'package:doctor_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var pass = TextEditingController();

  register() async{
print('register');
    var url =  Uri.parse(baseUrl+'/register');
    var response = await http.post(url,body:{
      'email':email.text,
      'password':pass.text,
      'phone':phone.text,
      'role':'patient',
      'name':name.text,
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
            "Registration",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          elevation: 0,

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
                    SizedBox(height: 20,),
                    Text("Create an account, It's free", style: TextStyle(
                        fontSize: 20
                    )),
                  ],
                ),
                const SizedBox(height: 20,),
                Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Username', style: TextStyle(
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
                        Text('Phone number', style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),),
                        const SizedBox(height: 5,),
                        TextField(
                          controller: phone,
                          keyboardType: TextInputType.number,
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
                    )

                  ],
                ),
                FadeAnimation(
                    1.4,
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.black),
                      ),
                      child: GestureDetector(
                          onTap: (){
                            register();
                          },
                          child: const Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                                'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                backgroundColor: Colors.black,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                      ),
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
                const SizedBox(height: 60,),
                FadeAnimation(1.6, Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Become a doctor?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const BecomeADoctor()));
                      },
                      child:const Text("Register", style:  TextStyle(
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