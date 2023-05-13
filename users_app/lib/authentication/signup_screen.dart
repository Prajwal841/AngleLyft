
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/splashScreen/splash_screen.dart';

import '../global/global.dart';
import '../widgets/progress_dialogue.dart';

class SignUpScreen extends StatefulWidget {


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController= TextEditingController();
  TextEditingController emailTextEditingController= TextEditingController();
  TextEditingController phoneTextEditingController= TextEditingController();
  TextEditingController passwordTextEditingController= TextEditingController();

validateForm(){
  //as it is outside class it is called function if it was inside class it would be method
  if(nameTextEditingController.text.length<3){
    Fluttertoast.showToast(msg:"Name Must be atleast 3 Characters");
  }
  else if(!emailTextEditingController.text.contains("@")){
    Fluttertoast.showToast(msg:"Invalid email missing @ symbol");

  }
  else if(phoneTextEditingController.text.isEmpty){
    Fluttertoast.showToast(msg:"Phone number is required");

  }
  else if(passwordTextEditingController.text.length<6){
    Fluttertoast.showToast(msg:"Password must be greater than 6 characters");

  }else{
    saveUserInfoNow();

  }
}

saveUserInfoNow() async{

  showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext c){
  return ProgressDialogue(message: "Request is Processing...",);
  }
  );

  final User? firebaseUser=(
  await fAuth.createUserWithEmailAndPassword(
    email: emailTextEditingController.text.trim(),
    password: passwordTextEditingController.text.trim(),
  ).catchError((msg){
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Error: "+msg.toString());
  })
  ).user;

  if(firebaseUser !=null){
    Map usersMap={
      "id":firebaseUser.uid,
      "name":nameTextEditingController.text.trim(),
      "email":emailTextEditingController.text.trim(),
      "phone":phoneTextEditingController.text.trim(),
    };
    
    DatabaseReference reference=FirebaseDatabase.instance.ref().child("users");
    reference.child(firebaseUser.uid).set(usersMap);


    currentFirebaseUser =firebaseUser;
    Fluttertoast.showToast(msg: "Account been Created");

    Navigator.push(context,MaterialPageRoute(builder:(c)=> MySplachScreen()));

  }
  else{
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Account has not been Created");
  }
}

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo.png"),
              ),

              const SizedBox(height: 10,),

              const Text(
                "Register as a User",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),

              ),
              TextField(
                controller: nameTextEditingController,
                style: const TextStyle(
                  color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Your Name",

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
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Enter Your Phone Number",

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
                  "Create Account",
                  style:TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ),

              TextButton(
                child: const Text(
                  "Already have an Account? Login Here",
                  style: TextStyle(color:Colors.grey ),
                ),
                onPressed:() {
                  Navigator.push(context,MaterialPageRoute(builder: (c)=>LoginScreen()) );
                },
              ),

            ],


          ),
        ),
      ),

    );
  }
}
