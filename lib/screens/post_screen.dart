import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:community_app/providers/posts_provider.dart';
import 'dart:io';

//게시물의 상세화면과 댓글 작성하는 기능 제공

class PostScreen extends StatelessWidget {
  final String postId;

  PostScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostsProvider>(context)
        .posts
        .firstWhere((post) => post.id == postId);

    final _commentController = TextEditingController();

    void _addComment() {
      if (_commentController.text.isEmpty) {
        return;
      }

      final newComment = Comment(
        id: DateTime.now().toString(),
        text: _commentController.text,
      );

      Provider.of<PostsProvider>(context, listen: false)
          .addComment(postId, newComment);
      _commentController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.details),
            if (post.imageUrl.isNotEmpty) Image.file(File(post.imageUrl)),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: post.comments.length,
                itemBuilder: (context, index) {
                  final comment = post.comments[index];
                  return ListTile(
                    title: Text(comment.text),
                  );
                },
              ),
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Add a comment',
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _addComment,
            ),
          ],
        ),
      ),
    );
  }
}
