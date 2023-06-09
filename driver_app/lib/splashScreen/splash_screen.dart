import 'dart:async';

import 'package:drivers_app/authentication/login_screen.dart';
import 'package:drivers_app/authentication/signup_screen.dart';
import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/mainScreens/main_screen.dart';
import 'package:drivers_app/splashScreen/features_screen.dart';
import 'package:flutter/material.dart';
import "package:lottie/lottie.dart";

class MySplashScreen extends StatefulWidget
{
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}



class _MySplashScreenState extends State<MySplashScreen>
{

  startTimer()
  {
    Timer(const Duration(seconds: 4), () async
    {
      if(await fAuth.currentUser != null)
      {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=>FeaturesScreen ()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    
    startTimer();
  }
  
  @override
  Widget build(BuildContext context)
  {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Lottie.asset("images/asplashscreen.json"),


              const SizedBox(height: 10,),

              const Text('AngelLyft',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(110, 101, 101, 1)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
