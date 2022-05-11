import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AddressController extends ControllerMVC
{
  final AddressService addressService = AddressService();

  AddressController();

  AddressResult currentState = AddressResultLoading();

  void init() async
  {
    try {
      // получаем данные из репозитория
      final addressList = await addressService.getAddresses();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = AddressResultSuccess(addressList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = AddressResultFailure("$error"));
    }
  }
}