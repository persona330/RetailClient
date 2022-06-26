import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/ConsignmentNote.dart';
import '../service/ConsignmentNoteService.dart';

class ConsignmentNoteController extends ControllerMVC
{
  final ConsignmentNoteService consignmentNoteService = ConsignmentNoteService();

  ConsignmentNoteController();

  ConsignmentNoteResult currentState = ConsignmentNoteResultLoading();

  void getConsignmentNoteList() async
  {
    try {
      // получаем данные из репозитория
      final result = await consignmentNoteService.getConsignmentNoteList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = ConsignmentNoteGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = ConsignmentNoteResultFailure("$error"));
    }
  }

  void addConsignmentNote(ConsignmentNote consignmentNote) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await consignmentNoteService.addConsignmentNote(consignmentNote);
      setState(() => currentState = ConsignmentNoteAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ConsignmentNoteResultFailure("Нет интернета"));
    }
  }

  void getConsignmentNote(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await consignmentNoteService.getConsignmentNote(id);
      setState(() => currentState = ConsignmentNoteGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ConsignmentNoteResultFailure("Нет интернета"));
    }
  }

  void putConsignmentNote(ConsignmentNote consignmentNote, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await consignmentNoteService.putConsignmentNote(consignmentNote, id);
      setState(() => currentState = ConsignmentNotePutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ConsignmentNoteResultFailure("Нет интернета"));
    }
  }

  void deleteConsignmentNote(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await consignmentNoteService.deleteConsignmentNote(id);
      setState(() => currentState = ConsignmentNoteDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = ConsignmentNoteResultFailure("Нет интернета"));
    }
  }
}