import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Position.dart';
import '../service/PositionService.dart';

class PositionController extends ControllerMVC
{
  final PositionService positionService = PositionService();

  PositionController();

  PositionResult currentState = PositionResultLoading();

  void getPositionList() async
  {
    try {
      // получаем данные из репозитория
      final result = await positionService.getPositionList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = PositionGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = PositionResultFailure("$error"));
    }
  }

  void addPosition(Position position) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await positionService.addPosition(position);
      setState(() => currentState = PositionAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PositionResultFailure("Нет интернета"));
    }
  }

  void getPosition(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await positionService.getPosition(id);
      setState(() => currentState = PositionGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PositionResultFailure("Нет интернета"));
    }
  }

  void putPosition(Position position, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await positionService.putPosition(position, id);
      setState(() => currentState = PositionPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PositionResultFailure("Нет интернета"));
    }
  }

  void deletePosition(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await positionService.deletePosition(id);
      setState(() => currentState = PositionDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PositionResultFailure("Нет интернета"));
    }
  }
}