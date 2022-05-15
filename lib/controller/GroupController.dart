import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Group.dart';
import '../service/GroupService.dart';

class GroupController extends ControllerMVC
{
  final GroupService groupService = GroupService();

  GroupController();

  GroupResult currentState = GroupResultLoading();

  void getGroupList() async
  {
    try {
      // получаем данные из репозитория
      final result = await groupService.getGroupList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = GroupGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = GroupResultFailure("$error"));
    }
  }

  void addGroup(Group group) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await groupService.addGroup(group);
      setState(() => currentState = GroupAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = GroupResultFailure("Нет интернета"));
    }
  }

  void getGroup(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await groupService.getGroup(id);
      setState(() => currentState = GroupGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = GroupResultFailure("Нет интернета"));
    }
  }

  void putGroup(Group group, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await groupService.putGroup(group, id);
      setState(() => currentState = GroupPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = GroupResultFailure("Нет интернета"));
    }
  }

  void deleteGroup(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await groupService.deleteGroup(id);
      setState(() => currentState = GroupDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = GroupResultFailure("Нет интернета"));
    }
  }
}