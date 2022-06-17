import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Area.dart';
import '../model/Product.dart';
import '../service/AreaService.dart';
import '../service/ProductService.dart';

class ProductController extends ControllerMVC
{
  final ProductService productService = ProductService();

  ProductController();

  ProductResult currentState = ProductResultLoading();

  void getProductList() async
  {
    try {
      // получаем данные из репозитория
      final result = await productService.getProductList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = ProductGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = ProductResultFailure("$error"));
    }
  }

  void addProduct(Product product) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await productService.addProduct(product);
      setState(() => currentState = ProductAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ProductResultFailure("Нет интернета"));
    }
  }

  void getProduct(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await productService.getProduct(id);
      setState(() => currentState = ProductGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ProductResultFailure("Нет интернета"));
    }
  }

  void putProduct(Product product, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await productService.putProduct(product, id);
      setState(() => currentState = ProductPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ProductResultFailure("Нет интернета"));
    }
  }

  void deleteProduct(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await productService.deleteProduct(id);
      setState(() => currentState = ProductDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ProductResultFailure("Нет интернета"));
    }
  }
}