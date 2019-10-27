import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ConfirmCard extends StatefulWidget {
  final String location;
  final TimeOfDay time;

  ConfirmCard(this.location, this.time);

  @override
  _ConfirmCardState createState() => _ConfirmCardState();
}

class _ConfirmCardState extends State<ConfirmCard> {

  //send ride request to server
  void postData() async {

    HttpClient client = HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String url = 'https://192.168.0.103:8000/api/request';
    Map<String,String> rideRequest = {
      'userId'  : '101',
      'location': widget.location,
      'time'    : widget.time.toString(),
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(rideRequest)));

    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);

  }


  void _confirmRide(BuildContext context) async {
    // alertbox
    final alertDialog = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          SizedBox(
            width: 40.0,
          ),
          Text(
            "Sending Request",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);

    // Snackbar
    final snack = SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Request has been successfully sent!",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      duration: Duration(seconds: 4),
    );


    //send request to server
    postData();
    // final response = await http.post(
    //   'https://192.168.0.103:8000/api/request/',
    //   body: jsonEncode({
    //     'userId'  : '101',
    //     'location': widget.location,
    //     'time'    : widget.time.toString(),
    //   }),
    //   headers: {'Content-Type':"application/json"},
    // );


    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pop(context,snack);
    });
  }


  //handle bad request
  void handleBadRequest() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Oops! Please try again"),
          content: Text("Please select a destination before confirming ride."),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2,
      padding: EdgeInsets.all(10.0),
      color: Colors.black,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50.0),
          // From
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            title: Text("Model Engineering College",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text("Thrikkakara",
            style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                color: Color(0xFF808080),
                height: 2.0,
              ),
            ],
          ),
          // Destination
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            title: widget.location == ""
                ? Text("Destination not selected",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                : Text(widget.location,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
            subtitle: Text(widget.time.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          // Confirm Ride button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: RaisedButton(
                  onPressed: widget.location == ""?
                  () => handleBadRequest():
                  () => _confirmRide(context),
                  child: Center(
                    child: Text(
                      "Confirm Ride",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  textColor: Colors.white,
                  color: Colors.green,
                  padding: EdgeInsets.all(12.0),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
