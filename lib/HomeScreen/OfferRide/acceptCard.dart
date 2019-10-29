import 'package:flutter/material.dart';
import 'package:mecdrive_app/HomeScreen/OfferRide/setPrice.dart';

class AcceptCard extends StatefulWidget {
  @override
  _AcceptCardState createState() => _AcceptCardState();
}

class _AcceptCardState extends State<AcceptCard> {

  String price = "0.0";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height/2,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          // User details
          Container(
            // color: Colors.blueAccent,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/accountAvatar.jpg"),
              ),
              title: Text("Name of User",style: TextStyle(
                color: Colors.white
              ),),
              subtitle: Row(
                children: <Widget>[
                  Text("Branch: CSA",style: TextStyle(
                    color: Colors.white,
                  ),),
                  SizedBox(width: 5),
                  Text("Year: 3",style: TextStyle(
                    color: Colors.white,
                  ),),
                ],
              ),
            ),
          ),
          // Ride Details -- Destination and Time
          Container(
            // color: Colors.cyan,
            child: ListTile(
              leading: Icon(Icons.location_on,color: Colors.white,),
              title: Text("Destination",style: TextStyle(
                color: Colors.white,
              ),),
              subtitle: Text("Time : 5AM",style: TextStyle(
                color: Colors.white,
              ),),
            ),
          ),
          //Set Price
          Container(
            // color: Colors.greenAccent,
            child: ListTile(
              leading: Icon(Icons.monetization_on,color: Colors.white,),
              title: Text(
                price.toString() + " Rs",
                style: TextStyle(color: Colors.white),
              ),
              trailing: FlatButton(
                color: Colors.black,
                textColor: Colors.green,
                child: Text("Set Price"),
                onPressed: (){
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => SetPrice()
                  ).then((newPrice) {
                    print(newPrice);
                    setState(() {
                     price = newPrice; 
                    });
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: MediaQuery.of(context).size.width/1.5,
            child: RaisedButton(
              padding: EdgeInsets.all(10),
              elevation: 3,
              color: Colors.green,
              textColor: Colors.white,
              child: Text("Offer Ride",style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
              ),),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
