import 'package:retail/model/Address.dart';
import 'package:retail/model/Post.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/service/PostService.dart';

class PostController extends ControllerMVC
{
  final PostService postService = PostService();

  PostController();

  PostResult currentState = PostResultLoading();

  void init() async
  {
    try {
      // получаем данные из репозитория
      final postList = await postService.getPosts();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = PostResultSuccess(postList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = PostResultFailure("Нет интернета"));
    }
  }
}