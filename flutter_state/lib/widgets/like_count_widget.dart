import 'package:flutter/material.dart';
import 'package:flutter_state/models/post_list_detail.dart';
import 'package:flutter_state/providers/post_list_provider.dart';
import 'package:provider/provider.dart';

class LikeCountWidget extends StatefulWidget {
  final PostListDetail post;
  final double fontsizeIcon;

  LikeCountWidget(this.post, this.fontsizeIcon);

  @override
  State<StatefulWidget> createState() {
    return LikeCountWidgetState(post, fontsizeIcon);
  }
}

class LikeCountWidgetState extends State<LikeCountWidget> {
  PostListDetail post;
  double fontsizeIcon;
  Color color;

  LikeCountWidgetState(this.post, this.fontsizeIcon);

  @override
  Widget build(BuildContext context) {
    if (post.likeControl == true) {
      color = Colors.red;
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
                  Icons.favorite,
                  size: fontsizeIcon,
                ),
                onPressed: () {
                  postProvider.setLikeCount(post);
                },
                color: color),
            Text(
              post.like.toString(),
              style: TextStyle(fontSize: fontsizeIcon),
            )
          ],
        );
      },
    ));
  }
}
