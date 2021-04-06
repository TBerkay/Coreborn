import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_state/helpers/api_helper.dart';
import 'package:flutter_state/models/comment.dart';
import 'package:flutter_state/models/post_list_detail.dart';
import 'package:flutter_state/providers/post_list_provider.dart';
import 'package:flutter_state/widgets/comment_count_widget.dart';
import 'package:flutter_state/widgets/like_count_widget.dart';
import 'package:flutter_state/widgets/repost_count_widget.dart';
import 'package:flutter_state/widgets/share_count_widget.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatefulWidget {
  final PostListDetail postContent;
  PostDetail(this.postContent);

  @override
  State<StatefulWidget> createState() {
    return PostDetailState();
  }
}

class PostDetailState extends State<PostDetail> {
  int start = 0;
  bool control = true;
  ScrollController scrollController = ScrollController();
  double itemHeight;
  double itemWidth;
  double fontsizeTitle;
  double fontsizeBody;
  double fontsizeIcon;

  _getPost(int id) async {
    var provider = Provider.of<PostListProvider>(context, listen: false);
    var postResponse = await APIHelper.getPostById(id);
    var commentsResponse = await APIHelper.getCommentById(id, start);
    provider.setPost(postResponse);
    provider.setComments(commentsResponse);
  }

  @override
  void initState() {
    super.initState();
    _getPost(widget.postContent.post.id);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          control) {
        start = start + 3;
        _getPost(widget.postContent.post.id);
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
            "POST",
            style: TextStyle(fontSize: fontsizeBody),
          ),
        ),
        body: Consumer<PostListProvider>(
          builder: (BuildContext context, PostListProvider post, Widget child) {
            return post.isDetailProcessing
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildPostDetail(post);
          },
        ));
  }

  Widget _buildPostDetail(PostListProvider post) {
    return ListView.builder(
        controller: scrollController,
        itemCount: 2,
        itemBuilder: (context, index) {
          if (index == 1) {
            if (start + 1 > post.comments.length) {
              control = false;
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "No More Comment",
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
            return _buildCommentList(post);
          }
        });
  }

  Widget _buildCommentList(PostListProvider post) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        post.post.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontsizeTitle),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        post.post.body,
                        style: TextStyle(fontSize: fontsizeBody),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: 5.0,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CommentCountWidget(widget.postContent, fontsizeIcon),
                RepostCountWidget(widget.postContent, fontsizeIcon),
                LikeCountWidget(widget.postContent, fontsizeIcon),
                ShareCountWidget(widget.postContent, fontsizeIcon),
              ]),
          SizedBox(
            height: 5.0,
          ),
          Divider(),
          SizedBox(
            height: 10.0,
          ),
          ListView.builder(
            itemCount: post.comments.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildCommentListItem(post.comments[index]);
            },
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
          )
        ],
      ),
    );
  }

  Widget _buildCommentListItem(Comment comment) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              comment.name,
              style: TextStyle(
                  fontSize: fontsizeTitle, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              comment.body,
              style: TextStyle(fontSize: fontsizeBody),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
