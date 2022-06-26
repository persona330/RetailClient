import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/Person.dart';
import '../service/PersonService.dart';

class PersonController extends ControllerMVC
{
  final PersonService personService = PersonService();

  PersonController();

  PersonResult currentState = PersonResultLoading();

  void getPersonList() async
  {
    try {
      // получаем данные из репозитория
      final result = await personService.getPersonList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = PersonGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = PersonResultFailure("$error"));
    }
  }

  void getPerson(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await personService.getPerson(id);
      setState(() => currentState = PersonGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PersonResultFailure("Нет интернета"));
    }
  }

  void deletePerson(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await personService.deletePerson(id);
      setState(() => currentState = PersonDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PersonResultFailure("Нет интернета"));
    }
  }
}