import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state/helpers/api_helper.dart';
import 'package:flutter_state/models/user_list_detail.dart';
import 'package:flutter_state/providers/user_list_provider.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> {
  int start = 0;
  bool control = true;
  ScrollController scrollController = ScrollController();
  double itemHeight;
  double itemWidth;
  double fontsizeTitle;
  double fontsizeBody;
  double fontsizeIcon;

  Future<void> _getUsers() async {
    var provider = Provider.of<UserListProvider>(context, listen: false);
    var userResponse = await APIHelper.getAllUser(start);
    var albumResponse = await APIHelper.getAllAlbums();
    var postResponse = await APIHelper.getAllPost();
    provider.setUserListCount(userResponse, albumResponse, postResponse);
    provider.setIsProcessing(false);
  }

  Future<void> _refreshPost() async {
    start = 0;
    control = true;
    var provider = Provider.of<UserListProvider>(context, listen: false);
    provider.setIsProcessing(true);
    provider.setCleanUserList();
    var userResponse = await APIHelper.getAllUser(start);
    var albumResponse = await APIHelper.getAllAlbums();
    var postResponse = await APIHelper.getAllPost();
    provider.setUserListCount(userResponse, albumResponse, postResponse);
    provider.setIsProcessing(false);
  }

  @override
  void initState() {
    super.initState();

    _getUsers();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          control) {
        start = start + 5;
        _getUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    itemHeight = MediaQuery.of(context).size.height / 4;
    itemWidth = MediaQuery.of(context).size.width;

    if (itemWidth < 600) {
      fontsizeTitle = 22.0;
      fontsizeBody = 18.0;
      fontsizeIcon = 16.0;
    } else {
      fontsizeTitle = 36.0;
      fontsizeBody = 32.0;
      fontsizeIcon = 28.0;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "USERS",
            style: TextStyle(fontSize: fontsizeBody),
          ),
        ),
        body: Consumer<UserListProvider>(
          builder:
              (BuildContext context, UserListProvider userList, Widget child) {
            return userList.isProcessing
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    child: _buildUserList(userList), onRefresh: _refreshPost);
          },
        ));
  }

  Widget _buildUserList(UserListProvider userList) {
    return ListView.builder(
      controller: scrollController,
      itemCount: userList.userListCount.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == userList.userListCount.length) {
          if (start + 1 > userList.userListCount.length) {
            control = false;
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "No More User",
                  style: TextStyle(fontSize: fontsizeBody),
                ),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        } else {
          return _buildPostListItem(userList.userListCount[index]);
        }
      },
    );
  }

  Widget _buildPostListItem(UserListCount user) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: itemWidth / 15, vertical: itemHeight / 20),
      child: Card(
        child: ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.user.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontsizeTitle),
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
            subtitle: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(itemHeight / 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Username: " + user.user.username,
                          style: TextStyle(
                              fontSize: fontsizeBody, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(itemHeight / 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Email: " + user.user.email,
                          style: TextStyle(
                              fontSize: fontsizeBody, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(itemHeight / 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Album Count: " + user.albumCount.toString(),
                          style: TextStyle(
                              fontSize: fontsizeBody, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(itemHeight / 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Post Count: " + user.postCount.toString(),
                          style: TextStyle(
                              fontSize: fontsizeBody, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
