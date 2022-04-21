import 'package:flutter/material.dart';

class CreateAddressPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: Text('Создание адреса')),
      body:  Scrollbar(
          child: Container(
          // this.left, this.top, this.right, this.bottom
            padding: EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: const [
                TextField(
                  decoration: InputDecoration(
                      labelText: "Номер квартиры",
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  maxLines: 1,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Номер подъезда",
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Номер дома",
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Название улицы",
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Наименование региона",
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Название населенного пункта",
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Наименование страны",
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ],
            ),
          ),
      ),
    );
  }
}