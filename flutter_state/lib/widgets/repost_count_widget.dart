import 'package:flutter/material.dart';
import 'package:flutter_state/models/post_list_detail.dart';
import 'package:flutter_state/providers/post_list_provider.dart';
import 'package:provider/provider.dart';

class RepostCountWidget extends StatefulWidget {
  final PostListDetail post;
  final double fontsizeIcon;

  RepostCountWidget(this.post, this.fontsizeIcon);

  @override
  State<StatefulWidget> createState() {
    return RepostCountWidgetState(post, fontsizeIcon);
  }
}

class RepostCountWidgetState extends State<RepostCountWidget> {
  PostListDetail post;
  double fontsizeIcon;
  Color color;

  RepostCountWidgetState(this.post, this.fontsizeIcon);

  @override
  Widget build(BuildContext context) {
    if (post.repostControl == true) {
      color = Colors.green;
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
                  Icons.repeat,
                  size: fontsizeIcon,
                ),
                onPressed: () {
                  postProvider.setRepostCount(post);
                },
                color: color),
            Text(
              post.repost.toString(),
              style: TextStyle(fontSize: fontsizeIcon),
            )
          ],
        );
      },
    ));
  }
}
