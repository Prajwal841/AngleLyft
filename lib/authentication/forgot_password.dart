import 'package:flutter/material.dart';
import 'package:drivers_app/global/global.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController=TextEditingController();


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
    child: Image.asset("images/forgotpassword.jpg"),
    ),

    const SizedBox(height: 10,),

    const Text(
    "Forgot Password?",
    style: TextStyle(
    fontSize: 26,
    color:  Colors.blueGrey,
    fontWeight: FontWeight.w500,
    ),
    ),
    const SizedBox(height: 20,),

    TextField(
    controller: emailController,
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
            ElevatedButton(
              onPressed: ()
              {
                fAuth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Reset Password Link Has Been Sent SuccessFull, Please Check Email");

                }).onError((error, stackTrace){
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Failed to Reset Password! Try Again Later");
                });
              },
              style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(70,15,70,15),
              backgroundColor: Colors.amber.shade400,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              ),
              shadowColor: Colors.grey,
              elevation:5,
              ),
              child: const Text(
              "Send Link",
              style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              fontFamily: 'Urbanist'
    ),
    ),
            ),


          ],
        ),
      ),
    ));
  }
}
