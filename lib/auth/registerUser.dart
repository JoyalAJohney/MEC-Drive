import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Form field variables
  String name = "";
  String phone = "";
  String branch = "CSA";
  String year = '1';
  int carpool;


  // Save user information in shared preferences
  void saveUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', name);
    prefs.setString('userPhone', phone);
    prefs.setString('userBranch', branch);
    prefs.setString('userYear', year);
    prefs.setBool('isLoggedIn', false);
    if (carpool == 1)
      prefs.setBool('carpool', true);
    else
      prefs.setBool('carpool', false);

    print("stored user details in local storage");
  }


  //save user id from response in local storage
  void userRegistered(Map<String,dynamic> responseData) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', responseData['_id'].toString());
    pref.setBool('isLoggedIn', true);

    print("stored user id in local storage");
  }

  // Submit the user details to database
  void _submitForm(BuildContext context) async {

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
      context: context, builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );

    //save user information in shared preferences
    saveUserInfo();

    String url = "http://192.168.43.112:8000/api/user/";
    //single quotes are important
    Map<String,dynamic> userDetails = {
      'name'  : name,
      'branch': branch,
      'year'  : year,
      'phone' : phone,
      'acceptedRides': []
    };

    //send user sign up details to backend
    http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(userDetails)
    ).then((response) {
      final Map<String,dynamic> responseData = json.decode(response.body);
      print(responseData);


      //set the unique id from response in sharedpreferences
      //set ifRegistered(bool)
      userRegistered(responseData);


      // go to home screen
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/homescreen');
      });
    }).catchError((e){
      print(e);
    });
   
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Image(
                width: 320.0,
                image: AssetImage("assets/signUp.jpg"),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              // Sign Up container
              Container(
                padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                width: 300.0,
                height: 420.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: Form(
                  key: formKey,
                  autovalidate: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // UserName
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Name",
                            icon: Icon(Icons.account_circle)),
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontFamily: "Poppins"),
                        validator: (value) {
                          if (value.isEmpty) return "Name field is required";
                        },
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                      // Phone
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Phone", icon: Icon(Icons.phone)),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty) return "Phone no is required";
                        },
                        onChanged: (val) {
                          setState(() {
                            phone = val;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      // Branch
                      Row(
                        children: <Widget>[
                          Text("Branch: ", style: TextStyle(fontSize: 17.0)),
                          Padding(padding: EdgeInsets.all(5.0)),
                          DropdownButton<String>(
                            value: branch,
                            items: <String>[
                              'CSA',
                              'CSB',
                              'ECA',
                              'ECB',
                              'EEE',
                              'EB'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String value) {
                              setState(() {
                                branch = value;
                              });
                            },
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          // Year
                          Text("Year: ", style: TextStyle(fontSize: 17.0)),
                          Padding(padding: EdgeInsets.all(5.0)),
                          DropdownButton<String>(
                            value: year,
                            items: <String>['1', '2', '3', '4']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String value) {
                              setState(() {
                                year = value;
                              });
                            },
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      // Carpool
                      Row(
                        children: <Widget>[
                          Text(
                            "Do you have a vehicle to pool?",
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(2.0)),
                      // RadioButton
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Yes:", style: TextStyle(fontSize: 17.0)),
                          Radio(
                            activeColor: Colors.green,
                            value: 1,
                            groupValue: carpool,
                            onChanged: (int val) {
                              setState(() {
                                carpool = val;
                              });
                            },
                          ),
                          Text("No:", style: TextStyle(fontSize: 17.0)),
                          Radio(
                            activeColor: Colors.green,
                            value: 0,
                            groupValue: carpool,
                            onChanged: (int val) {
                              setState(() {
                                carpool = val;
                              });
                            },
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      // Submit Button
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: RaisedButton(
                                  color: Colors.green,
                                  child: Text("Register"),
                                  textColor: Colors.white,
                                  onPressed: () => _submitForm(context),
                                ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}