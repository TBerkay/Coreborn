import 'package:flutter/material.dart';
import 'package:flutter_state/models/post_list_detail.dart';
import 'package:flutter_state/providers/post_list_provider.dart';
import 'package:provider/provider.dart';

class ShareCountWidget extends StatefulWidget {
  final PostListDetail post;
  final double fontsizeIcon;

  ShareCountWidget(this.post, this.fontsizeIcon);

  @override
  State<StatefulWidget> createState() {
    return ShareCountWidgetState(post, fontsizeIcon);
  }
}

class ShareCountWidgetState extends State<ShareCountWidget> {
  PostListDetail post;
  double fontsizeIcon;
  Color color;
  
  ShareCountWidgetState(this.post, this.fontsizeIcon);

  @override
  Widget build(BuildContext context) {
    if (post.shareControl == true) {
      color = Colors.deepOrangeAccent;
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
                  Icons.share,
                  size: fontsizeIcon,
                ),
                onPressed: () {
                  postProvider.setShareCount(post);
                },
                color: color),
            Text(
              post.share.toString(),
              style: TextStyle(fontSize: fontsizeIcon),
            )
          ],
        );
      },
    ));
  }
}
