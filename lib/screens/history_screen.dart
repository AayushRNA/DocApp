
import 'dart:convert';

import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/models/historyappoint.dart';
import 'package:doctor_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  int id = 0;
  String token = 'token';
  String device_token = 'device_token';
  List<Historyappoint> historyappoint = [];
  fetchAllData() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    device_token = prefs.getString('device_token')!;
    // await prefs.getString('device_token');
    id = prefs.getInt('id')!;
    if (token == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }

    var url = Uri.parse(baseUrl + '/doctor-history-for-p/'+prefs.getInt('id')!.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Number of books about http: ${response.body}.');
      var json = jsonDecode(response.body);
      setState(() {
        if (json['historyappoint'] != null) {
          historyappoint = [];
          json['historyappoint'].forEach((v) {
            historyappoint.add(Historyappoint.fromJson(v));
          });
        }
      });
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: historyappoint.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.abc),
            title: Text('${historyappoint[index].subject}'),
            subtitle: Text('Doctor: ${historyappoint[index].doctorName}, Date: ${historyappoint[index].createdAt}'),
            trailing: Icon(Icons.food_bank),
          );
        });
  }

}


