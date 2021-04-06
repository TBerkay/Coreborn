import 'package:flutter/material.dart';
import 'package:flutter_state/models/album.dart';
import 'package:flutter_state/models/post.dart';
import 'package:flutter_state/models/user.dart';
import 'package:flutter_state/models/user_list_detail.dart';

class UserListProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<UserListCount> _userListCount = [];

  setCleanUserList() {
    _userListCount = [];
  }

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<UserListCount> get userListCount => _userListCount;

  setUserListCount(
      List<User> userList, List<Album> albumList, List<Post> postList) {
    userList.forEach((user) {
      int albumCount = 0;
      int postCount = 0;

      albumList.forEach((album) {
        if (user.id == album.userId) {
          albumCount++;
        }

      });

      postList.forEach((post) {
        if (user.id == post.userId) {
          postCount++;
        }

      });

      UserListCount userCount = UserListCount(user, albumCount, postCount);
      _userListCount.add(userCount);
    });

    notifyListeners();
  }
}
