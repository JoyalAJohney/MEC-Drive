import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AcceptCard extends StatefulWidget {
  @override
  _AcceptCardState createState() => _AcceptCardState();
}

class _AcceptCardState extends State<AcceptCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.redAccent,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          // User details
          Container(
            // color: Colors.blueAccent,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/elon.jpg"),
              ),
              title: Text("Name of User"),
              subtitle: Row(
                children: <Widget>[
                  Text("Branch: CSA"),
                  SizedBox(width: 5),
                  Text("Year: 3"),
                ],
              ),
            ),
          ),
          // Ride Details -- Destination and Time
          Container(
            // color: Colors.cyan,
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Destination"),
              subtitle: Text("Time : 5AM"),
            ),
          ),
          //Set Price
          Container(
            // color: Colors.greenAccent,
            child: ListTile(
              // leading: Icon(Icons.monetization_on,color: Colors.green,),
              title: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Set Price"),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              elevation: 3,
              splashColor: Colors.greenAccent,
              color: Colors.green,
              textColor: Colors.white,
              child: Text("Accept Ride",style: TextStyle(
                fontSize: 17
              ),),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
