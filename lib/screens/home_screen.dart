import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'write_post_screen.dart';
import 'post_screen.dart';
import '../providers/posts_provider.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community App'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // 오른쪽 여백 설정
            child: IconButton(
              icon: Image.asset('assets/images/write_icon.png',
                  width: 70, height: 70),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WritePostScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer<PostsProvider>(
        builder: (context, postsProvider, child) {
          return ListView.builder(
            itemCount: postsProvider.posts.length,
            itemBuilder: (context, index) {
              final post = postsProvider.posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.id),
                leading: post.imageUrls.isNotEmpty
                    ? Image.file(
                        File(post.imageUrls.first), // 첫 번째 이미지를 표시
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : null, //사진 첨부
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.comment),
                    Text(post.comments.length.toString()),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScreen(postId: post.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/home.png', width: 70, height: 70),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/images/network.png', width: 70, height: 70),
            label: 'NETWORK',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/store.png', width: 70, height: 70),
            label: 'STORE',
          ),
        ],
      ),
    );
  }
}
