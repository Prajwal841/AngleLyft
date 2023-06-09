import 'package:drivers_app/authentication/car_info_screen.dart';
import 'package:drivers_app/authentication/login_screen.dart';
import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SignUpScreen extends StatefulWidget
{
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm()
  {
    if(nameTextEditingController.text.length < 3)
    {
      Fluttertoast.showToast(msg: "name must be atleast 3 Characters.");
    }
    else if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    }
    else if(phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Phone Number is required.");
    }
    else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Password must be atleast 6 Characters.");
    }
    else
    {
      saveDriverInfoNow();
    }
  }

  saveDriverInfoNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );

    final User? firebaseUser = (
      await fAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      ).catchError((msg){
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error: " + msg.toString());
      })
    ).user;

    if(firebaseUser != null)
    {
      Map driverMap =
      {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,20,10,5),
          child: Column(
            children: [


              Container(
                alignment: Alignment.center,

                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "images/reg.png"),
                        fit: BoxFit.fill)),
                height: 226,
                width: 280,),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10,5,10,5),
                  child: const Text(
                    'Register as Driver',
                    style: TextStyle(fontSize: 33,fontWeight:FontWeight.w500,fontFamily: 'Urbanist',color: Colors.blueGrey),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(10,10,10,5),
                // width: 379,
                // height: 75,

                child: TextField(

                  controller: nameTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none
                    ),
                    fillColor: Colors.amber.withOpacity(0.1),
                    filled: true,
                    prefixIcon: Icon(Icons.person,color: Colors.amber,),
                    labelText: 'User Name',
                    labelStyle: const TextStyle(
                      //color: Colors.black38,
                      fontFamily: "Urbanist",
                    ),
                  ),
                ),

              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10,10,10,5),
                child: TextField(

                  controller: emailTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none
                    ),
                    fillColor: Colors.amber.withOpacity(0.1),
                    filled: true,
                    prefixIcon: Icon(Icons.email,color: Colors.amber,),
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      fontFamily: "Urbanist",
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10,10,10,5),
                child: TextField(

                  controller: phoneTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none
                    ),
                    fillColor: Colors.amber.withOpacity(0.1),
                    filled: true,
                    prefixIcon: Icon(Icons.phone,color: Colors.amber,),
                    labelText: 'Phone',
                    labelStyle: const TextStyle(
                      fontFamily: "Urbanist",
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10,10,10,0),
                child: TextField(
                  obscureText: true,
                  controller: passwordTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none
                    ),
                    fillColor: Colors.amber.withOpacity(0.1),
                    filled: true,
                    prefixIcon: Icon(Icons.lock,color: Colors.amber,),
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      fontFamily: "Urbanist",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                  height: 80,
                  width: 320,
                  padding: const EdgeInsets.fromLTRB(10,20,10,5),
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(

                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      shadowColor: Colors.black,
                      elevation:5,
                    ),
                    onPressed: () {
                      validateForm();
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));
                    },
                    child: const Text('Sign Up',style: TextStyle(fontSize: 25,fontFamily: 'Urbanist'),),
                  )
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  const Text('Already have an account?'),

                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20,fontFamily: 'Urbanist'),
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

