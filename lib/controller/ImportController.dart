import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/Import.dart';
import '../service/ImportService.dart';

class ImportController extends ControllerMVC
{
  final ImportService importService = ImportService();

  ImportController();

  ImportResult currentState = ImportResultLoading();

  void getImportList() async
  {
    try {
      // получаем данные из репозитория
      final result = await importService.getImportList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = ImportGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = ImportResultFailure("$error"));
    }
  }

  void addImport(Import import) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await importService.addImport(import);
      setState(() => currentState = ImportAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ImportResultFailure("Нет интернета"));
    }
  }

  void getImport(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await importService.getImport(id);
      setState(() => currentState = ImportGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ImportResultFailure("Нет интернета"));
    }
  }

  void putImport(Import import, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await importService.putImport(import, id);
      setState(() => currentState = ImportPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ImportResultFailure("Нет интернета"));
    }
  }

  void deleteImport(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await importService.deleteImport(id);
      setState(() => currentState = ImportDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ImportResultFailure("Нет интернета"));
    }
  }
}