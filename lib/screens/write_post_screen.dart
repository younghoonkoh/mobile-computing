import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:community_app/providers/posts_provider.dart';

class WritePostScreen extends StatefulWidget {
  @override
  _WritePostScreenState createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  List<File> _images = [];

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  void _savePost() {
    if (_titleController.text.isEmpty || _detailsController.text.isEmpty) {
      return;
    }

    final newPost = Post(
      title: _titleController.text,
      id: DateTime.now().toString(),
      details: _detailsController.text,
      imageUrls: _images.map((file) => file.path).toList(), // imageUrls 매개변수 추가
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
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Enter your details'),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            Expanded(
              //사진 때문에 공간이 밀려도 overflow나지 않도록 공간 확장
              child: GridView.builder(
                itemCount: _images.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  if (index == _images.length) {
                    return IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: _pickImage,
                    );
                  }
                  return Image.file(_images[index], fit: BoxFit.cover);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
