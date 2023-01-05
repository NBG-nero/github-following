import 'dart:convert';

import 'package:dev/Models/User.dart';
import 'package:dev/Provider/UserProvider.dart';
import 'package:dev/Requests/GithubRequest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key key}) : super(key: key);

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  User user;
  List<User> users;

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<UserProvider>(context).getUser();

      Github(user.login).fetchFollowing().then((following) {
      dynamic list = json.decode(following.body);
        setState(() {
          users = list.map((e) => User.fromJson(e)).toList();
        });
      });
    });

    return Scaffold(
        body: Container(
      color: Colors.black,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.dark,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.black,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(user.avatar_url),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      user.login,
                      style: TextStyle(fontSize: 25,color:Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              height: 600,
              child: users != null
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                            users[index].avatar_url),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      users[index].login,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[700]),
                                    )
                                  ],
                                ),
                                Text('Following',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ))
                              ],
                            ));
                      },
                    )
                  : Container(
                      child: Align(
                        child: Text(
                          'Data is loading ...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
            )
          ]))
        ],
      ),
    ));
  }
}
