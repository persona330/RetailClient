import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/controller/PostController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/model/Post.dart';
import 'package:retail/page/ItemAddressPage.dart';
import 'package:retail/page/ItemPostPage.dart';
import 'package:retail/page/ShowAddressPage.dart';

class ListAddressPage extends StatefulWidget
{
  @override
  _ListAddressPageState createState() => _ListAddressPageState();
}

// не забываем расширяться от StateMVC
class _ListAddressPageState extends StateMVC {

  // ссылка на наш контроллер
  late PostController _controller;

  // передаем наш контроллер StateMVC конструктору и
  // получаем на него ссылку
  _ListAddressPageState() : super(PostController()) {
    _controller = controller as PostController;
  }

  // после инициализации состояние
  // мы запрашивает данные у сервера
  @override
  void initState() {
    super.initState();
    _controller.init();
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
      final posts = (state as PostResultSuccess).postList;
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAddressPage(id: posts[index].id!, body: posts[index].body!)));
              },
              child: ItemAddressPage(posts[index]),
            );
          },
        ),
      );
    }
  }


}