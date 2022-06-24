import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/Employee.dart';
import '../service/EmployeeService.dart';

class EmployeeController extends ControllerMVC
{
  final EmployeeService employeeService = EmployeeService();

  EmployeeController();

  EmployeeResult currentState = EmployeeResultLoading();

  void getEmployeeList() async
  {
    try {
      // получаем данные из репозитория
      final result = await employeeService.getEmployeeList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = EmployeeGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = EmployeeResultFailure("$error"));
    }
  }

  void getEmployee(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await employeeService.getEmployee(id);
      setState(() => currentState = EmployeeGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = EmployeeResultFailure("Нет интернета"));
    }
  }

  void deleteEmployee(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await employeeService.deleteEmployee(id);
      setState(() => currentState = EmployeeDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = EmployeeResultFailure("Нет интернета"));
    }
  }
}