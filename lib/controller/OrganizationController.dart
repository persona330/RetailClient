import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/Organization.dart';
import '../service/OrganizationService.dart';

class OrganizationController extends ControllerMVC
{
  final OrganizationService organizationService = OrganizationService();

  OrganizationController();

  OrganizationResult currentState = OrganizationResultLoading();

  void getOrganizationList() async
  {
    try {
      // получаем данные из репозитория
      final result = await organizationService.getOrganizationList();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = OrganizationGetListResultSuccess(result));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = OrganizationResultFailure("$error"));
    }
  }

  void addOrganization(Organization organization) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await organizationService.addOrganization(organization);
      setState(() => currentState = OrganizationAddResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = OrganizationResultFailure("Нет интернета"));
    }
  }

  void getOrganization(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await organizationService.getOrganization(id);
      setState(() => currentState = OrganizationGetItemResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = OrganizationResultFailure("Нет интернета"));
    }
  }

  void putOrganization(Organization organization, int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await organizationService.putOrganization(organization, id);
      setState(() => currentState = OrganizationPutResultSuccess(result));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = OrganizationResultFailure("Нет интернета"));
    }
  }

  void deleteOrganization(int id) async
  {
    try
    {
      // Отправляем ответ серверу
      final result = await organizationService.deleteOrganization(id);
      setState(() => currentState = OrganizationDeleteResultSuccess());
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = OrganizationResultFailure("Нет интернета"));
    }
  }
}