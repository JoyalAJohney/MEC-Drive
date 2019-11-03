import 'package:flutter/material.dart';

class Credits extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Credits> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Credits',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            Center(
              child: Column(
                children: <Widget>[
                  profile('John Doe', 'assets/profilepic.jpeg', 'Computer Science'),
                  profile('Bftfsdf', 'assets/profilepic.jpeg', 'CSasdasd'),
                  profile('Cadasd', 'assets/profilepic.jpeg', 'CSasdasd'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget profile(name, image, dept) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(75.0)),
            boxShadow: [BoxShadow(blurRadius: 9.0, color: Colors.black)]),
      ),
      Container(
        child: ListTile(
          title: Center(child: Text(name)),
          subtitle: Center(child: Text(dept)),
        ),
      )
    ],
  );
}