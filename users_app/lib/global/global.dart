import 'package:firebase_auth/firebase_auth.dart';
import 'package:users_app/models/direction_details_info.dart';
import 'package:users_app/models/user_model.dart';



final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId="";
String cloudMessagingServerToken = "key=AAAAtRV8FCE:APA91bGIkGACbTySbpXUzqqM4xbtfcQXW71qOJcuTbmkhSjgCfvaPCcRflLkz_ifoUKWtq39PZL17yemARJZM7T7p0ac524KR5UIl7R8cjr50XagiByeWOGt5Tp-BR4xlQsUUe9xV__H";
String userDropOffAddress = "";
String driverCarDetails="";
String driverName="";
String driverPhone="";
double countRatingStars=0.0;
String titleStarsRating="";