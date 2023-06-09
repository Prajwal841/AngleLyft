import 'package:drivers_app/authentication/login_screen.dart';
import 'package:drivers_app/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/info_design_ui.dart';


class ProfileTabPage extends StatefulWidget
{
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //name
            Text(
              onlineDriverData.name!.toUpperCase(),
              style: const TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),


            Text(
              titleStarsRating + " Driver",
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.black54,
                height: 2,
                thickness: 2,
              ),
            ),

            const SizedBox(height: 38.0,),

            //phone
            InfoDesignUIWidget(
              textInfo: onlineDriverData.phone!,
              iconData: Icons.phone_iphone,
            ),

            //email
            InfoDesignUIWidget(
              textInfo: onlineDriverData.email!,
              iconData: Icons.email,
            ),

            InfoDesignUIWidget(
              textInfo: onlineDriverData.car_color! + " " + onlineDriverData.car_model! + " " +  onlineDriverData.car_number!,
              iconData: Icons.car_repair,
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              style:ElevatedButton.styleFrom(

                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                shadowColor: Colors.black,
                elevation:8,
              ),
              onPressed: ()
              {
                fAuth.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
              },

              child: const Text(
                "Logout",
                style: TextStyle(fontSize: 15,fontFamily: 'Urbanist'),
              ),
            )

          ],
        ),
      ),
    );
  }
  // Future<void>showUserNameDialogAlert(BuildContext context){
  //   return showDialog(context: context,
  //       builder: (context){
  //     return AlertDialog();
  //
  //       }
  //   );

  }

