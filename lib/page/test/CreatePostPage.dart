import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/PostController.dart';
import 'package:retail/model/Post.dart';
import 'package:retail/service/PostService.dart';

class CreatePostPage extends StatefulWidget
{
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends StateMVC
{
  PostController? _controller;

  PostService _postService = PostService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  // получаем PostController
  _CreatePostPageState() : super(PostController()) {_controller = controller as PostController;}

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Создание адреса'),
            actions: [
              // пункт меню в AppBar
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  final state = _controller?.currentState;
                  // сначала запускаем валидацию формы
                  final post = Post(userId: 1, id: 1, title: titleController.text, body: bodyController.text);

                  if (state is PostAddResultSuccess)
                  {
                    print("Все ок");
                    //_postService.addPost(post);
                    Navigator.pop(context, true);
                  }
                  if (state is PostResultLoading)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$CircularProgressIndicator")));
                  }
                  if (state is PostResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                },
              )
            ],
        ),
        body:  Scrollbar(
          child: Container(
          // this.left, this.top, this.right, this.bottom
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                // поля для ввода заголовка
                TextFormField(
                  // указываем для поля границу,
                  // иконку и подсказку (hint)
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.face),
                      hintText: "Заголовок"
                  ),
                  // указываем контроллер
                  controller: titleController,
                ),
                // небольшой отступ между полями
                SizedBox(height: 10),
                // Expanded означает, что мы должны
                // расширить наше поле на все доступное пространство
                Expanded(
                  child: TextFormField(
                    // maxLines: null и expands: true
                    // указаны только для расширения поля на всю
                    // доступную высоту
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Содержание",
                    ),
                    // указываем контроллер
                    controller: bodyController,
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}