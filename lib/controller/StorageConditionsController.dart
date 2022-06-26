import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/StorageConditions.dart';
import '../service/StorageConditionsService.dart';

class StorageConditionsController extends ControllerMVC
{
  final StorageConditionsService storageConditionsService = StorageConditionsService();

  StorageConditionsController();

  StorageConditionsResult currentState = StorageConditionsResultLoading();

  void getStorageConditionsList() async
  {
    try {
      // получаем данные из репозитория
      final result = await storageConditionsService.getStorageConditionsList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = StorageConditionsGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = StorageConditionsResultFailure("$error"));
    }
  }

  void addStorageConditions(StorageConditions storageConditions) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await storageConditionsService.addStorageConditions(storageConditions);
      setState(() => currentState = StorageConditionsAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StorageConditionsResultFailure("Нет интернета"));
    }
  }

  void getStorageConditions(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await storageConditionsService.getStorageConditions(id);
      setState(() => currentState = StorageConditionsGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StorageConditionsResultFailure("Нет интернета"));
    }
  }

  void putStorageConditions(StorageConditions storageConditions, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await storageConditionsService.putStorageConditions(storageConditions, id);
      setState(() => currentState = StorageConditionsPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StorageConditionsResultFailure("Нет интернета"));
    }
  }

  void deleteStorageConditions(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await storageConditionsService.deleteStorageConditions(id);
      setState(() => currentState = StorageConditionsDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StorageConditionsResultFailure("Нет интернета"));
    }
  }
}