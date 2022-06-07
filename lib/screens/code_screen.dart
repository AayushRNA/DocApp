import 'dart:convert';

import 'package:doctor_app/helper/fade_animation.dart';
import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/screens/password_reset.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({Key? key}) : super(key: key);

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {


  var _email = TextEditingController();
  var _code = TextEditingController();

  login() async {
    print('login');


    var url =  Uri.parse(baseUrl+'/2/forget/password/'+_email.text+'/'+_code.text);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body}.');
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['code'] == false){
        //store data
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', _email.text);
        await prefs.setString('code', _code.text);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PasswordReset()));

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

        resizeToAvoidBottomInset: false,
        appBar:  AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Forget password",
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
                        "Email and code enter here",
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
                          "Code",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          obscureText: false,
                          controller: _code,
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
                          'Next ',
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




            ],
          ),
        ),
      ),
    );
  }
}
