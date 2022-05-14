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

  void getPosts() async
  {
    try {
      // получаем данные из репозитория
      final result = await postService.getPosts();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = PostGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = PostResultFailure("Нет интернета"));
    }
  }

  void addPost(Post post) async
  {
    try {
      final result = await postService.addPost(post);
      // сервер вернул результат
      setState(() => currentState = PostAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PostResultFailure("Нет интернета"));
    }
  }
}