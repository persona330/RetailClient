import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/Measurement.dart';
import '../service/MeasurementService.dart';

class MeasurementController extends ControllerMVC
{
  final MeasurementService measurementService = MeasurementService();

  MeasurementController();

  MeasurementResult currentState = MeasurementResultLoading();

  void getMeasurementList() async
  {
    try {
      // получаем данные из репозитория
      final result = await measurementService.getMeasurementList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = MeasurementGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = MeasurementResultFailure("$error"));
    }
  }

  void addMeasurement(Measurement measurement) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await measurementService.addMeasurement(measurement);
      setState(() => currentState = MeasurementAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = MeasurementResultFailure("Нет интернета"));
    }
  }

  void getMeasurement(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await measurementService.getMeasurement(id);
      setState(() => currentState = MeasurementGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = MeasurementResultFailure("Нет интернета"));
    }
  }

  void putMeasurement(Measurement measurement, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await measurementService.putMeasurement(measurement, id);
      setState(() => currentState = MeasurementPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = MeasurementResultFailure("Нет интернета"));
    }
  }

  void deleteMeasurement(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await measurementService.deleteMeasurement(id);
      setState(() => currentState = MeasurementDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = MeasurementResultFailure("Нет интернета"));
    }
  }
}