import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/Area.dart';
import '../service/AreaService.dart';

class AreaController extends ControllerMVC
{
  final AreaService areaService = AreaService();

  AreaController();

  AreaResult currentState = AreaResultLoading();

  void getAreaList() async
  {
    try {
      // получаем данные из репозитория
      final result = await areaService.getAreaList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = AreaGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = AreaResultFailure("$error"));
    }
  }

  void addArea(Area area) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await areaService.addArea(area);
      setState(() => currentState = AreaAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = AreaResultFailure("Нет интернета"));
    }
  }

  void getArea(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await areaService.getArea(id);
      setState(() => currentState = AreaGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = AreaResultFailure("Нет интернета"));
    }
  }

  void putArea(Area area, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await areaService.putArea(area, id);
      setState(() => currentState = AreaPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = AreaResultFailure("Нет интернета"));
    }
  }

  void deleteArea(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await areaService.deleteArea(id);
      setState(() => currentState = AreaDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = AreaResultFailure("Нет интернета"));
    }
  }
}