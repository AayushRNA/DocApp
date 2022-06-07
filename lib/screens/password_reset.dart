
import 'dart:convert';

import 'package:doctor_app/helper/fade_animation.dart';
import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {


  var pass = TextEditingController();

  register() async{
    print('register');
    final prefs = await SharedPreferences.getInstance();
    var url =  Uri.parse(baseUrl+'/3/forget/password');
    var response = await http.post(url,body:{
      'email':prefs.getString('email')!,
      'password':pass.text,
      'code':prefs.getString('code')!,
    });

    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body}.');
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['error'] == false){
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
            "Password reset",
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
                              'Save',
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
