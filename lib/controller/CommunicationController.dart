import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/Communication.dart';
import '../service/CommunicationService.dart';

class CommunicationController extends ControllerMVC
{
  final CommunicationService communicationService = CommunicationService();

  CommunicationController();

  CommunicationResult currentState = CommunicationResultLoading();

  void getCommunicationList() async
  {
    try {
      // получаем данные из репозитория
      final result = await communicationService.getCommunicationList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = CommunicationGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = CommunicationResultFailure("$error"));
    }
  }

  void addCommunication(Communication communication) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await communicationService.addCommunication(communication);
      setState(() => currentState = CommunicationAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = CommunicationResultFailure("Нет интернета"));
    }
  }

  void getCommunication(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await communicationService.getCommunication(id);
      setState(() => currentState = CommunicationGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = CommunicationResultFailure("Нет интернета"));
    }
  }

  void putCommunication(Communication communication, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await communicationService.putCommunication(communication, id);
      setState(() => currentState = CommunicationPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = CommunicationResultFailure("Нет интернета"));
    }
  }

  void deleteCommunication(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await communicationService.deleteCommunication(id);
      setState(() => currentState = CommunicationDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = CommunicationResultFailure("Нет интернета"));
    }
  }
}