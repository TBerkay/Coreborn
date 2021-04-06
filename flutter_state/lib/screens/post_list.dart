import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_state/helpers/api_helper.dart';
import 'package:flutter_state/models/post_list_detail.dart';
import 'package:flutter_state/providers/post_list_provider.dart';
import 'package:flutter_state/providers/user_list_provider.dart';
import 'package:flutter_state/screens/post_detail.dart';
import 'package:flutter_state/screens/user_list.dart';
import 'package:flutter_state/widgets/comment_count_widget.dart';
import 'package:flutter_state/widgets/like_count_widget.dart';
import 'package:flutter_state/widgets/repost_count_widget.dart';
import 'package:flutter_state/widgets/share_count_widget.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PostListState();
  }
}

class PostListState extends State<PostList> {
  int start = 0;
  bool control = true;
  ScrollController scrollController = ScrollController();
  double itemHeight;
  double itemWidth;
  double fontsizeTitle;
  double fontsizeBody;
  double fontsizeIcon;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> _getPosts() async {
    var provider = Provider.of<PostListProvider>(context, listen: false);
    var response = await APIHelper.getPosts(start);
    provider.setPostList(response);
    provider.setIsProcessing(false);
  }

  Future<void> _refreshPost() async {
    start = 0;
    control = true;
    var provider = Provider.of<PostListProvider>(context, listen: false);
    provider.setIsProcessing(true);
    provider.setCleanPostList();
    var response = await APIHelper.getPosts(start);
    provider.setPostList(response);
    provider.setIsProcessing(false);
  }

  @override
  void initState() {
    super.initState();
    _getPosts();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          control) {
        start = start + 5;
        _getPosts();
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
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: fontsizeBody,
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Text(
            "POST APP",
            style: TextStyle(fontSize: fontsizeBody),
          ),
        ),
        drawer: _buildDrawer(),
        body: Consumer<PostListProvider>(
          builder:
              (BuildContext context, PostListProvider postList, Widget child) {
            return postList.isProcessing
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    child: _buildPostList(postList), onRefresh: _refreshPost);
          },
        ));
  }

  Widget _buildPostList(PostListProvider postList) {
    return ListView.builder(
      controller: scrollController,
      itemCount: postList.postsList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == postList.postsList.length) {
          if (start + 1 > postList.postsList.length) {
            control = false;
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "No More Post",
                  style: TextStyle(fontSize: fontsizeBody),
                ),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        } else {
          return _buildPostListItem(postList.postsList[index]);
        }
      },
    );
  }

  Widget _buildPostListItem(PostListDetail post) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: itemWidth / 15, vertical: itemHeight / 20),
      child: Card(
        child: ListTile(
          title: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          post.post.title,
                          style: TextStyle(
                              fontSize: fontsizeTitle,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
              Divider(),
            ],
          ),
          subtitle: Column(
            children: [
              SizedBox(height: 10.0),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        post.post.body,
                        style: TextStyle(
                            fontSize: fontsizeBody, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Divider(),
              Container(
                child: Row(
                  children: <Widget>[
                    CommentCountWidget(post, fontsizeIcon),
                    RepostCountWidget(post, fontsizeIcon),
                    LikeCountWidget(post, fontsizeIcon),
                    ShareCountWidget(post, fontsizeIcon),
                  ],
                ),
              )
            ],
          ),
          onTap: () async {
            var result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => PostDetail(post)));

            if (result == null) {
              var provider =
                  Provider.of<PostListProvider>(context, listen: false);
              provider.setisDetailProcessing(true);
              provider.setCleanCommentList();
            }
          },
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'POST APP',
                  style:
                      TextStyle(color: Colors.white, fontSize: fontsizeTitle),
                ),
              ],
            ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          ListTile(
            title: Text(
              'Users',
              style: TextStyle(fontSize: fontsizeBody),
            ),
            trailing: Icon(
              Icons.arrow_right,
              size: fontsizeIcon,
            ),
            onTap: () async {
              Navigator.pop(context);
              var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => UserList()));

              if (result == null) {
                var provider =
                    Provider.of<UserListProvider>(context, listen: false);
                provider.setIsProcessing(true);
                provider.setCleanUserList();
              }
            },
          ),
        ],
      ),
    );
  }
}
