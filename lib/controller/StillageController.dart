import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Stillage.dart';
import '../service/StillageService.dart';

class StillageController extends ControllerMVC
{
  final StillageService stillageService = StillageService();

  StillageController();

  StillageResult currentState = StillageResultLoading();

  void getStillageList() async
  {
    try {
      // получаем данные из репозитория
      final result = await stillageService.getStillageList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = StillageGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = StillageResultFailure("$error"));
    }
  }

  void addStillage(Stillage stillage) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await stillageService.addStillage(stillage);
      setState(() => currentState = StillageAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StillageResultFailure("Нет интернета"));
    }
  }

  void getStillage(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await stillageService.getStillage(id);
      setState(() => currentState = StillageGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StillageResultFailure("Нет интернета"));
    }
  }

  void putStillage(Stillage stillage, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await stillageService.putStillage(stillage, id);
      setState(() => currentState = StillagePutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StillageResultFailure("Нет интернета"));
    }
  }

  void deleteStillage(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await stillageService.deleteStillage(id);
      setState(() => currentState = StillageDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = StillageResultFailure("Нет интернета"));
    }
  }
}