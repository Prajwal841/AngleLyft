import 'package:drivers_app/authentication/login_screen.dart';
import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget
{

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}



class _CarInfoScreenState extends State<CarInfoScreen>
{
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> carTypesList = ["car", "bike", "Rikshaw"];
  String? selectedCarType;


  saveCarInfo()
  {
    Map driverCarInfoMap =
    {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);

    Fluttertoast.showToast(msg: "Car Details has been saved, Congratulations.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [

              const SizedBox(height: 24,),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/cardetails.jpg"),
              ),

              const SizedBox(height: 10,),

              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10,0,10,5),
                  child: const Text(
                    'Enter Vehicle Details',
                    style: TextStyle(fontSize: 30,fontWeight:FontWeight.w500,fontFamily: 'Urbanist',color: Colors.blueGrey),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(10,10,10,5),
                child: TextField(

                  controller: carModelTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none
                    ),
                    fillColor: Colors.yellow.withOpacity(0.1),
                    filled: true,
                    prefixIcon: Icon(Icons.car_repair,color: Colors.yellow,),
                    labelText: 'Car Model',
                    labelStyle: const TextStyle(
                      fontFamily: "Urbanist",
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10,10,10,5),
                child: TextField(

                  controller: carNumberTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none
                    ),
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    filled: true,
                    prefixIcon: Icon(Icons.numbers,color: Colors.blue,),
                    labelText: 'Car Number',
                    labelStyle: const TextStyle(
                      fontFamily: "Urbanist",
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10,10,10,5),
                child: TextField(

                  controller: carColorTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none
                    ),
                    fillColor: Colors.amberAccent.withOpacity(0.1),
                    filled: true,
                    prefixIcon: Icon(Icons.photo,color: Colors.amberAccent,),
                    labelText: 'Car Color',
                    labelStyle: const TextStyle(
                      fontFamily: "Urbanist",
                    ),
                  ),
                ),
              ),



              const SizedBox(height: 10,),


              Container(
                padding: const EdgeInsets.fromLTRB(10,10,10,0),

                child:DropdownButtonFormField(
                  hint: const Text(
                    "Please choose Vehicle Type",
                    style: TextStyle(
                      fontSize: 16.0,
                      // color: Colors.grey,
                    ),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none
                    ),
                    fillColor: Colors.yellow.withOpacity(0.2),
                    filled: true,
                  ),
                  dropdownColor: Colors.white,
                  value: selectedCarType,
                  onChanged: (newValue)
                  {
                    setState(() {
                      selectedCarType = newValue.toString();
                    });
                  },
                  items: carTypesList.map((car){
                    return DropdownMenuItem(
                      value: car,
                      child: Text(
                        car,
                        style: const TextStyle(fontSize: 20,fontWeight:FontWeight.w400,fontFamily: 'Urbanist'),
                      ),
                    );
                  }).toList(),
                ),
              ),
/*
* */
              const SizedBox(height: 20,),
              ElevatedButton(

                onPressed: ()
                {
                  if(carColorTextEditingController.text.isNotEmpty
                      && carNumberTextEditingController.text.isNotEmpty
                      && carModelTextEditingController.text.isNotEmpty && selectedCarType != null)
                  {
                    saveCarInfo();
                  }

                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(50,10,50,10),
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  shadowColor: Colors.grey,
                  elevation:5,
                ),
                child: const Text(
                  " Save Details ",
                  style: TextStyle(

                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Urbanist'
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );

  }
}
