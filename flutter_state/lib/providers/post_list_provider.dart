import 'package:flutter/material.dart';
import 'package:flutter_state/models/comment.dart';
import 'package:flutter_state/models/post.dart';
import 'package:flutter_state/models/post_list_detail.dart';

class PostListProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<PostListDetail> _postList = [];

  setCleanPostList() {
    _postList = [];
  }

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<PostListDetail> get postsList => _postList;

  setPostList(List<Post> list) {
    list.forEach((post) {
      PostListDetail postDetail =
          PostListDetail(post, 0, 0, 0, 0, false, false, false, false);
      _postList.add(postDetail);
    });

    notifyListeners();
  }

  //--
  //--

  setCommentCount(PostListDetail post) {
    if (post.commentControl) {
      post.comment = post.comment - 1;
      post.commentControl = false;
    } else {
      post.comment = post.comment + 1;
      post.commentControl = true;
    }

    notifyListeners();
  }

  setRepostCount(PostListDetail post) {
    if (post.repostControl) {
      post.repost = post.repost - 1;
      post.repostControl = false;
    } else {
      post.repost = post.repost + 1;
      post.repostControl = true;
    }

    notifyListeners();
  }

  setLikeCount(PostListDetail post) {
    if (post.likeControl) {
      post.like = post.like - 1;
      post.likeControl = false;
    } else {
      post.like = post.like + 1;
      post.likeControl = true;
    }
    notifyListeners();
  }

  setShareCount(PostListDetail post) {
    if (post.shareControl) {
      post.share = post.share - 1;
      post.shareControl = false;
    } else {
      post.share = post.share + 1;
      post.shareControl = true;
    }
    notifyListeners();
  }

  // ----
  // ----

  bool _isDetailProcessing = true;
  Post _post;
  List<Comment> _comments = [];

  setCleanCommentList() {
    _comments = [];
  }

  bool get isDetailProcessing => _isDetailProcessing;

  setisDetailProcessing(bool value) {
    _isDetailProcessing = value;
    notifyListeners();
  }

  Post get post => _post;

  setPost(Post post) {
    _post = post;
    notifyListeners();
  }

  List<Comment> get comments => _comments;

  setComments(List<Comment> commentList) {
    commentList.forEach((comment) {
      _comments.add(comment);
    });

    setisDetailProcessing(false);
    notifyListeners();
  }
}
