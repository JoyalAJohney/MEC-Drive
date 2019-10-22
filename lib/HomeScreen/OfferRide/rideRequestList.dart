import 'package:flutter/material.dart';
import 'acceptCard.dart';

class RideRequestList extends StatefulWidget {
  @override
  _RideRequestListState createState() => _RideRequestListState();
}

class _RideRequestListState extends State<RideRequestList> {

  bool accept = true;

  // Cards showing user requests
  Widget _requestCards(BuildContext context, int index) {
    return Card(
      elevation: 2,
      child: GestureDetector(
        onTap: (){
          showModalBottomSheet(
            context: context,
            builder: (context) => AcceptCard()
          );
        },
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/elon.jpg"),
            ),
            title: Text("Destination"),
            subtitle: Text("Time: 5PM"),
            trailing: accept == true ? 
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ) : 
              null,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) =>
                  _requestCards(context, index),
            ),
          )
        ],
      ),
    );
  }
}
