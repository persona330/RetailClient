import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AddressController extends ControllerMVC
{
  final AddressService addressService = AddressService();

  AddressController();

  AddressResult currentState = AddressResultLoading();

  void getAddresses() async
  {
    try {
      // получаем данные из репозитория
      final result = await addressService.getAddresses();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = AddressGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = AddressResultFailure("$error"));
    }
  }

  void addAddress(Address address) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await addressService.addAddress(address);
      setState(() => currentState = AddressAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = AddressResultFailure("Нет интернета"));
    }
  }

  void getAddress(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await addressService.getAddress(id);
      setState(() => currentState = AddressGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = AddressResultFailure("Нет интернета"));
    }
  }

  void putAddress(Address address, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await addressService.putAddress(address, id);
      setState(() => currentState = AddressPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = AddressResultFailure("Нет интернета"));
    }
  }

  void deleteAddress(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await addressService.deleteAddress(id);
      setState(() => currentState = AddressDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = AddressResultFailure("Нет интернета"));
    }
  }
}