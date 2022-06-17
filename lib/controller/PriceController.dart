import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/Price.dart';
import '../service/PriceService.dart';

class PriceController extends ControllerMVC
{
  final PriceService priceService = PriceService();

  PriceController();

  PriceResult currentState = PriceResultLoading();

  void getPriceList() async
  {
    try {
      // получаем данные из репозитория
      final result = await priceService.getPriceList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = PriceGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = PriceResultFailure("$error"));
    }
  }

  void addPrice(Price price) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await priceService.addPrice(price);
      setState(() => currentState = PriceAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PriceResultFailure("Нет интернета"));
    }
  }

  void getPrice(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await priceService.getPrice(id);
      setState(() => currentState = PriceGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PriceResultFailure("Нет интернета"));
    }
  }

  void putPrice(Price price, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await priceService.putPrice(price, id);
      setState(() => currentState = PricePutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PriceResultFailure("Нет интернета"));
    }
  }

  void deletePrice(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await priceService.deletePrice(id);
      setState(() => currentState = PriceDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PriceResultFailure("Нет интернета"));
    }
  }
}