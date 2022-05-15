import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Box.dart';
import '../service/BoxService.dart';

class BoxController extends ControllerMVC
{
  final BoxService boxService = BoxService();

  BoxController();

  BoxResult currentState = BoxResultLoading();

  void getBoxList() async
  {
    try {
      // получаем данные из репозитория
      final result = await boxService.getBoxList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = BoxGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = BoxResultFailure("$error"));
    }
  }

  void addBox(Box box) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await boxService.addBox(box);
      setState(() => currentState = BoxAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = BoxResultFailure("Нет интернета"));
    }
  }

  void getBox(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await boxService.getBox(id);
      setState(() => currentState = BoxGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = BoxResultFailure("Нет интернета"));
    }
  }

  void putBox(Box box, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await boxService.putBox(box, id);
      setState(() => currentState = BoxPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = BoxResultFailure("Нет интернета"));
    }
  }

  void deleteBox(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await boxService.deleteBox(id);
      setState(() => currentState = BoxDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = BoxResultFailure("Нет интернета"));
    }
  }
}