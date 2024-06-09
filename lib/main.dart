import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:community_app/screens/home_screen.dart';
import 'package:community_app/providers/posts_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // 상태 관리를 위해 provider 패키지를 사용
      create: (context) => PostsProvider(),
      child: MaterialApp(
        title: 'Community App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}


// provider 패키지를 사용해 PostsProvider 제공

