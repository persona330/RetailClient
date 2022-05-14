import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/PostController.dart';
import 'package:retail/model/Post.dart';
import 'package:retail/page/test/ItemPostPage.dart';
import 'package:retail/page/address/GetAddressPage.dart';

class ListPostPage extends StatefulWidget
{
  @override
  _ListPostPageState createState() => _ListPostPageState();
}

// не забываем расширяться от StateMVC
class _ListPostPageState extends StateMVC {

  // ссылка на наш контроллер
  late PostController _controller;

  // передаем наш контроллер StateMVC конструктору и
  // получаем на него ссылку
  _ListPostPageState() : super(PostController()) {
    _controller = controller as PostController;
  }

  // после инициализации состояние
  // мы запрашивает данные у сервера
  @override
  void initState() {
    super.initState();
    _controller.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post List Page"),
        ),
        body: _buildContent()
    );
  }

  Widget _buildContent() {
    // первым делом получаем текущее состояние
    final state = _controller.currentState;
    if (state is PostResultLoading) {
      // загрузка
      return const Center(child: CircularProgressIndicator());
    } else if (state is PostResultFailure) {
      // ошибка
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      // отображаем список постов
      final posts = (state as PostGetListResultSuccess).postList;
      return Padding(
        padding: EdgeInsets.all(10),
        // ListView.builder создает элемент списка
        // только когда он видим на экране
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            // мы вынесли элемент списка в
            // отдельный виджет
            return GestureDetector(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GetAddressPage(id: posts[index].id!)));
              },
              child: ItemPostPage(posts[index]),
            );
          },
        ),
      );
    }
  }


}