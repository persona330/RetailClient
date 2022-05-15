import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/VerticalSections.dart';
import '../service/VerticalSectionsService.dart';

class VerticalSectionsController extends ControllerMVC
{
  final VerticalSectionsService verticalSectionsService = VerticalSectionsService();

  VerticalSectionsController();

  VerticalSectionsResult currentState = VerticalSectionsResultLoading();

  void getVerticalSectionsList() async
  {
    try {
      // получаем данные из репозитория
      final result = await verticalSectionsService.getVerticalSectionsList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = VerticalSectionsGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = VerticalSectionsResultFailure("$error"));
    }
  }

  void addVerticalSections(VerticalSections verticalSections) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await verticalSectionsService.addVerticalSections(verticalSections);
      setState(() => currentState = VerticalSectionsAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = VerticalSectionsResultFailure("Нет интернета"));
    }
  }

  void getVerticalSections(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await verticalSectionsService.getVerticalSections(id);
      setState(() => currentState = VerticalSectionsGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = VerticalSectionsResultFailure("Нет интернета"));
    }
  }

  void putVerticalSections(VerticalSections verticalSections, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await verticalSectionsService.putVerticalSections(verticalSections, id);
      setState(() => currentState = VerticalSectionsPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = VerticalSectionsResultFailure("Нет интернета"));
    }
  }

  void deleteVerticalSections(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await verticalSectionsService.deleteVerticalSections(id);
      setState(() => currentState = VerticalSectionsDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = VerticalSectionsResultFailure("Нет интернета"));
    }
  }
}