import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/BoxController.dart';
import '../../model/Box.dart';

class CreateBoxPage extends StatefulWidget
{
  CreateBoxPage({Key? key}) : super(key: key);

  @override
  _CreateBoxPageState createState() => _CreateBoxPageState();
}

class _CreateBoxPageState extends StateMVC
{
  BoxController? _controller;

  _CreateBoxPageState() : super(BoxController()) {_controller = controller as BoxController;}

  final _numberController = TextEditingController();
  final _sizeController = TextEditingController();

  List<String> _shelfList = ["Полка 1", "Полка 2"];
  List<String> _verticalSectionsList = ["Вертикальная секция 1", "Вертикальная секция 2"];
  late String _shelf = _shelfList[0].toString();
  late String _verticalSections = _verticalSectionsList[0].toString();

  @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _numberController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание ячейки')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Номер"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _numberController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Вместимость"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _sizeController,
                  textInputAction: TextInputAction.next,
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Полка",),
                    items: _shelfList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item)
                    {
                      setState(() {_shelf = item!;});
                    }
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Полка",),
                    items: _verticalSectionsList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item)
                    {
                      setState(() {_verticalSections = item!;});
                    }
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    //Address _address = Address(idAddress: 1, apartment:_apartmentController.text, entrance: int.parse(_entranceController.text), house: _houseController.text, street: _streetController.text, region: _regionController.text, city: _cityController.text, nation: _nationController.text);
                    //_controller?.addAddress(_address);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is BoxAddResultSuccess)
                    {
                      print("Все ок");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Добавлен")));
                    }
                    if (state is BoxResultLoading)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Загрузка")));
                    }
                    if (state is BoxResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Отправить'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}