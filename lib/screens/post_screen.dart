import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:community_app/providers/posts_provider.dart';
import 'dart:io';

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
            Text(
              post.details,
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView(
                children: [
                  if (post.imageUrls.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: post.imageUrls.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Image.file(File(post.imageUrls[index]),
                            fit: BoxFit.cover);
                      },
                    ),
                  Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: post.comments.length,
                    itemBuilder: (context, index) {
                      final comment = post.comments[index];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 8.0),
                            title: Text(comment.text),
                          ),
                          Divider(height: 1),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(), // 댓글 입력 필드 위에 구분선 추가
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Add a comment',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
