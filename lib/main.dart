import 'package:flutter/material.dart';
import 'package:retail/page/address/CreateAddressPage.dart';
import 'package:retail/page/address/GetAllAddreessPage.dart';
import 'package:retail/page/HomePage.dart';

// Запускает главное окно приложения. Принимает виджет.
void main() => runApp(const MyApp());

// Главный класс
// StatelessWidget для неизменяетмых виджетов
class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  // build - для построения интерфейса
  @override
  Widget build(BuildContext context)
  {
    // MaterialApp - для создания графического интерфейса, навигации
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Подсистема "Склад"',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home - задает базовый виджет, отображаемый при загрузке
      home: const HomePage(title: 'Главная'),
    );
  }
}





