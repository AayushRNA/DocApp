import 'package:doctor_app/helper/helper.dart';
import 'package:doctor_app/models/splash_model.dart';
import 'package:doctor_app/screens/login_screen.dart';
import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget {

  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var currentPageIndex = 0;

  PageController pageController = PageController(initialPage: 0);

  bool get isLastPage => currentPageIndex == splashList.length - 1;

  forwardAction() {

    if (isLastPage) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const LoginScreen() ));
    } else {
      pageController.nextPage(duration: const Duration(milliseconds: 300) , curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                  onPageChanged:(index){
                  setState(() {
                    currentPageIndex = index;
                  });
                  },

                  itemCount: splashList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(splashList[index].imageAsset),
                        const SizedBox(height: 32),
                        Text(splashList[index].title,
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: Text(splashList[index].description,
                            style: TextStyle(color: Colors.black,fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    );
                  }),
              Positioned(
                bottom: 20,
                left: 20,
                child: Row(
                  children: List<Widget>.generate(splashList.length, (index) =>  Container(
                  margin: const EdgeInsets.all(4),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color:
                    currentPageIndex == index
                    ? activeDropPointSplashScreen
                    : deactivateDropPointSplashScreen,
                    shape: BoxShape.circle,
                  ),
                ) ),
                ),
              ),
              Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    onPressed: (){
                      forwardAction();
                    },
                    elevation: 0,
                    child: const Text('Next'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
