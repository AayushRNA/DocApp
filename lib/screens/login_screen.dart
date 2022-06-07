
import 'dart:convert';
import 'dart:io';

import 'package:doctor_app/helper/fade_animation.dart';
import 'package:doctor_app/helper/helper.dart';

import 'package:doctor_app/screens/appointment_request.dart';
import 'package:doctor_app/screens/decome_a_doctor.dart';
import 'package:doctor_app/screens/email_screen.dart';
import 'package:doctor_app/screens/main_screen.dart';
import 'package:doctor_app/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var _email = TextEditingController();
  var _pass = TextEditingController();


  checktheAuth() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString('token') != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainScreen()));
    }
  }

  login() async {
    print('login');
    print(_email.text);
    print(_pass.text);

    var url =  Uri.parse(baseUrl+'/login');
    var response = await http.post(url,body:{
          'email':_email.text,
          'password':_pass.text,
          'role':'patient',
        });
       
    if (response.statusCode == 200) {
        print('Number of books about http: ${response.body}.');
      var jsonResponse = jsonDecode(response.body);
    
    if(jsonResponse['result'] == true){
      //store data 
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', jsonResponse['token']);
       await prefs.setString('name', jsonResponse['name']);
        await prefs.setString('email', jsonResponse['email']);
         await prefs.setString('role', jsonResponse['role']);
          await prefs.setString('device_token', jsonResponse['device_token']);
           await prefs.setInt('id', jsonResponse['id']);

           if(jsonResponse['role'] == 'doctor'){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AppointMentRequest()));
           }else{
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainScreen()));
           }

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
  void initState() {
    // TODO: implement initState
    super.initState();
    checktheAuth();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(

        resizeToAvoidBottomInset: false,
        appBar:  AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
            ),
          ),
          elevation: 0,

        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: size.width / 2.2, maxHeight: 140),
                    child: Container(
                      decoration: const BoxDecoration(
                        image:
                        DecorationImage(image: AssetImage('assets/logo.png')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const FadeAnimation(
                      1.2,
                      Text(
                        "Login to your account",
                        style: TextStyle(fontSize: 18,),
                      )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(1.2, Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          obscureText: false,
                          controller: _email,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    )),
                    FadeAnimation(
                        1.3, Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Password",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          obscureText: true,
                          controller: _pass,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              FadeAnimation(
                  1.4,
                  GestureDetector(
                    onTap: ()  {
                        login(); 
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black),
                      ),
                      child: const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                            'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            backgroundColor: Colors.black,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),

              const SizedBox(
                height: 20,
              ),
              FadeAnimation(
                  1.5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Forget password"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const EmailScreen()));
                        },
                        child: const Text(
                          " Reset now",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ],
                  )),

              FadeAnimation(
                  1.5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));
                        },
                        child: const Text(
                          "  Register Now",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20,),
              FadeAnimation(1.6, Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Become a doctor?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const BecomeADoctor()));
                    },
                    child:const Text(" Register Now", style:  TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18
                    ),),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
