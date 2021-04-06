import 'package:flutter_state/models/post.dart';

class PostListDetail {
  Post post;
  int comment;
  int repost;
  int like;
  int share;
  bool commentControl;
  bool repostControl;
  bool likeControl;
  bool shareControl;

  PostListDetail(
      this.post,
      this.comment,
      this.repost,
      this.like,
      this.share,
      this.commentControl,
      this.repostControl,
      this.likeControl,
      this.shareControl);
}
