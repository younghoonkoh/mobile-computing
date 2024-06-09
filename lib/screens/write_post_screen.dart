import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:community_app/providers/posts_provider.dart';
import 'dart:io';

//새 게시물 작성 화면

class WritePostScreen extends StatefulWidget {
  @override
  _WritePostScreenState createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  final _titleController = TextEditingController();
  // TextEditingController -> 텍스트 입력 필드 제어
  final _detailsController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    // Future<void> _pickImage() : 이미지 선택 함수
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    //ImagePicker -> 이미지를 선택하기 위한 패키지
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _savePost() {
    //_savePost() : 새 게시물 저장하는 함수
    if (_titleController.text.isEmpty || _detailsController.text.isEmpty) {
      return;
    }

    final newPost = Post(
      title: _titleController.text,
      id: DateTime.now().toString(),
      details: _detailsController.text,
      imageUrl: _image?.path ?? '',
      comments: [],
    );

    Provider.of<PostsProvider>(context, listen: false).addPost(newPost);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write Post'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _savePost,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              //TextField 제목과 내용을 입력하는 필드 제공
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Enter your details'),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            _image == null ? Text('No image selected.') : Image.file(_image!),
            IconButton(
              //IconButton : 카메라 아이콘 누르면 이미지 선택 가능
              icon: Icon(Icons.camera_alt),
              onPressed: _pickImage,
            ),
          ],
        ),
      ),
    );
  }
}
