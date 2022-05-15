import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Store.dart';
import '../service/StoreService.dart';

class StoreController extends ControllerMVC
{
  final StoreService storeService = StoreService();

  StoreController();

  StoreResult currentState = StoreResultLoading();

  void getStoreList() async
  {
    try {
      // получаем данные из репозитория
      final result = await storeService.getStoreList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = StoreGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = StoreResultFailure("$error"));
    }
  }

  void addStore(Store store) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await storeService.addStore(store);
      setState(() => currentState = StoreAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StoreResultFailure("Нет интернета"));
    }
  }

  void getStore(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await storeService.getStore(id);
      setState(() => currentState = StoreGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StoreResultFailure("Нет интернета"));
    }
  }

  void putStore(Store store, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await storeService.putStore(store, id);
      setState(() => currentState = StorePutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StoreResultFailure("Нет интернета"));
    }
  }

  void deleteStore(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await storeService.deleteStore(id);
      setState(() => currentState = StoreDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StoreResultFailure("Нет интернета"));
    }
  }
}