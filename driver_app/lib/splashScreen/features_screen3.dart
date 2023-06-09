import 'dart:async';


import 'package:drivers_app/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import "package:lottie/lottie.dart";
import '../authentication/signup_screen.dart';
class FeaturesScreen3 extends StatefulWidget {


  @override
  State<FeaturesScreen3> createState() => _FeaturesScreen3State();
}

class _FeaturesScreen3State extends State<FeaturesScreen3> {

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 270,
      height: 650,
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 3, top: 53, bottom: 37, ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Container(
                width: 357,
                height: 250,
                child:Lottie.asset('images/payments.json'),
                // decoration: const BoxDecoration(
                //     image: DecorationImage(
                //     image: AssetImage(
                //          'assets/images/3643906.jpg'),
                //     fit: BoxFit.fill)),
              ),
              SizedBox(height: 65),
              const SizedBox(
                width: 350,
                height: 73,
                child: Text(
                  "      Enjoy the special ride \n             with AngelLyft",

                  style: TextStyle(
                    color: Color(0xff484545),
                    fontSize: 26.50,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 73),
              SizedBox(
                width: 312,
                height: 50,
                child: ElevatedButton(

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style:ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadowColor: Colors.black,
                        elevation:20
                    ),
                    child:const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                      ),
                    )

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}