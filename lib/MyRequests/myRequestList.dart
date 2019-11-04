import 'package:flutter/material.dart';
import 'package:mecdrive_app/MyRequests/myRequestClass.dart';
import 'package:mecdrive_app/misc/convertTime.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyRequestList extends StatefulWidget {
  @override
  _MyRequestListState createState() => _MyRequestListState();
}

class _MyRequestListState extends State<MyRequestList> {
  bool accept = true;

  // List that contains requests from users
  List<MyRequest> _requests = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  Future<dynamic> fetchRequests() async {
    _isLoading = false;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('token');

    return http
        .get("http://192.168.43.112:8000/api/request/myrequest/" + userId)
        .then((response) {
      final List<MyRequest> fetchedRequests = [];
      final List<dynamic> responseData = json.decode(response.body);
      if (responseData == null) {
        setState(() {
          _isLoading = false;
        });
      }

      var length = responseData.length;
      for (var i = 0; i < length; i++) {
        final MyRequest request = MyRequest(
          requestId: responseData[i]['_id'].toString(),
          destination: responseData[i]['location'],
          time: responseData[i]['time'],
        );
        fetchedRequests.add(request);
      }

      setState(() {
        _requests.clear();
        _requests.addAll(fetchedRequests);
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
        print(e);
      });
    });
  }

  Future<dynamic> _onRefresh() {
    return fetchRequests();
  }

  Widget _buildRequestList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      key: _refreshIndicatorKey,
      child: ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (BuildContext context, int index) {
          return _requestCards(context, index);
        },
      ),
    );
  }

  // Cards showing user requests
  Widget _requestCards(BuildContext context, int index) {
    return Card(
      elevation: 2,
      child: GestureDetector(
        // onTap: () {
        //   showModalBottomSheet(
        //       context: context,
        //       builder: (context) => AcceptCard(
        //           _requests[index].destination,
        //           _requests[index].time,
        //           _requests[index].requestedUserId)).then((check) {
        //     if (check == "success") {
        //       //Show Snackbar
        //       final snack = SnackBar(
        //         backgroundColor: Colors.green,
        //         content: Text(
        //           "Notified User!",
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //         duration: Duration(seconds: 4),
        //       );
        //       Scaffold.of(context).showSnackBar(snack);

        //     }
        //   }).catchError((e) {
        //     print(e);
        //   });
        // },
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/accountAvatar.jpg"),
              radius: 25,
            ),
            title: Text(_requests[index].destination),
            subtitle:
                Text("Time: " + convertTimeTo12Hour(_requests[index].time)),
            trailing: accept == true
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.info,
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Requests"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                child: Center(
                  child: Text("Swipe to delete",style: TextStyle(
                    color: Colors.grey,
                  ),),
                ),
              ),
            ),
            Expanded(
              child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _buildRequestList(),
            ),
          ],
        )
      );
  }
}
