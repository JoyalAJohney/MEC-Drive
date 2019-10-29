import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'RideRequestScreen/rideRequestList.dart';

class OfferRide extends StatefulWidget {
  @override
  _OfferRideState createState() => _OfferRideState();
}

class _OfferRideState extends State<OfferRide> {
  bool carRegistered = true;

  @override
  void initState() {
    super.initState();
    //checks for what screen to be displayed
    // screenCheck();
  }

  screenCheck() {
    SharedPreferences.getInstance().then((pref) {
      setState(() {
        carRegistered = pref.getBool('carpool');        
      });
    }).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return carRegistered ? 
    RideRequestList() 
    : 
    NotRegistered();
  }
}


// Widget displayed when no Car is registered
class NotRegistered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Image(
              width: MediaQuery.of(context).size.width * 0.6,
              image: AssetImage("assets/carpool.jpg"),
              // fit: BoxFit.contain,
            ),
            Text(
              "Oops! You have no Car/Bike registred",
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: RaisedButton(
                onPressed: () {},
                splashColor: Colors.grey,
                padding: EdgeInsets.all(5.0),
                color: Colors.black,
                elevation: 4.0,
                textColor: Colors.white,
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
