import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Producer.dart';
import '../service/ProducerService.dart';

class ProducerController extends ControllerMVC
{
  final ProducerService producerService = ProducerService();

  ProducerController();

  ProducerResult currentState = ProducerResultLoading();

  void getProducerList() async
  {
    try {
      // получаем данные из репозитория
      final result = await producerService.getProducerList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = ProducerGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = ProducerResultFailure("$error"));
    }
  }

  void addProducer(Producer producer) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await producerService.addProducer(producer);
      setState(() => currentState = ProducerAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ProducerResultFailure("Нет интернета"));
    }
  }

  void getProducer(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await producerService.getProducer(id);
      setState(() => currentState = ProducerGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ProducerResultFailure("Нет интернета"));
    }
  }

  void putProducer(Producer producer, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await producerService.putProducer(producer, id);
      setState(() => currentState = ProducerPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ProducerResultFailure("Нет интернета"));
    }
  }

  void deleteProducer(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await producerService.deleteProducer(id);
      setState(() => currentState = ProducerDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ProducerResultFailure("Нет интернета"));
    }
  }
}