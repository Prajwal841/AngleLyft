import 'package:drivers_app/authentication/forgot_password.dart';
import 'package:drivers_app/authentication/signup_screen.dart';
import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/splashScreen/splash_screen.dart';
import 'package:drivers_app/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginScreen extends StatefulWidget
{

  @override
  _LoginScreenState createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm()
  {
    if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    }
    else if(passwordTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is required.");
    }
    else
    {
      loginDriverNow();
    }
  }

  loginDriverNow() async
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
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).once().then((driverKey)
      {
        final snap = driverKey.snapshot;
        if(snap.value != null)
        {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
        else
        {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
      });
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/reg.png"),
              ),

              const SizedBox(height: 10,),

              const Text(
                "Login as a Driver",
                style: TextStyle(
                  fontSize: 26,
                  color:  Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20,),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.email,color: Colors.blue,),
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    fontFamily: "Urbanist",
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                  ),
                  fillColor: Colors.yellowAccent.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.lock,color: Colors.amber,),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    fontFamily: "Urbanist",
                  ),
                ),
              ),

              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle( color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Urbanist'),
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> ForgotPasswordScreen()));
                  },
                ),
              ),
              const SizedBox(height: 10,),

              ElevatedButton(
                onPressed: ()
                {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(70,15,70,15),
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  shadowColor: Colors.grey,
                  elevation:5,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Urbanist'
                  ),
                ),
              ),

              const SizedBox(height: 3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                  const Text("Don't Have an account?"),
                  TextButton(
                    child: const Text(
                      "Sign Up",
                      style: TextStyle( fontSize: 20,

                          fontFamily: 'Urbanist'),
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
                    },
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}
