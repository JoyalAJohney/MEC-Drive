import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post.dart';

class Http extends StatefulWidget {
  @override
  _HttpState createState() => _HttpState();
}

class _HttpState extends State<Http> {

  List<Post> _posts = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<dynamic> fetchPosts() {
    _isLoading = false;
    
    return  http.get('https://jsonplaceholder.typicode.com/posts').
            then((response){
              final List<Post> fetchedPosts = [];

              final List<dynamic> postsData = json.decode(response.body);
              if(postsData == null) {
                setState(() {
                 _isLoading = false; 
                });
              }

              for(var i=0;i<postsData.length;i++) {
                final Post post = Post(
                  userId: postsData[i]['userId'],
                  id: postsData[i]['id'],
                  title: postsData[i]['title'],
                  body: postsData[i]['body'],
                );
                fetchedPosts.add(post);
              }

              setState(() {
                _posts.clear();
               _posts.addAll(fetchedPosts);
               _isLoading = false; 
              });
            }).catchError((e){
              setState(() {
               _isLoading = false;
               print(e); 
              });
            });
  }

  Future<dynamic> _onRefresh() {
    return fetchPosts();
  }

  Widget _buildPostList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      key: _refreshIndicatorKey,
      child: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (BuildContext context,int index) {
          return Column(
            children: <Widget>[
              Padding(
                child: ListTile(
                  title: Text(_posts[index].title),
                  subtitle: Text(_posts[index].body),
                ),
                padding: EdgeInsets.all(10),
              ),
              Divider(
                height: 5,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: _isLoading?
            Center(child: CircularProgressIndicator()):
            _buildPostList(),
    );
  }
}