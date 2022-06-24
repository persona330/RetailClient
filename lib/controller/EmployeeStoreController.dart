import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/EmployeeStore.dart';
import '../service/EmployeeStoreService.dart';

class EmployeeStoreController extends ControllerMVC
{
  final EmployeeStoreService employeeStoreService = EmployeeStoreService();

  EmployeeStoreController();

  EmployeeStoreResult currentState = EmployeeStoreResultLoading();

  void getEmployeeStoreList() async
  {
    try {
      // получаем данные из репозитория
      final result = await employeeStoreService.getEmployeeStoreList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = EmployeeStoreGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = EmployeeStoreResultFailure("$error"));
    }
  }

  void addEmployeeStore(EmployeeStore employeeStore) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await employeeStoreService.addEmployeeStore(employeeStore);
      setState(() => currentState = EmployeeStoreAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = EmployeeStoreResultFailure("Нет интернета"));
    }
  }

  void getEmployeeStore(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await employeeStoreService.getEmployeeStore(id);
      setState(() => currentState = EmployeeStoreGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = EmployeeStoreResultFailure("Нет интернета"));
    }
  }

  void putEmployeeStore(EmployeeStore employeeStore, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await employeeStoreService.putEmployeeStore(employeeStore, id);
      setState(() => currentState = EmployeeStorePutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = EmployeeStoreResultFailure("Нет интернета"));
    }
  }

  void deleteEmployeeStore(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await employeeStoreService.deleteEmployeeStore(id);
      setState(() => currentState = EmployeeStoreDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = EmployeeStoreResultFailure("Нет интернета"));
    }
  }
}