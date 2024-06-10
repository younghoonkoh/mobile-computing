import 'package:flutter/material.dart';

//애플리케이션의 상태 관리와 관련된 로직 정의
// 게시물과 댓글 관리

class Post {
  //게시글의 구조 정의
  String title;
  String id;
  String details;
  List<String> imageUrls;
  List<Comment> comments;

  Post(
      {required this.title,
      required this.id,
      required this.details,
      required this.imageUrls,
      required this.comments});
}

class Comment {
  //댓글의 구조 정의
  String id;
  String text;

  Comment({required this.id, required this.text});
}

class PostsProvider with ChangeNotifier {
  //게시물과 댓글 관리하는 로직
  List<Post> _posts = []; //ChangeNotifier을 상속받아 상태 변경시 UI 업데이트
  //_posts -> 게시물 목록을 저장하는 리스트
  List<Post> get posts => _posts;

  void addPost(Post post) {
    //addPost() : 새로운 게시물 추가
    _posts.insert(0, post);
    notifyListeners();
  }

  void addComment(String postId, Comment comment) {
    _posts.firstWhere((post) => post.id == postId).comments.add(comment);
    notifyListeners();
  }
} //addComment() -> 특정 게시물 댓글 추가
