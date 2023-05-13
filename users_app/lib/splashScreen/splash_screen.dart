import 'dart:async';


import 'package:flutter/material.dart';
import 'package:users_app/authentication/login_screen.dart';

import '../assistants/assistants_method.dart';
import '../global/global.dart';
import '../mainScreens/main_screen.dart';




class MySplachScreen extends StatefulWidget {
  const MySplachScreen({Key? key}) : super(key: key);

  @override
  State<MySplachScreen> createState() => _MySplachScreenState();
}

class _MySplachScreenState extends State<MySplachScreen> {
  startTimer(){
    fAuth.currentUser!=null?AssistantMethods.readCurrentOnlineUserInfo() :null;
    Timer(const Duration(seconds: 3),()async{
      if(await fAuth.currentUser!=null){
        currentFirebaseUser=fAuth.currentUser;
        Navigator.push(context,MaterialPageRoute(builder: (c)=> MainScreen()));


      }else{
        //send user to loginScreen
        Navigator.push(context,MaterialPageRoute(builder: (c)=> LoginScreen()));
      }

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
  }


  @override
  Widget build(BuildContext context) {

    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.png"),


              const SizedBox(height: 10,),


              const Text(
                "RideEasy",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
