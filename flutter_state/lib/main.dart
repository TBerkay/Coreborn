import 'package:flutter/material.dart';
import 'package:flutter_state/providers/post_list_provider.dart';
import 'package:flutter_state/providers/user_list_provider.dart';
import 'package:flutter_state/screens/post_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PostListProvider>(create: (_) => PostListProvider()),
        ChangeNotifierProvider<UserListProvider>(create: (_) => UserListProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.blueAccent),
        home: PostList(),
      ),
    );
  }
}
