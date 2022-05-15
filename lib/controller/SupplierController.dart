import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Supplier.dart';
import '../service/SupplierService.dart';

class SupplierController extends ControllerMVC
{
  final SupplierService supplierService = SupplierService();

  SupplierController();

  SupplierResult currentState = SupplierResultLoading();

  void getSupplierList() async
  {
    try {
      // получаем данные из репозитория
      final result = await supplierService.getSupplierList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = SupplierGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = SupplierResultFailure("$error"));
    }
  }

  void addSupplier(Supplier supplier) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await supplierService.addSupplier(supplier);
      setState(() => currentState = SupplierAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = SupplierResultFailure("Нет интернета"));
    }
  }

  void getSupplier(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await supplierService.getSupplier(id);
      setState(() => currentState = SupplierGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = SupplierResultFailure("Нет интернета"));
    }
  }

  void putSupplier(Supplier supplier, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await supplierService.putSupplier(supplier, id);
      setState(() => currentState = SupplierPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = SupplierResultFailure("Нет интернета"));
    }
  }

  void deleteSupplier(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await supplierService.deleteSupplier(id);
      setState(() => currentState = SupplierDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = SupplierResultFailure("Нет интернета"));
    }
  }
}