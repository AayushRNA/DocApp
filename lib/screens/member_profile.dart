
import 'package:doctor_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/avatar_widget.dart';

class MemberProfile extends StatefulWidget {
  const MemberProfile({Key? key}) : super(key: key);

  @override
  State<MemberProfile> createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {

  int id = 0;

  String  name = 'name';

  String  token = 'token';

  String  email = 'email';

  String  role = 'role';

  featchDataSF() async{
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    name = prefs.getString('name')!;
    email =  prefs.getString('email')!;
    role =  prefs.getString('role')!;
    // await prefs.getString('device_token');
    id =  prefs.getInt('id')!;

    if(token == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
    }
    setState(() {

    });

  }

  logout() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    featchDataSF();
    Size size = MediaQuery.of(context).size;

    return SafeArea (
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        // customAppBar('Profile', 'home',true,context),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 14),
            AvatarWidget(
              editShow : false,
              imagePath: 'assets/doctor.png',
              onClicked: () async {},
            ),
             const SizedBox(height: 24),
            buildName(context,size),
             const SizedBox(height: 24),
             const SizedBox(height: 24),
             const SizedBox(height: 48),
            buildAbout(),
            const SizedBox(height: 24),
            GestureDetector(
                onTap: (){
                  logout();
                },
                child: const Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          backgroundColor: Colors.black,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                )
            )
          ],
        ),
      ),
    );
  }

  Widget buildName(context,size) => Column(
    children: [
       Text(
        '$name'.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
       const SizedBox(height: 4),
       Text(
        '$email',
        style: TextStyle(color: Colors.grey),
      ),
      // const Text(
      //   '+8801685755707',
      //   style: TextStyle(color: Colors.grey),
      // ),
      const SizedBox(height: 4),
    ],
  );

  Widget buildAbout() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Health articles that keep you informed about good health practices and achieve your goals.',
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}
