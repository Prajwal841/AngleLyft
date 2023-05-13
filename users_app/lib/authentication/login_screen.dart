
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authentication/signup_screen.dart';

import '../global/global.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_dialogue.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController= TextEditingController();
  TextEditingController passwordTextEditingController= TextEditingController();

  validateForm(){
    //as it is outside class it is called function if it was inside class it would be method

    if(!emailTextEditingController.text.contains("@")){
      Fluttertoast.showToast(msg:"Invalid email missing @ symbol");

    }
    else if(passwordTextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg:"Password is Required");

    }else{
      loginUserNow();

    }
  }
  loginUserNow() async{

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c){
          return ProgressDialogue(message: "User is Being Login...",);
        }
    );

    final User? firebaseUser=(
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: "+msg.toString());
        })
    ).user;

    if(firebaseUser !=null){

      DatabaseReference driverRef=FirebaseDatabase.instance.ref().child("users");
      driverRef.child(firebaseUser.uid).once().then((driverKey){
        final snap =driverKey.snapshot;
        if(snap.value!=null){
          currentFirebaseUser =firebaseUser;
          Fluttertoast.showToast(msg: "Login Successfull");

          Navigator.push(context,MaterialPageRoute(builder:(c)=>const MySplachScreen()));

        }
        else{
          Fluttertoast.showToast(msg: "No record exist with this email");

          fAuth.signOut();
          Navigator.push(context,MaterialPageRoute(builder:(c)=>const MySplachScreen()));

        }

      });


    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured during login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo.png"),
              ),
              const SizedBox(height: 10,),

              const Text(
                "Login as a User",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),

              ),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Your Email",

                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  hintStyle: TextStyle(
                    color:Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle:  TextStyle(
                    color:Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Your Password",

                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  hintStyle: TextStyle(
                    color:Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle:  TextStyle(
                    color:Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed:(){
                  validateForm();

                } ,
                style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreenAccent
                ),
                child: const Text(
                  "Login",
                  style:TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ),
              
              TextButton(
                child: const Text(
                  "Do not have an Account? SignUp Here",
                  style: TextStyle(color:Colors.grey ),
                ),
                onPressed:() {
                  Navigator.push(context,MaterialPageRoute(builder: (c)=>SignUpScreen()) );
                },
              ),
            ],

    ),
        ),
    ),


    );
  }
}
