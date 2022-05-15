import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Shelf.dart';
import '../service/ShelfService.dart';

class ShelfController extends ControllerMVC
{
  final ShelfService shelfService = ShelfService();

  ShelfController();

  ShelfResult currentState = ShelfResultLoading();

  void getShelfList() async
  {
    try {
      // получаем данные из репозитория
      final result = await shelfService.getShelfList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = ShelfGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = ShelfResultFailure("$error"));
    }
  }

  void addShelf(Shelf shelf) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await shelfService.addShelf(shelf);
      setState(() => currentState = ShelfAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ShelfResultFailure("Нет интернета"));
    }
  }

  void getShelf(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await shelfService.getShelf(id);
      setState(() => currentState = ShelfGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ShelfResultFailure("Нет интернета"));
    }
  }

  void putShelf(Shelf shelf, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await shelfService.putShelf(shelf, id);
      setState(() => currentState = ShelfPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ShelfResultFailure("Нет интернета"));
    }
  }

  void deleteShelf(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await shelfService.deleteShelf(id);
      setState(() => currentState = ShelfDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ShelfResultFailure("Нет интернета"));
    }
  }
}