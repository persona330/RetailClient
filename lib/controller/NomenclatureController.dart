import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Nomenclature.dart';
import '../service/NomenclatureService.dart';

class NomenclatureController extends ControllerMVC
{
  final NomenclatureService nomenclatureService = NomenclatureService();

  NomenclatureController();

  NomenclatureResult currentState = NomenclatureResultLoading();

  void getNomenclatureList() async
  {
    try {
      // получаем данные из репозитория
      final result = await nomenclatureService.getNomenclatureList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = NomenclatureGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = NomenclatureResultFailure("$error"));
    }
  }

  void addNomenclature(Nomenclature nomenclature) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await nomenclatureService.addNomenclature(nomenclature);
      setState(() => currentState = NomenclatureAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = NomenclatureResultFailure("Нет интернета"));
    }
  }

  void getNomenclature(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await nomenclatureService.getNomenclature(id);
      setState(() => currentState = NomenclatureGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = NomenclatureResultFailure("Нет интернета"));
    }
  }

  void putNomenclature(Nomenclature nomenclature, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await nomenclatureService.putNomenclature(nomenclature, id);
      setState(() => currentState = NomenclaturePutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = NomenclatureResultFailure("Нет интернета"));
    }
  }

  void deleteNomenclature(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await nomenclatureService.deleteNomenclature(id);
      setState(() => currentState = NomenclatureDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = NomenclatureResultFailure("Нет интернета"));
    }
  }
}