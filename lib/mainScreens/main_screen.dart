import 'package:drivers_app/tabPages/earning_tab.dart';
import 'package:drivers_app/tabPages/home_tab.dart';
import 'package:drivers_app/tabPages/profile_tab.dart';
import 'package:drivers_app/tabPages/ratings_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget
{
  @override
  _MainScreenState createState() => _MainScreenState();
}




class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin
{
  static const List<Widget> _widgetOptions = <Widget>[
    HomeTabPage(),
    EarningsTabPage(),
    RatingsTabPage(),
    ProfileTabPage(),
  ];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   tabController=TabController(length: 4, vsync: this);
  // }

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
        child: _widgetOptions.elementAt(currentIndex),
    ),
    bottomNavigationBar: Container(
    color: Colors.white,
    child: Padding(
    padding:const EdgeInsets.symmetric(
    horizontal: 15.0,
    vertical:20.0,
    ),
    child : GNav(

    backgroundColor: Colors.white,
    color: Colors.amber.shade400,


      //activeColor: Colors.orange,
    //tabBackgroundColor: Colors.grey.shade100,
    gap:8,
    selectedIndex: currentIndex,
    onTabChange: (int index){
    setState(() {
    currentIndex = index;
    // tabController!.index = selectedIndex;
    });
    },
    padding: EdgeInsets.all(15),
    tabs:[
    GButton(icon: Icons.home,text:'Home',textColor:Colors.blue ,iconColor: Colors.blue,iconActiveColor: Colors.blue,backgroundColor: Colors.lightBlue.withOpacity(0.1),),
    GButton(icon: Icons.credit_card,text:'Earnings',textColor:Colors.pink ,iconColor: Colors.pink,iconActiveColor: Colors.pink,backgroundColor:Colors.pink.withOpacity(0.1),),
    GButton(icon: Icons.star,text:'Ratings',textColor:Colors.amberAccent,iconColor: Colors.amberAccent,iconActiveColor:Colors.amberAccent,backgroundColor: Colors.orange.withOpacity(0.1),),
    GButton(icon: Icons.person,text:'Account',textColor:Colors.purple,iconColor: Colors.purple,iconActiveColor:Colors.purple,backgroundColor: Colors.purple.withOpacity(0.1),),
    ],

    ),
    ),
    ));

  }
}
