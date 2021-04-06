import 'package:flutter/material.dart';
import 'package:flutter_state/models/post_list_detail.dart';
import 'package:flutter_state/providers/post_list_provider.dart';
import 'package:provider/provider.dart';

class CommentCountWidget extends StatefulWidget {
  final PostListDetail post;
  final double fontsizeIcon;

  CommentCountWidget(this.post, this.fontsizeIcon);

  @override
  State<StatefulWidget> createState() {
    return CommentCountWidgetState(post, fontsizeIcon);
  }
}

class CommentCountWidgetState extends State<CommentCountWidget> {
  PostListDetail post;
  double fontsizeIcon;
  Color color;

  CommentCountWidgetState(this.post, this.fontsizeIcon);

  @override
  Widget build(BuildContext context) {
    if (post.commentControl == true) {
      color = Colors.blue;
    } else {
      color = Colors.black;
    }

    return Expanded(child: Consumer<PostListProvider>(
      builder:
          (BuildContext context, PostListProvider postProvider, Widget child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(
                  Icons.mode_comment,
                  size: fontsizeIcon,
                ),
                onPressed: () {
                  postProvider.setCommentCount(post);
                },
                color: color),
            Text(
              post.comment.toString(),
              style: TextStyle(fontSize: fontsizeIcon),
            )
          ],
        );
      },
    ));
  }
}
